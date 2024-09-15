class UnsavedArticle
  def initialize(user)
    @user = user
  end

  def get
    @user.articles.unsaved.first
  end

  def register!
    @user.articles.create!(status: :unsaved)
  end
end
