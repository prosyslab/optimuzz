open Util.ALlvm
open Seedcorpus
module CD = Coverage.Domain

val run :
  Seedpool.t ->
  llcontext ->
  unit LLModuleSet.t ->
  CD.Coverage.t ->
  int ->
  CD.Coverage.t
