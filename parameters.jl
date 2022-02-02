#### Function to define parameters 

# define parameters 
param = (
    # Intercepts
    I_r = -15.68,
    I_y = -9.66,
    I_B0 = 3.44,
    I_x = -16.54,
    I_αm = -1.81,
    I_thm = 1.92,
    I_thT = 0.5,

    # Resource slopes
    si_K = 0.28,
    si_r = -0.25,
    si_y = 0.45,
    si_B0 = 0.2,
    si_x = -0.31,

    # Consumer slopes (consumption)
    sj_y = -0.47,
    sj_B0 = 0.33,

    # Ratio slopes (attack and handling)
    s1_αm = 0.39,
    s1_thm = -0.48,
    s1_thT = -0.055,

    # Quadratic ratio slopes (attack and handling)
    s2_αm = -0.017,
    s2_thm = 0.0256,
    s2_thT = 0.0013,
    
    # Activation energies
    Ea_K = 0.71,
    Ea_r = -0.84,
    Ea_y = -0.26,
    Ea_B0 = 0.12,
    Ea_x = -0.69
    )


##### FUNCTION to create tuple of parameter groups
Z = 10
I_K = 1
function ModelParameters(param, Z, T, I_K)
    
    ### Calculate body masses
    Z, M = Network(Z = 10)

    ### Calculate carrying capacity
    K = carryingcapacity_BA(I_K, param, M, T)

    ### Calculate producer growth rate
    r = growth_BA(param, M, T)
    @assert r[2] == 0 # defensive programming
    @assert r[3] == 0 

    ### Calculate metabolism
    x = 

    # Combine parameters into Tuple
    ModelParameters = (FW)
    return ModelParameters
end
