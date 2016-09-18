json.partial! 'articles/article', article: @article

json.comments_attributes do
  json.array!(@article.comments) do |comment|
    json.partial! 'comments/comment', comment: comment
  end
end
