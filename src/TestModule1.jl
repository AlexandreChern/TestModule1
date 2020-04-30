module TestModule1

greet() = print("Hello World!")

export func1, print_nprocs

using Distributed
using SharedArrays
using ProgressMeter
using Interpolations

function func1()
    n = 2000
    array = SharedArray{Float64}(n)
    @sync @distributed for i = 1:n
        arr[i] = i^2
    end
    res = sum(arr)
    return res
end

function print_nprocs()
    return nworkers()
end

end
# end # module
