module Xyce
using CxxWrap
using XyceWrapper_jll
@wrapmodule(XyceWrapper_jll.xycelib)

function __init__()
    @initcxx
end

function simulate(netlist; type=TRAN, name="handler", vectors=["V(*)", "I(*)"])
    cxxvec = StdVector(StdString.(vectors))
    oh = OutputHandler(name, type, cxxvec)
    x = GenCouplingSimulator()
    addOutputInterface(x, oh) # type error
    argv = Base.cconvert(CxxPtr{CxxPtr{CxxChar}}, ["xyce", netlist])
    initialize(x, 2, argv) # tries to read "A" rather than netlist
end


end # module
