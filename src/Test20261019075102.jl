module Test20261019075102

# Public API, accessed as Test20261019075102.hello without exporting the name.
public hello

"""
    hello()

Return a friendly greeting.

# Examples

```julia
julia> Test20261019075102.hello()
"Hello, World!"
```
"""
function hello()
    return "Hello, World!"
end

end
