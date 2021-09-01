using Xyce
using Test

@testset "VRC.sp tran" begin
	res = Xyce.simulate("VRC.sp")
	@test length(res) == 3
	time = res["TIME"]
	inp = res["V(INP)"]
	out = res["V(OUT)"]
	@test length(time) > 100
	@test time[1] == 0.0
	@test time[end] == 0.002
	@test maximum(inp) ≈ 1.0 atol=0.01
	@test minimum(inp) ≈ -1.0 atol=0.01
	@test inp[1] == 0
	@test inp[end] ≈ 0 atol=1e-12
	@test out[1] == 0
	@test maximum(out)/maximum(inp) ≈ 0.862 atol=0.001
	i1 = argmax(inp)
	@test out[i1]/inp[i1] ≈ 0.710 atol=0.001
end
# This crashes Xyce and Julia (FIXME):
#@testset "V1D1.sp" begin
#	res = Xyce.simulate("V1D1.sp")
#end