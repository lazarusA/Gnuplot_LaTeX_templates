using Gnuplot

x = 0:0.1:10pi
@gsp palette(:viridis) cbr=[-1,1].*30 :-
@gsp :- "set view 60,30" "set xyplane 0" :-
@gsp :-  x  x.*sin.(x)  x.*cos.(x)  x./20  "w p t 'points ' pt 7 ps var lc pal"
@gsp :- xlab = raw"""$x$""" ylab = raw"""$x\sin(x)$""" zlab = raw"""$x\cos(x)$"""
@gsp :- raw"""set cblabel '$x/20$' offset 1.5, 0"""
save(term="cairolatex pdf input color dashed size 5in,3.3in", output="test_line3d.tex")
