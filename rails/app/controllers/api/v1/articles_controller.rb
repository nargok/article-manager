class Api::V1::ArticlesController < ApplicationController
  include Pagination

  def index
    articles = Article.published.order(created_at: :desc).page(params[:page] || 1).per(10).eager_load(:user)
    render json: {
      articles: ArticleSerializer.new(articles).as_json,
      meta: ArticleSerializer.meta(articles)
    }
  end

  def show
    article = Article.published.find(params[:id])
    render json: ArticleSerializer.new(article).serialize
  end
end
