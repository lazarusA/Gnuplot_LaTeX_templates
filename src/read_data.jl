using NCDatasets
using DelimitedFiles
using YAXArrays, NetCDF

function toCartesian(lon, lat; r = 1)
    return r * cosd(lat) * cosd(lon), r * cosd(lat) * sind(lon), r *sind(lat)
end

function toCartesian(lon, lat, ETOPO1; earth_radius = 6371000)
    alt = ETOPO1[var="ETOPO1avg", lon = lon, lat = lat][1]
    r = (earth_radius + alt)
    r * cosd(lat) * cosd(lon), r * cosd(lat) * sind(lon), r *sind(lat)
end

function read_coastlines(file)
    worlddata = readdlm(file, skipblanks = false)
    for i in 1:size(worlddata)[1]
        if worlddata[i,1] == ""
            worlddata[i,1] = NaN
            worlddata[i,2] = NaN
        end
    end
    return Float64.(worlddata)
end

function read_gpp(file)
    gpp = Dataset(file)
    lon, lat = gpp["lon"][:], gpp["lat"][:]
    gpp_data = gpp["gpp"][:,:]
    return lon, lat, replace(gpp_data, -9999=>NaN)
end

function getSphere(lon, lat, topo;  earth_radius=337100)
    # here the radius is wrong, just to see the depth effect
    xyz = [toCartesian(lo, la, topo;  earth_radius = earth_radius) for lo in lon, la in lat]
    xyz = [xyz...]
    x = [xyz[i][1] for i in eachindex(xyz)]
    y = [xyz[i][2] for i in eachindex(xyz)]
    z = [xyz[i][3] for i in eachindex(xyz)]
    x = reshape(x, (length(lon), length(lat)))
    y = reshape(y, (length(lon), length(lat)))
    z = reshape(z, (length(lon), length(lat)))
    return (x, y, z)
end