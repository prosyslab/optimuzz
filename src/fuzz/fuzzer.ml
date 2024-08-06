module CD = Coverage.Domain
module SeedPool = Seedcorpus.Seedpool
module SD = Seedcorpus.Domain
module MD = Mutation.Domain
module F = Format
module L = Logger

(** runs optimizer with an input file
    and measure its coverage.
    Returns the results *)
