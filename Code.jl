# Load data

using DataFrames, CSV, StatsBase

inputs = readdir(joinpath("Input","datasets"), join = true)

Names = []
[push!(Names, inputs[i][31:end-4]) for i = 1:length(inputs)]

# Some names appear more than once, e.g. MATHES, 
# Need to numerize them e.g. MATHES1, MATHES2
n = countmap(Names)

d = []
for i = 1:length(n)
	if n[Names[i]] > 1
		d = push!(d, Names[i]) 	
	end
end
#d = unique(d)

for i = 1:length(d)
	x = findfirst(x -> x == d[i], Names)
	Names[x] = string(Names[x], string(i))
end

# Note, Names work for now, but VARGAS1 and VARGAS2 would be better
Data = Dict(Names .=> [[] for i in 1:length(Names)])

[push!(Data[Names[i]], DataFrame(CSV.File(inputs[i]))) for i = 1:length(Names)]



