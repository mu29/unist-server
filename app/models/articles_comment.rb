class ArticlesComment < ApplicationRecord
  belongs_to :article
  belongs_to :comment
end
