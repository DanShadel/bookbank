class PagesController < ApplicationController
	#Make sure a user is logged in when doing user specific actions
	before_action :authenticate_user!, only: [:account, :my_listings]

	def about
	end

	def error
	end

	def faq
	end

	def account
		#Account page for the currently logged in user
		@user = current_user
		#Count the number of listings the user owns
		@count = Textbook.where(user: current_user).count
	end

	def my_listings
		#Only show listings that the user owns
		@textbooks = Textbook.where(user: current_user)
		render 'textbooks/index'
	end

end
