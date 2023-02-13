using Gnuplot
@gsp "set multiplot title 'Interlocking Tori'"
U = range(-pi, pi, 100)
V = range(-pi, pi, 20)
@gsp :- "unset key" "unset xtics" "unset ytics" "unset ztics"
@gsp :- "set border 0" "set view 60, 30, 1.5, 0.9"
@gsp :- "set style fill transparent solid 0.7"

for loop in 1:2
    if loop == 1
        @gsp :- 1 title="PM3D surface\\nno depth sorting"
        @gsp :- "set origin -0.02,0.0"
        @gsp :- "set size 0.55, 0.9"
        @gsp :- palette(:dense)
        @gsp :- "set colorbox h user origin 0.05, 0.1 size 0.4, 0.02"
        @gsp :- raw"""set cblabel '$z$ dense'"""
        @gsp :- "set pm3d scansforward" :-  ## scansbackward
    else
        @gsp :- 2 title="PM3D surface\\ndepth sorting"
        @gsp :- "set origin 0.40,0.0"
        @gsp :- "set size 0.55, 0.9"
        @gsp :- palette(:plasma)
        @gsp :- "set colorbox vertical user origin 0.9, 0.15 size 0.02, 0.50"
        @gsp :- raw"""set cblabel '$z$'"""
        @gsp :- "set pm3d depthorder"
    end
    x = [cos(u) + .5 * cos(u) * cos(v)      for u in U, v in V]
    y = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
    z = [.5 * sin(v)                        for u in U, v in V]
    @gsp :-  x' y' z' "w pm3d"

    x = [1 + cos(u) + .5 * cos(u) * cos(v)  for u in U, v in V]
    y = [.5 * sin(v)                        for u in U, v in V]
    z = [sin(u) + .5 * sin(u) * cos(v)      for u in U, v in V]
    @gsp :- x' y' z' "w pm3d"
end
save(term="cairolatex pdf input color dashed size 5in,3.3in", output="test_torus.tex")
