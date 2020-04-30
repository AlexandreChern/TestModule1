using Distributed

addprocs(2)

@everywhere using Pkg
@everywhere Pkg.activate("../TestModule1")

@everywhere using TestModule1

print_nprocs()

func1()

TestModule1.func2()

TestModule1.test_interp(3.1415)
sin(3.1415)
