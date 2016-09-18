json.extract! comment, :id, :content, :created_at, :updated_at
json.user_attirbutes do
  json.partial! 'users/user', user: comment.user
end
