class Textbook < ApplicationRecord
	def self.search(term)
	  if term
	    where('title LIKE ?', "%#{term}%")
	  else
	    all
	  end
end
end
