using Gnuplot
include("read_data.jl")

file = "./data/world_110m.txt"
file_gpp = "./data/GPPdata_Beer_etal_2010_Science.nc"

xyc = read_coastlines(file)
lon, lat, gpp_data = read_gpp(file_gpp)

@gp xlab = "lon" ylab = "lat" :-
@gp :- title = raw"""Gross Primary Production (GPP) [$gC\, m^{-2}$]""" :-
@gp :- cbrange = (1,3500) "set logscale cb" raw"""set cblabel 'GPP'""" :-
@gp :- lon lat gpp_data "w image not" palette(:Spectral_11, rev = false, smooth=true) :-
@gp :- xyc[:,1] xyc[:,2] "w l lw 0.5 lc 'black' not"
#save(term="pngcairo size 1200,600 fontscale 0.8", output="gpp_log.png")
