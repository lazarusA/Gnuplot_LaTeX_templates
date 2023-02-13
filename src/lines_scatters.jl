using Gnuplot
@gp key="left" linetypes(:Set1_5, dashed=true, ps=1.25)
@gp :- xlab = raw"""$x$""" ylab = raw"""$y$"""
@gp :- xrange = [0,10.5] yrange = [0,105] :- 
for i in 1:10
    @gp :- i .* (0:10) "w lp t '$i'"
end
save(term="cairolatex pdf input color dashed size 5in,3.3in", output="test_ls.tex")
