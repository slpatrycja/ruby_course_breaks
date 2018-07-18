def find_index(array,value)
	
	return 'not found' if array.index(value) == nil
	array.index(value)
end

puts find_index([1,3,4,2,5], 6)