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

targets = []

for line in open(args.targets_file):
    target_file, target_line = line.strip().split(':')
    target_line = int(target_line)
    targets.append((target_file, target_line))

    print(target_file, target_line, file=sys.stderr)

for target in targets:
    logging.info(f'Target: {target[0]}:{target[1]}')

# each line looks like
# simplified-lowering.cc:_ZN2v88internal8compiler22RepresentationSelector12EnqueueInputILNS1_5PhaseE0EEEvPNS1_4NodeEiNS1_7UseInfoE:0:0:384103392 _ZN2v88internal8compiler22RepresentationSelector7GetInfoEPNS1_4NodeE
def parse_callgraph(callgraph_txt):
    with open(callgraph_txt, 'r') as f:
        for line in f:
            caller, callee = line.strip().split()
            # print(f'{caller} -> {callee}')
            filename, funcname, lineno, order, bbid = caller.split(':')
            yield (filename, funcname, lineno, order, hex(int(bbid))), callee

target_nodes = []

# need to extract (function name -> first block id)
def parse_cfg(cfg_file):
    graph: pydot.Graph = pydot.graph_from_dot_file(cfg_file)[0]
    graph: nx.MultiDiGraph = nx.drawing.nx_pydot.from_pydot(graph)
    # print('graph name', graph.name)
    # set edge weight as 1
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

    # print('graph nodes', graph.nodes(data=True))
    # print('graph edges', graph.edges(keys=True, data=True))
    return graph

callgraph = list(parse_callgraph(cfg_dir / 'callgraph.txt'))
cfgs = []
func_to_node = {}
for f in cfg_dir.glob('*.dot'):
    g = parse_cfg(f)
    cfgs.append(g)

    the_node = min(g.nodes(data=True), key=lambda n: n[1]['order'])
    # print(the_node)
    func_to_node[g.name] = the_node[0]

# for func, first_node in func_to_node.items():
#     print(f'{func} -> {first_node}')

logging.info(f'{len(target_nodes)} target nodes found')

logging.info(f'{len(callgraph)} call edges found in callgraph.txt')
logging.info(f'{len(cfgs)} CFG files found in {cfg_dir}')

node_cnt = sum([cfg.number_of_nodes() for cfg in cfgs])
edge_cnt = sum([cfg.number_of_edges() for cfg in cfgs])

logging.info(f'Total number of nodes: {node_cnt}')
logging.info(f'Total number of edges: {edge_cnt}')

# merge cfgs into one
entire_cfg = nx.MultiDiGraph()
for cfg in cfgs:
    entire_cfg = nx.compose(entire_cfg, cfg)

for caller, callee in callgraph:
    filename, funcname, lineno, order, bbid = caller
    node = 'Node' + bbid
    assert node in entire_cfg, f'Node {node} not found in entire CFG'
    entire_cfg.add_edge(node, func_to_node[callee], weight=10)

logging.info(f'Number of nodes in entire CFG: {entire_cfg.number_of_nodes()}')
logging.info(f'Number of edges in entire CFG: {entire_cfg.number_of_edges()}')

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

