require 'open-uri'
require 'JSON'
require_relative "uk_postcode/lib/uk_postcode"
require_relative 'Location.rb'

class UserInput
	def raw_input(prompt)
		puts prompt
		gets.strip
	end

	def handle_input(validity_of_input)
		if !validity_of_input
			puts "That input was not valid, please try again"
		end
		validity_of_input
	end
end

class UserPostcodeInput < UserInput
	attr_accessor :postcode, :page
	def initialize
		@postcode = ask_for_postcode
		@page = set_page
	end

	def ask_for_postcode
		postcode_is_valid = false
		until postcode_is_valid
			code = raw_input("Type in a valid postcode, or postcode area")
			pc = UKPostcode.new(code)
			postcode_is_valid = pc.valid? ? true : handle_input(false)
		end
		code.sub(" ","%20")
	end

	def set_page
		page = JSON.load(open("https://maps.googleapis.com/maps/api/geocode/json?components=postal_code:#{@postcode}&key=AIzaSyCN7KeIRquR1SNJaZVw4jXz4cDqmLFEHn8"))
	end
end

first_postcode = UserPostcodeInput.new

place = Location.new(first_postcode.page)

puts place

