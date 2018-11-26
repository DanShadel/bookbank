class PagesController < ApplicationController
	#Make sure a user is logged in when doing user specific actions
	before_action :set_user, only: [:account, :my_listings, :rate]
	def about
	end

	def error
	end

	def rate

		@user.num_reviews = @user.num_reviews + 1
		@user.score = @user.score + params[:score].to_i
		@user.save
		redirect_to pages_account_path(:user => params[:user])
	end

	def faq
	end

	def account
	
		#Count the number of listings the user owns
		@count = Textbook.where(user: @user).count
	end

	def my_listings
		#Only show listings that the user owns
		@textbooks = Textbook.where(user: @user)
		render 'textbooks/index'
	end



	private

		def set_user
			@user = User.find(params[:user])
		end

end
