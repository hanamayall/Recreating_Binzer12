### Initial conditions

# body mass ratios
allZ = [1, 10, 100]

# fertilisation gradient
allI_K = [1:1:20;]

# temperature gradient
allT = [0:1:40;] .+ 273.15

# time span for each simulation
tspan = (0.0, 315360000000.0)

# define extinction threshold
threshold = 10e-12

#### data frame to store outputs
df = DataFrame(
    Z = [],
    I_K = [],
    T = [],
    K = [],
    r = [],
    x_2 = [],
    y_21 = [],
    B0_21 = [],
    maxB1 = [],
    maxB2 = [],
    maxB3 = [],
    minB1 = [],
    minB2 = [],
    minB3 = [],
    sp_survival = []
)

### Simulation loops
for Z in allZ
    for I_K in allI_K
        for T in allT

            # generate parameters specific to this combo of Z, I_K and T
            p = ModelParameters(param, T, I_K, Z)

            # Calculate starting biomasses
            u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]
            
            # Define the problem 
            prob = ODEProblem(BEFW, u0, tspan, p)

            # Solve the problem
            sol = solve(prob, maxiters = 1e7)


            ###### Output metrics ######
            # turn vector output of biomasses into matrix 
            matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

            ### Biomass extremes
            maxB1 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
            maxB2 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
            maxB3 = maximum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

            minB1 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),1])
            minB2 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),2])
            minB3 = minimum(matrix_u[2 * Int64(round(length(matrix_u[:,1])/3)):Int64(length(matrix_u[:,1])),3])

            ### Number of surviving species
            # final biomasses
            final_u = matrix_u[length(sol.t),:]

            # count number of species remaining that are above extinction threshold
            survived = count(final_u .> threshold)

            ### Push outputs to DataFrame
            push!(df, [
                Z,
                I_K,
                T,
                p.K[1],
                p.r[1],
                p.x[2],
                p.y[2,1],
                p.B0[2,1],
                maxB1,
                maxB2,
                maxB3,
                minB1,
                minB2,
                minB3,
                survived
            ])

            # print some stuff - see how the simulation is progressing
            println(("Z = $Z", "I_K = $I_K", "T = $T"))

        end
    end
end



# u0
# typeof(u0)

# p

# plot(sol)
# sol.t


# sol.u #56-element Vector{Vector{Float64}}
# matrix_u = hcat(sol.u) # convert to 56×1 Matrix{Vector{Float64}}
# matrix_u = hcat(sol.u...)' # 56×3 adjoint(::Matrix{Float64}) with eltype Float64: 

# final_u = matrix_u[length(sol.t),:]

# count(final_u .> threshold)

10000*365*24*60*60


# ### finding biomass extremes
# maximum(matrix_u[:,2])

maximum(eachrow(df))

Z = 1
T = 279.15
I_K = 9
# generate parameters specific to this combo of Z, I_K and T
p = ModelParameters(param, T, I_K, Z)

# Calculate starting biomasses
u0 = [p.K[1]/2, p.K[1]/2, p.K[1]/2]

# time span for each simulation
tspan = (0.0, 315360000000.0)

# Define the problem 
prob = ODEProblem(BEFW, u0, tspan, p)

# Solve the problem
sol = solve(prob)

plot(sol)