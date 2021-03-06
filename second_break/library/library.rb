require "yaml"

class Store
	def initialize(dir, mode)
		@dir = dir
		@mode = mode	
	end

	def load_to(this_base)
		File.open(@dir, @mode).each { |object| this_base << YAML::load(object) }
	end

	def save_from(this_base)
		File.delete(@dir)
		@file = File.open(@dir, @mode)
		this_base.each do |e|
	    	@file.puts YAML::dump(e)
	    	@file.puts ""
    	end
	end
end

class Library
	include Enumerable
	attr_reader :books, :users_base

	def initialize
		@books_base = []
		@users_base = []

		$/="\n\n"
		Store.new("users.txt", "r").load_to(@users_base)
		Store.new("books.txt", "r").load_to(@books_base)
	end

	def add_book(title) 
		@books_base.push(Book.new(title))
		Store.new('books.txt', 'a').save_from(@books_base)
	end

	def add_user(user)
		@users_base.push(user)
		Store.new('users.txt','w').save_from(@users_base)
  	end
 
	def show_books
		@books_base.each do |book| 
			print "Tytuł: #{book.title.capitalize}, dostępność: #{book.status}\n"
		end
	end

	def log_in(card_number)
		user = @users_base.detect { |user| user.card_number == card_number }

		if user == nil
			puts "Nie ma takiego użytkownika"
			exit 
		end
		user
	end

	def check_out(title)
		to_check_out = @books_base.detect { |book| book.title == title && book.status == 'avaible'}

		if to_check_out == nil 
			return 0
		else
			to_check_out.status = 'unavaible'
			Store.new('books.txt', 'a').save_from(@books_base)
	  		return 1
  		end
	end

	def return_book(title)
		to_return = @books_base.detect { |book| book.title == title && book.status == 'unavaible'}
		to_return.status = 'avaible'
		Store.new('books.txt', 'a').save_from(@books_base)
	end
end

class Book

	attr_reader :title
	attr_accessor :status

	def initialize(title)
		@title = title
		@status = 'avaible'
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
			@history_of_checkouts.push({ :title => title, :date => Time.now.strftime("%Y-%m-%d, %T"), 
				:return_date => (Time.now + (2*7*24*60*60)).strftime("%Y-%m-%d, %T")})

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


class Menu
	
	def initialize(library)
		@library = library
	end

	def show_options
		puts "Menu:"
		puts "1. Show the list of our books", "2. Give us a book"
		puts "3. Add yourself to readers register and create your own librarian card"
		puts "4. Log in", "5. Exit"

		@choice = gets.to_i
		action
	end

	def action
		case @choice
			when 1 
				@library.show_books
				exit_or_return_to_menu(@library)
			when 2	
				puts "Please enter the title of the book you want to give"
				title = gets.chomp.downcase
				@library.add_book(title)
				@library.show_books
				puts "Thank you for your donation"
				exit_or_return_to_menu(@library)
			when 3
				puts "Please type your name and lastname"
				name = gets.chomp.downcase
				new_user = User.new(name)
				@library.add_user(new_user)
				puts "Thanks for joining us!"
				exit_or_return_to_menu(@library)
				
			when 4
				
				puts "Please enter your card number for verifiation"
				card_number = gets.chomp
				user = @library.log_in(card_number)
				puts "Logged now as #{user.name.capitalize}"
				user_menu(@library, user)
				
			when 5
				exit
		end
	end

	def user_menu(library, user)
		puts "What do you want to do?"
		puts "1. Check out the book", "2. Return the book", "3. Show history of checkouts", "4. Log out"
			case gets.to_i
				when 1
					puts "Please enter the title of the book you want to check out"
					title = gets.chomp.downcase
					result = user.check_out(title, library)

					if result == 1
						puts "Here's the fresh list of books that you've checked out"
						puts user.user_books	
					else 
						puts "This book is unavaible"
					end
					exit_or_return_to_user_menu(library, user)

				when 2
					puts "Please enter the title of the book you want to return"
					title = gets.chomp.downcase
					user.return_book(title, library)

					puts "Here's the fresh list of books that you've checked out"
					puts user.user_books

					exit_or_return_to_user_menu(library, user)

				when 3
					puts "Your history:"
					user.history_of_checkouts.each do |book| 
						days_left = book[:return_date].chars[8..9].join.to_i - book[:date].chars[8..9].join.to_i
						print "Title: #{book[:title]}"
						print " date: #{book[:date]}, valid to: #{book[:return_date]}"
						print "(days left: #{days_left})\n"
					end
					exit_or_return_to_user_menu(library, user)
			
			    when 4
			    	user = nil
			    	show_options
			end
	end


	def exit_or_return_to_menu(library)
		puts "Press 1 to quit or 2 to go back to menu"
		case gets.to_i
			when 1 then exit
			when 2 then show_options
		end
	end

	def exit_or_return_to_user_menu(library, user)
		puts "Press 1 to quit or 2 to go back to user panel"
		case gets.to_i
			when 1 then exit
			when 2 then user_menu(library, user)
		end
	end

end

def programme
	
	library = Library.new
	puts "Welcome to our new library!"
	menu = Menu.new(library)
	menu.show_options

end
programme