## ODEs of three species in a simple food chain

#### Define 3 species network
# i(rows) eats j(columns), with i,j =( 1,2,3) corresponding to (top, intermediate, basal) species 

# A = [0 1 0; 0 0 1; 0 0 0]

## Trophic levels 
tl = [1, 2, 3]

# Z is consumer-resource body-mass ratio
# In Binzer paper, 3 size structures are used: Z = 1, 10, 100
Z_list = [1, 10, 100]

Z = 10

# Body mass calculated from Z and trophic levels
f(x) = Z ^ (x - 1)
M = f.(tl)

#### Parameter tuple
# Create a tuple containing the parameters required to build the initial food web
FoodWebPar = (
    tl = tl, # 
    Z = 1 # body mass ratio 1 as default
)