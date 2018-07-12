
def sum_array(array)
	array.sum - array.min - array.max
end

# puts sum_array([120,7,145,-10,-15])


def invert_array(array)
	array.map { |e| -e }
end 

# print invert_array([1,2,3,-4])
def common_elements(arr1, arr2)
	arr2.each { |e| arr2.delete(e) if arr1.include?(e) == false }
end

# def common_elements(arr1, arr2)
# 	common_elements_array = []
# 	for i in 0...arr2.length
# 		common_elements_array.push(arr2[i])	if arr1.include?(arr2[i])
# 	end
# 	common_elements_array
# end

# print common_elements([1,2,3,4,5],[4,5,6])

def avf_array(*args)
	for i in 0...args.length
		return ('Wszystkie tablice muszą mieć taką samą długość!') if args[i].length != args[0].length
	end

	args.each { |array| array.each_index { |index| args[0][index] += array[index] if array != args[0] }}
	args[0].map { |e| e/args.length.to_f }

end


# print avf_array([1,2], [6,7], [3,4], [1,1])

def highest_number(int)
	int.to_s.split("").map { |digit| digit.to_i }.sort.reverse.join.to_i
end

# puts highest_number(243)

def multiples(n)
	sum = 0
	(n+1).times { |i| sum += i if i%3 == 0 || i%5 == 0 }
	sum
end

 # puts multiples(20)

 def roman(n)

 	numbers = {
    1000 => "M",  
     900 => "CM",  
     500 => "D",  
     400 => "CD",
     100 => "C",  
      90 => "XC",  
      50 => "L",  
      40 => "XL",  
      10 => "X",  
        9 => "IX",  
        5 => "V",  
        4 => "IV",  
        1 => "I",  
  }
  	roman = ""
  	numbers.each do |value, letter|
      roman << letter*(n / value)
      n = n % value
    end
    return roman

 end

# puts roman(492)











