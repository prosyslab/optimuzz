#!/usr/bin/env python3

import argparse
from pathlib import Path
import logging
import pydot
import networkx as nx
import sys
from collections import defaultdict

parser = argparse.ArgumentParser()
parser.add_argument("cfg_dir", help="directory of CFG files and callgraph.txt")
parser.add_argument('targets_file', help="file containing <target_file>:<target_line> pairs")
args = parser.parse_args()

logging.basicConfig(
    filename='cfg_preprocess.log',
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

cfg_dir = Path(args.cfg_dir)

def parse_target_file(targets_file):
    targets = []
    with open(targets_file, 'r') as f:
        for line in f:
            target_file, target_line = line.strip().split(':')
            target_line = int(target_line)
            targets.append((target_file, target_line))

    for target in targets:
        print(f'* user target {target[0]}:{target[1]}', file=sys.stderr)

    return targets

def translate_target(target_file, target_line, target_blocks_map_file):
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2933
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2933
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2933
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2933
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2933
    # target-blocks-map.txt:simplified-lowering.cc:2927 ../../src/compiler/simplified-lowering.cc:2934
    targets = []
    assert target_blocks_map_file.exists()
    with open(target_blocks_map_file, 'r') as f:
        for line in f:
            bbid, target = line.strip().split(' ')
            if f'{target_file}:{target_line}' in target:
                filename, lineno = bbid.split(':')
                lineno = int(lineno)
                targets.append((filename, lineno))
    return list(set(targets))

user_targets = parse_target_file(args.targets_file)
assert len(user_targets) > 0, f'No targets found in {args.targets_file}'

targets = []
for filename, lineno in user_targets:
    t = translate_target(filename, lineno, cfg_dir / 'target-blocks-map.txt')
    targets.extend(t)

for t in targets:
    print(f'* target {t[0]}:{t[1]}', file=sys.stderr)

assert len(targets) > 0, f'No targets found in {cfg_dir / "target-blocks-map.txt"}'

# each line looks like
# simplified-lowering.cc:_ZN2v88internal8compiler22RepresentationSelector12EnqueueInputILNS1_5PhaseE0EEEvPNS1_4NodeEiNS1_7UseInfoE:0:0:384103392 _ZN2v88internal8compiler22RepresentationSelector7GetInfoEPNS1_4NodeE
def parse_callgraph(callgraph_txt):
    calledges = []
    with open(callgraph_txt, 'r') as f:
        for line in f:
            caller, callee = line.strip().split()
            filename, funcname, lineno, order, bbid = caller.split(':')
            edge = (filename, funcname, lineno, order, hex(int(bbid))), callee
            calledges.append(edge)
    return calledges


def merge_cfgs(cfgs, callgraph):
    merged = nx.MultiDiGraph()
    for cfg in cfgs:
        merged = nx.compose(merged, cfg)

    for caller, callee in callgraph:
        _filename, _funcname, _lineno, _order, bbid = caller
        node = 'Node' + bbid
        assert node in merged, f'Node {node} not found in entire CFG'
        if callee in func_to_node:
            merged.add_edge(node, func_to_node[callee], weight=10)

    # print('nodes in the merged graph', merged.nodes(data=True), file=sys.stderr)
    # print('edges in the merged graph', merged.edges(keys=True, data=True), file=sys.stderr)

    return merged

target_nodes = []

# need to extract (function name -> first block id)
def parse_cfg(cfg_file, targets):
    graph: pydot.Graph = pydot.graph_from_dot_file(cfg_file)[0]
    graph: nx.MultiDiGraph = nx.drawing.nx_pydot.from_pydot(graph)
    for u, v, k, d in graph.edges(keys=True, data=True):
        d['weight'] = 1

    for n, d in graph.nodes(data=True):
        label = d['label'].strip('{}"')
        filename, funcname, lineno, order = label.split(':')
        d['filename'] = filename
        d['funcname'] = funcname
        d['lineno'] = int(lineno)
        d['order'] = int(order)

        for filename, lineno in targets:
            if d['filename'] in filename and d['lineno'] == lineno:
                target_nodes.append(n)
                logging.info(f'Found target node {n} in {cfg_file}')
                break

    return graph

def parse_cfgs(cfg_dir, targets):
    cfgs = []
    for f in cfg_dir.glob('*.dot'):
        g = parse_cfg(f, targets)
        cfgs.append(g)
    return cfgs

def build_funcmap(cfgs):
    func_to_node = {}
    for g in cfgs:
        the_node = min(g.nodes(data=True), key=lambda n: n[1]['order'])
        func_to_node[g.name] = the_node[0]
    return func_to_node


callgraph = parse_callgraph(cfg_dir / 'callgraph.txt')
cfgs = parse_cfgs(cfg_dir, targets)
func_to_node = build_funcmap(cfgs)

print(f'{len(cfgs)} CFG files found in {cfg_dir}', file=sys.stderr)
print(f'{len(target_nodes)} target nodes found', file=sys.stderr)
print(f'{len(callgraph)} call edges found', file=sys.stderr)

node_cnt = sum([cfg.number_of_nodes() for cfg in cfgs])
edge_cnt = sum([cfg.number_of_edges() for cfg in cfgs])

print(f'Total number of nodes: {node_cnt}', file=sys.stderr)
print(f'Total number of edges: {edge_cnt}', file=sys.stderr)

entire_cfg = merge_cfgs(cfgs, callgraph)

fulldistmap = defaultdict(list)
for v in target_nodes:
    distmap = nx.single_source_dijkstra_path_length(entire_cfg, v)
    for n, distance in distmap.items():
        fulldistmap[n].append(distance)

for n, distances in fulldistmap.items():
    bbid = n[4:]
    # compute harmonic mean
    if 0 not in distances:
        harmonic_mean = len(distances) / sum([1/d for d in distances])
        print(f'{bbid} {harmonic_mean}')
    else:
        print(f'{bbid} 0.0')

