class ArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def index
    articles = Article.all.includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end
 
  def show
    session[:pages_view] ||= 0
    session[:pages_view] =  session[:pages_view].to_i + 1
   
    article = Article.find(params[:id])

    if session[:pages_view] < 4
    

    render json: article

    session[:pages_view] = session[:pages_view] + 1
   
    else 
      render json: {"error": "Maximum articles  viewed subscribe to continue"}, status: :unauthorized
    end
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

end
