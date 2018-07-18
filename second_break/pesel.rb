def pesel(nr)
	nr = nr.map(&:to_i)
	return "Pesel #{nr.map(&:to_s).join('')} jest nieprawidlowy" if nr.length != 11 or !is_last_number_valid?(nr)

	puts "Pesel #{nr.map(&:to_s).join('')} jest prawidlowy.\nInformacje o peselu:"
	if nr[2] == 0 || nr[2] == 1
		puts "Data urodzenia: #{date_of_birth_in_19(nr)}"
	elsif nr[2] == 2 || nr[2] == 3 
		puts "Data urodzenia: #{date_of_birth_in_20(nr)}"
	else 
		return "Pesel #{nr.map(&:to_s).join('')} jest nieprawidłowy"
	end

	puts "Płeć: #{gender(nr)}"

end

def is_last_number_valid?(nr)
	sum = 0
	sum += 9*(nr[0] + nr[4] + nr[8])
	sum += 7*(nr[1] + nr[5] + nr[9])
	sum += 3*(nr[2] + nr[6])
	sum += (nr[3] + nr[7])

	if sum%10 == nr[10]
		return true
	else 
		return false
	end

end

def gender(nr)
	return 'Mężczyzna' if nr[9]%2 == 1
	return 'Kobieta'
end

def date_of_birth_in_19(nr)
	if (nr[2] == 0 && nr[3].between?(1,9)) || (nr[2] == 1 && nr[3].between?(0,2))
		date = nr[4..5].map(&:to_s).join('') +'-' + nr[2..3].map(&:to_s).join('')+'-'
		date +=  '19' +  nr[0..1].map(&:to_s).join('')
	else 
		return 'Pesel #{nr.map(&:to_s).join('')} jest nieprawidłowy'
	end
		date
end

def date_of_birth_in_20(nr)
	if (nr[2] == 2 && nr[3].between?(1,9)) || (nr[2] == 3 && nr[3].between?(0,2))
		nr[2] -= 2
		date = nr[4..5].map(&:to_s).join('') +'-' + nr[2..3].map(&:to_s).join('')+'-'
		date +=  '20' +  nr[0..1].map(&:to_s).join('')
	else 
		return 'Pesel #{nr.map(&:to_s).join('')} jest nieprawidłowy'
	end
		date
end

puts pesel(ARGV)