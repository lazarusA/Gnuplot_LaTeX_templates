using Gnuplot
include("read_data.jl")
include("new_palette.jl")

ETOPO1 = Cube("./data/ETOPO1_halfdegree.nc")
file_gpp = "./data/GPPdata_Beer_etal_2010_Science.nc"
lon, lat, gpp_data = read_gpp(file_gpp)
gpp_data = replace(gpp_data, NaN=> 9999)
gpp_data = replace(gpp_data, missing=> 9999)
x,y,z = getSphere(lon, lat, ETOPO1); # too f*** slow.

aview = 45
lview = 85
@gsp "set pm3d depthorder" "set border 0" "unset xtics" "unset ytics" "unset ztics" :-
@gsp :- "set style fill transparent solid 1 noborder" "set view equal xyz" :-
@gsp :- "set pm3d lighting primary 0.5 specular 0.1" :-
@gsp :- title = "Gross Primary Production" :-
@gsp :- cbrange =(1, 3500) :-
@gsp :- "set colorbox horiz user origin 0.17,0.05 size 0.65, 0.02" :-
@gsp :- raw"""set cblabel 'GPP'"""
@gsp :- x y z gpp_data "w pm3d not lc palette" "set xyplane 0" :-
@gsp :- palette2(:Spectral_11; rev = true, smooth = true, highclip = "#f1f1f1") :-
@gsp :- "set hidden3d front" :-
@gsp :- "set view $(lview), $(aview), 1.6,1"
save(term="cairolatex pdf input color dashed size 5in,5in", output="test_gpp.tex")
