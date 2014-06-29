require 'open-uri'
require 'JSON'
require_relative "uk_postcode/lib/uk_postcode"
require_relative 'Location.rb'



class UserInput
	attr_accessor :postcode, :page
	def initialize
		@postcode = ask_for_postcode
		@page = set_page
	end

	def ask_for_postcode
		postcode_is_valid = false
		until postcode_is_valid
			puts "Type in a valid postcode"
			code =gets.strip
			pc = UKPostcode.new(code)
			if !pc.valid?
				puts "That postcode was not valid, please try again"
			else
				postcode_is_valid = true
			end
		end
		code.sub(" ","%20")
	end

	def set_page
		page = JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:#{@postcode}&key=AIzaSyCN7KeIRquR1SNJaZVw4jXz4cDqmLFEHn8"))
	end
end

first_postcode = UserInput.new

place = Location.new(first_postcode.page)


puts place
