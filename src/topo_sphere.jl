using Gnuplot
include("read_data.jl")
include("new_palette.jl")

ETOPO1 = Cube("./data/ETOPO1_halfdegree.nc")
ETOPO1avg = ETOPO1[var="ETOPO1avg"].data[:,:]

file_gpp = "./data/GPPdata_Beer_etal_2010_Science.nc"
lon, lat, gpp_data = read_gpp(file_gpp)
gpp_data = replace(gpp_data, NaN=> 9999)
gpp_data = replace(gpp_data, missing=> 9999)
x,y,z = getSphere(lon, lat, ETOPO1); # too f*** slow.

aview = 70
lview = 75
bgcp1 = "set object rectangle from screen 0,0 to screen 1,1"
bgcp2 = " behind fillcolor '#1a1a1a' fillstyle solid noborder"
bgcolor = bgcp1*bgcp2

@gsp "set pm3d depthorder" "set border 0" "set tics textcolor 'white'" :-
@gsp :- "unset xtics" "unset ytics" "unset ztics" :-
@gsp :- "set style fill transparent solid 1 noborder" "set view equal xyz" :-
@gsp :- "set pm3d lighting primary 0.5 specular 0.4" :-
@gsp :- raw"""set title '\color{white} ETOPO Global Relief Model'""" :-
@gsp :- cbrange =(-6000, 6000) :-
@gsp :- "set colorbox horiz user origin 0.17,0.08 size 0.65, 0.02" :-
@gsp :- raw"""set cblabel '\color{white} $m$'"""

@gsp :- raw"""set label at graph 0.8,0.8,1.05 front center '\color{white} $G_{\mu\nu} + \Lambda g_{\mu\nu} = \kappa T_{\mu\nu}$'""" :-

@gsp :- x y z ETOPO1avg[:,end:-1:1] "w pm3d not lc palette" "set xyplane 0" :-
@gsp :-  palette(:seaborn_icefire_gradient; rev = false, smooth = true) :-
@gsp :- "set hidden3d front" :-
@gsp :- "set view $(lview), $(aview), 1.6,1"
@gsp :- bgcolor
save(term="cairolatex pdf input color dashed size 5in,5in", output="test_topo.tex")

#save(term="pngcairo size 800,800 fontscale 0.8", output="ETOPOavg_view_$(lview)_$(aview).png")

# NOAA National Centers for Environmental Information. 2022:
# ETOPO 2022 15 Arc-Second Global Relief Model. NOAA National Centers for
# Environmental Information. DOI: 10.25921/fd45-gt74