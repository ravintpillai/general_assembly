class SecretNumbersController < ApplicationController
	def new
	end

	def show
		@secret_number = rand(5)+1
		@chosen_number = params[:id].to_i
	end
end