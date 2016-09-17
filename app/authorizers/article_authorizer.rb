class ArticleAuthorizer < ApplicationAuthorizer
  def self.creatable_by?(_user)
    true
  end

  def self.readable_by?(_user)
    true
  end

  def self.updatable_by?(_user)
    true
  end

  def self.deletable_by?(_user)
    true
  end

  def updatable_by?(user)
    resource.user == user
  end

  def deletable_by?(user)
    resource.user == user
  end
end
