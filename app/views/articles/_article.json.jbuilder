json.extract! article, :id, :title, :content, :created_at, :updated_at
json.user_attirbutes do
  json.partial! 'users/user', user: article.user
end
