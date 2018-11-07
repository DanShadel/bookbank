class Textbook < ApplicationRecord

	belongs_to :user
	#Find textbooks in section CATEGORY with identifier INPUT
	def self.search(category,input)

	  #searching for titles
	  if category == "title"
	    where('title LIKE ?', "%#{input}%")

	  #Searching for ISBN10
	  elsif category == "isbn_10"
	  	where('isbn_10 like ?', "%#{input}%")

	  elsif category == "isbn_13"
	  	where('isbn_13 like ?', "%#{input}%")

	  #Searching fo Author
	  elsif category == "author"
	  	where('author LIKE ?', "%#{input}%")

	  # Can add other search attributes if necessecary

	  else 
	    all
	    #endif
	  end

	#end search
	end

#end Textbook
end

