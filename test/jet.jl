using Test20261019075102
using JET
using Test

@testset "JET.jl" begin
    JET.test_package(Test20261019075102; target_modules = (Test20261019075102,))
end
