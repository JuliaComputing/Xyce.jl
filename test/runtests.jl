using Xyce
using Test

@testset "VRC.sp tran" begin
	res = Xyce.simulate("VRC.sp")
	@test length(res) == 3
	@test length(res["TIME"]) > 100
	@test res["TIME"][1] == 0.0
	@test res["TIME"][end] == 0.002
	@test maximum(res["V(INP)"]) ≈ 1.0 atol=0.01
	@test minimum(res["V(INP)"]) ≈ -1.0 atol=0.01
	@test res["V(INP)"][1] == 0
	@test res["V(INP)"][end] ≈ 0 atol=1e-12
	@test res["V(OUT)"][1] == 0
	@test maximum(res["V(OUT)"])/maximum(res["V(INP)"]) ≈ 0.862 atol=0.001
	i1 = argmax(res["V(INP)"])
	@test res["V(OUT)"][i1]/res["V(INP)"][i1] ≈ 0.710 atol=0.001
end
# This crashes Xyce and Julia (FIXME):
#@testset "V1D1.sp" begin
#	res = Xyce.simulate("V1D1.sp")
#end