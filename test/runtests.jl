using Xyce
using Plots

res = Xyce.simulate("test/VRC.sp")

plot(res["TIME"], [res["V(NET2)"], res["V(NET1)"]])
savefig("xyce.png")