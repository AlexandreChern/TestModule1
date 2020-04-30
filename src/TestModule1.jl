module TestModule1
using Distributed
using SharedArrays
using ProgressMeter
using Interpolations

include("SubModule.jl")
using .SubMod1
function func2()
    n = 100
    arr = SharedArray{Float64}(n)
    @sync @distributed for i=1:n
        arr[i] = SubMod1.test_me(i)
    end
    res = sum(arr)
    return res
end

greet() = print("Hello World!")


export func1, print_nprocs




function func1()
    n = 20000
    arr = SharedArray{Float64}(n)
    @sync @distributed for i = 1:n
        arr[i] = i^2
    end
    res = sum(arr)
    return res
end

function print_nprocs()
    return nworkers()
end


function sine_func(x)
    sleep(22*1e-3)
    return sin(x)
end

function create_interp()
    @info "create_interp"
    x = range(0, stop=10, length=1000)

    @info "Computing Interpolation..."
    y = @showprogress pmap(sine_func, x, batch_size=10)

    knots = (x,)
    itp = interpolate(knots, y, Gridded(Linear()))
end

const test_interp = create_interp()

end
# end # module
