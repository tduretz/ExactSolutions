using ExactFieldSolutions, Plots

function main()

    # Define domain
    Nx, Ny = 100, 100
    x    = LinRange(0, 1, Nx)
    y    = LinRange(0, 1, Ny)

    # Allocate arrays
    p    = zeros(Nx, Ny)
    Vx   = zeros(Nx, Ny)
    Vy   = zeros(Nx, Ny)
    ε̇II  = zeros(Nx, Ny)
   
    # Evaluate solution
    for i=1:Nx, j=1:Ny
        sol       = Stokes2D_Donea2003( [x[i]; y[j]] )
        p[i,j]    = sol.p
        Vx[i,j]   = sol.V[1]
        Vy[i,j]   = sol.V[2]
        ε̇II[i,j]  = sqrt( 1/2*(sol.ε̇[1,1]^2 + sol.ε̇[2,2]^2) + sol.ε̇[1,2]^2  )
    end
    
    # Visualise
    p1 = heatmap(x, y, p',    aspect_ratio=1, xlims=(-0,1), color=:jet, title="p")
    p2 = heatmap(x, y, ε̇II',  aspect_ratio=1, xlims=(-0,1), color=:jet, title="ε̇II")
    p3 = heatmap(x, y, sqrt.(Vx.^2 .+ Vy.^2)',   aspect_ratio=1, xlims=(-0,1), color=:jet, title="|V|")
    # p3 = heatmap(x, y, Vx',   aspect_ratio=1, xlims=(-0,1), color=:jet, title="Vx")
    display( plot(p1,p2,p3, layout=(2,2)) ) 
 
end

main()