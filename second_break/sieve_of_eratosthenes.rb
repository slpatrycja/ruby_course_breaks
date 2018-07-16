def sieve(n)

	array = Array.new(n+1) { true }
	array[0] = nil
    array[1] = nil
 	i = 2
 	
 	while i <= Math.sqrt(n)
 		w = i*i if array[i] == true
 		while (w <= n)
	 		array[w] = false
	 		w += i
 			end
 		i+=1
 	end
 	array.each.with_index { |n, index| puts index  if n == true }
end

sieve(6)