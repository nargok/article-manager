class Api::V1::ArticlesController < ApplicationController
  include Pagination

  def index
    articles = Article.published.order(created_at: :desc).page(params[:page] || 1).per(10).eager_load(:user)
    # articles_response = articles.map { |article| ArticleSerializer.new(article).as_json  }
    render json: ArticleSerializer.new(articles).serialize, meta: pagination(articles), adapter: :json
  end

  def show
    article = Article.published.find(params[:id])
    render json: ArticleSerializer.new(article).serialize
  end
end
