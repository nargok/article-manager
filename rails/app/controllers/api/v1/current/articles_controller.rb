class Api::V1::Current::ArticlesController < Api::V1::BaseController
  before_action :authenticate_user!

  def create
    unsaved_article = UnsavedArticle.new(current_user).get || UnsavedArticle.new(current_user).register!
    render json: ArticleSerializer.new(unsaved_article).as_json
  end
end
