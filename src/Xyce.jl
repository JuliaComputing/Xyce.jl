module Xyce
using CxxWrap
using XyceWrapper_jll
@wrapmodule(XyceWrapper_jll.xycelib)

function __init__()
    @initcxx
end

function simulate(netlist; type=TRAN, name="handler", vectors=["TIME", "V(*)", "I(*)"])
    cxxvec = StdVector(StdString.(vectors))
    oh = OutputHandler(name, type, cxxvec)
    x = GenCouplingSimulator()
    arg = ["xyce", netlist]
    argch = Base.cconvert.(CxxPtr{CxxChar}, arg)
    argv = Base.cconvert(CxxPtr{CxxPtr{CxxChar}}, argch)
    initialize(x, 2, argv)
    addOutputInterface(x, CxxPtr(oh))
    runSimulation(x)
    names = String.(getFieldnames(oh))
    res = Dict()
    for (i, n) in enumerate(names)
        res[n] = Array(getRealData(oh, i-1))
    end
    return res
end

end # module
