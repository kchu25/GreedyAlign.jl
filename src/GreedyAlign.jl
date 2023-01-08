module GreedyAlign
#
using Distributions, HypothesisTests, StaticArrays,
      DataStructures, DoubleFloats, JLD2

using CUDA # TODO: is there a way to prevent loading this twice?

export obtain_PWMs

include("constants.jl")
include("inference/constants.jl")
include("inference/triplet_esd_test.jl")
include("inference/triplet.jl")
include("inference/utils.jl")
include("inference/merging.jl")
include("inference/expansion.jl")
include("inference/inference.jl")
include("greedy_alignment/constants.jl")
include("greedy_alignment/PWM_Touzet.jl")
include("greedy_alignment/utils.jl")
include("greedy_alignment/expansion.jl")
include("greedy_alignment/scan.jl")
include("greedy_alignment/scan_gpu.jl")
include("greedy_alignment/fisher.jl")
include("greedy_alignment/greedy_alignment.jl")
include("obtain_PWMs.jl")


end
