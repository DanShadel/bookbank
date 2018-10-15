json.extract! textbook, :id, :title, :condition, :isbn, :created_at, :updated_at
json.url textbook_url(textbook, format: :json)
