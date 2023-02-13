using Gnuplot, Random
x = y = -5:1:5
z = [x^2 + y^2 for x in x, y in y]
@gp x y z "w image pixels notit" "set auto fix" "set size square"
@gp :- xlab = raw"""$x$""" ylab = raw"""$y$""" raw"""set cblabel '$z$'"""
@gp :- title = "Heatmap Discrete"
save(term="cairolatex pdf input color dashed size 5in,3.3in", output="test_heatmap.tex")

