using Test20261019075102
using ExplicitImports
using Test

@testset "ExplicitImports.jl" begin
    @test check_no_implicit_imports(Test20261019075102) === nothing
    @test check_no_stale_explicit_imports(Test20261019075102) === nothing
end
