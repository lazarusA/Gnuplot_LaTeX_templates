using Colors, ColorSchemes
using Gnuplot

"""
    palette(cmap::ColorScheme; rev=false, smooth=false)
    palette(s::Symbol; rev=false, smooth=false)
Convert a `ColorScheme` object into a string containing the gnuplot commands to set up the corresponding palette.
If the argument is a `Symbol` it is interpreted as the name of one of the predefined schemes in [ColorSchemes](https://juliagraphics.github.io/ColorSchemes.jl/stable/basics/#Pre-defined-schemes-1).
If `rev=true` the palette is reversed.  If `smooth=true` the palette is interpolated in 256 levels.
"""
palette2(s::Symbol; kwargs...) = palette2(colorschemes[s]; kwargs...)
function palette2(cmap::ColorScheme; rev=false, smooth=false, highclip = :nothing, lowclip = :nothing)
    levels = Vector{String}()
    for x in range(0, 0.999, (smooth  ?  256  : length(cmap.colors)))
        if rev
            color = get(cmap, 0.999-x)
        else
            color = get(cmap, x)
        end
        push!(levels, "$x '#" * Colors.hex(color) * "'")
    end
    if highclip == nothing && lowclip == nothing
        return "set palette defined (" * join(levels, ", ") * ")\nset palette maxcol $(length(cmap.colors))\n"
    elseif highclip !== nothing
        return "set palette defined (" * join(levels, ", ") * ", 1 '$(highclip)'" * ")\nset palette maxcol $(length(cmap.colors)+1)\n"
    #elseif lowclip !== nothing
    #    return "set palette defined (" *"-0.01 '$(lowclip)', " * join(levels, ", ") * ")\nset palette maxcol $(length(cmap.colors) +1)\n"
    end
end