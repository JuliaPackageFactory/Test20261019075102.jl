using Test20261019075102
using Test

# Quality checks. Each file is self-contained and can also be run on its own:
#     julia --project=test --startup-file=no test/aqua.jl
include("aqua.jl")
include("explicit_imports.jl")
include("runic.jl")

@static if get(ENV, "JET_TEST", "true") == "true"
    include("jet.jl")
end

# Package tests. Add one file per feature and include it here.
@testset "Test20261019075102.hello" begin
    @test Test20261019075102.hello() == "Hello, World!"
end
