def quicksort(array, left, right)

i = j = left

while i < right
	if array[i] < array[right]
		array[i], array[j] = array[j], array[i]
		j+=1
	end
	i+=1
end

array[j], array[right] = array[right], array[j]

	if left < j-1
		quicksort(array, left, j-1)
	end

	if j+1 < right
		quicksort(array,j+1,right)
	end

	return array
end

to_sort = ARGV.map(&:to_i)
left = 0
right = to_sort.length-1
print quicksort(to_sort, left, right)
