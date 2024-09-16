class Api::V1::Current::ArticlesController < Api::V1::BaseController
  before_action :authenticate_user!

  def index
    articles = current_user.articles.not_unsaved.order(created_at: :desc)
    render json: ArticleSerializer.new(articles).as_json
  end

  def show
    article = current_user.articles.find(params[:id])
    render json: ArticleSerializer.new(article)
  end

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
