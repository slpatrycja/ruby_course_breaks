to_sort = ARGV.map(&:to_i)

begin
	change = false
	for i in 0...to_sort.length-1
		if to_sort[i] > to_sort[i+1]
			to_sort[i], to_sort[i+1] = to_sort[i+1], to_sort[i] 
			change = true
		end
	end
end while change

print to_sort