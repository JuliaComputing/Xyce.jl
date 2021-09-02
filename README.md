# Xyce.jl

Xyce.jl is a high-level Julia wrapper for [Xyce](https://xyce.sandia.gov/), a parallel circuit-simulator from Sandia National Laboratories.

# Usage

```julia
using Xyce
using Plots
spice_file = joinpath(dirname(pathof(Xyce)), "../test/VRC.sp")
res = Xyce.simulate(spice_file)
plot(res["TIME"], [res["V(INP)"], res["V(OUT)"]],
     label = ["V(inp)" "V(out)"])
```
