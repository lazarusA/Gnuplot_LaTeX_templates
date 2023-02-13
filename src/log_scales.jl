using Gnuplot
x = range(0.01, 100, 3000)
y = -0.75sin.(x)

@gp "set logscale x" "set logscale cb" yrange = [-1,1] :-
@gp :- raw"""set format cb '$10^{%T}$'"""
@gp :- xlab = raw"""default format $x$""" cblab = "Scientific Notation" :-
@gp :- ylab = raw"""$-0.75\sin(x)$""" :-
@gp :- x y x "w l notit lw 2 dt 1 lc palette"
save(term="cairolatex pdf input color dashed size 6in,1.5in", output="test_log.tex")
