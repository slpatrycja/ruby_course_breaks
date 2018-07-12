class Animal

	def give_sound
	end
end

class Cat < Animal
	def give_sound
		puts 'Miau! Miau!'
	end
end

class Dog < Animal
	def give_sound
		puts 'Woof! Woof!'
	end
end

class Duck < Animal
	def give_sound
		puts 'Kwa! Kwa!'
	end
end

class Goose < Animal
	def give_sound
		puts 'Gda! Gda!'
	end
end

class Farm
	def initialize(array)
		@array = array
	end

	def give_sounds()
		@array.each do |animal|
			animal.give_sound
		end
	end
end

cat = Cat.new
dog = Dog.new
duck = Duck.new
arr = []
arr.push(cat,dog,duck)
farm = Farm.new(arr)

# farm.give_sounds




