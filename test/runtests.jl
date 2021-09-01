using Xyce
using Test

@testset "Xyce" begin
@testset "VRC.sp tran" begin
	res = Xyce.simulate("VRC.sp")
	@test haskey(res, "TIME")
	@test haskey(res, "V(INP)")
	@test haskey(res, "V(OUT)")
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
@testset "V1D1.sp tran" begin
	res = Xyce.simulate("V1D1.sp")
	@test haskey(res, "TIME")
	@test haskey(res, "V(NET1)")
	@test haskey(res, "I(V1)")
	time = res["TIME"]
	v1 = res["V(NET1)"]
	i1 = res["I(V1)"]
	@test time[1] == 0.0
	@test time[end] == 0.001
	@test maximum(v1) ≈ 20 atol=0.01
	@test minimum(v1) ≈ -20 atol=0.01
	@test v1[1] == 0
	@test v1[end] ≈ 0 atol=1e-12
	@test i1[1] ≈ 0 atol=1e-20
	@test minimum(i1) < -29
	@test maximum(i1) ≈ 0 atol=1e-4
	@test length(v1) > 75
	idx = argmin(i1)
	@test v1[idx] > 19.9
end
end