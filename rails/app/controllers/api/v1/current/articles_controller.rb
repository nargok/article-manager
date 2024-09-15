class Api::V1::Current::ArticlesController < Api::V1::BaseController
  before_action :authenticate_user!

  def create
    unsaved_article = UnsavedArticle.new(current_user).get || UnsavedArticle.new(current_user).register!
    render json: ArticleSerializer.new(unsaved_article).as_json
  end

  def update
    article = current_user.articles.find(params[:id])
    article.update!(article_params)
    render json: article
  end

  private

  def article_params
    params.require(:article).permit(:title, :content, :status)
  end
end
