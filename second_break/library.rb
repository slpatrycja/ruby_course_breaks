require "yaml"

class Library
	include Enumerable
	attr_reader :books, :users_base
	def initialize
		@books = []
		@users_base = []
		$/="\n\n"

		File.open("users.txt", "r").each do |object|
  			@users_base << YAML::load(object)
  		end

  		contents = File.read("books.txt")
  		if contents.empty?
  			@books = []
  		else
			@books = Kernel.eval(contents)
		end
	end

	def add_book(book_title) 
		@books.push({:title => book_title, :status => 'avaible'})
		File.delete('books.txt')
		f = open('books.txt', 'a') 
  		f.write @books

	end

	def add_user(user)
		@users_base.push(user)
		file = File.open("users.txt", "w")
		@users_base.each do |user|
    	file.puts YAML::dump(user)
    	file.puts ""
    	end
  	end
 
	def show_books
		@books.each do |book| 
			print "Tytuł: #{book[:title].capitalize}, dostępność: #{book[:status]}\n"
		end
	end

	def log_in(card_number)
		user = @users_base.detect { |user| user.card_number == card_number }

		if user == nil
			puts "Nie ma takiego użytkownika"
			exit 
		end
		return user
	end

	def check_out(title)
		book_index = @books.index { |book| book[:title] == title && book[:status] == 'avaible'}

		if book_index == nil 
			"This book is unavaible"
			return 0
		else
			puts book_index
			to_check_out = @books[book_index]
			@books.delete_at(book_index)
			to_check_out[:status] = 'unavaible'
			@books.push(to_check_out)
			File.delete('books.txt')
			f = open('books.txt', 'a') 
	  		f.write @books
	  		return 1
  		end
	end

	def return_book(title)
		to_return = @books.detect { |book| book[:title] == title }
		@books.delete(to_return)
		to_return[:status] = 'avaible'
		@books.push(to_return)
		File.delete('books.txt')
		f = open('books.txt', 'a') 
  		f.write @books
	end
end

class User
	@@all_cards = []
	attr_reader :card_number, :user_books, :name, :history_of_checkouts
	def initialize(name)
		@card_number = get_card_number
		@name = name
		@user_books = []
		@history_of_checkouts = []
	end

	def get_card_number
		@card_number ||= rand(65..90).chr + rand(65..90).chr + rand(65..90).chr + rand(10000..100000).to_s
		if !@@all_cards.include?(card_number)
			@@all_cards.push(card_number)
		else
			get_card_number
		end
		card_number
	end	

	def check_out(title, library)
		if library.check_out(title) == 1
			@user_books.push(title)
			@history_of_checkouts.push({ :title => title, :date => Time.now})
			library.users_base.delete(self)
			library.add_user(self)
			return 1
		end
		
	end

	def return_book(title, library)
		@user_books.delete(title)
		@history_of_checkouts.delete(@history_of_checkouts.detect { |book| book[:title] == title })
		library.return_book(title)
		library.users_base.delete(self)
		library.add_user(self)
	end

end

def programme
	library = Library.new
	menu(library)
end

def menu(library)

	
	puts "Welcome to our new library!"
	puts "Tell us what you want to do:"
	puts "1. Show the list of our books", "2. Give us a book", "3. Add yourself to readers register and create your own librarian card"
	puts "4. Log in", "5. Exit"

	case gets.to_i
		when 1 then library.show_books
		when 2	
			puts "Please enter the title of the book you want to give"
			title = gets.chomp.downcase
			library.add_book(title)
			library.show_books
			puts "Thank you for your donation"
			puts "Exiting..."
		when 3
			puts "Please type your name and lastname"
			name = gets.chomp.downcase
			new_user = User.new(name)
			library.add_user(new_user)
			puts "Thanks for joining us!"
			
		when 4
			
			puts "Please enter your card number for verifiation"
			card_number = gets.chomp
			user = library.log_in(card_number)
			puts "Logged now as #{user.name.capitalize}"
			puts "What do you want to do?"
			puts "1. Check out the book", "2. Return the book", "3. Show history of checkouts"
				case gets.to_i
				when 1
					puts "Please enter the title of the book you want to check out"
					title = gets.chomp.downcase
					result = user.check_out(title, library)
					if result == 1
						puts "Here's the fresh list of books that you've checked out"
						puts user.user_books
					
					else puts "This book is unavaible"
					end
					
				when 2
					puts "Please enter the title of the book you want to return"
					title = gets.chomp.downcase
					user.return_book(title, library)
					puts "Here's the fresh list of books that you've checked out"
					puts user.user_books

				when 3
					puts "Your history:"
					user.history_of_checkouts.each { |book| puts "Title: #{book[:title]}, date: #{book[:date]}" }
					
				end
		when 5
			exit
	end
end

programme