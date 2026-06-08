# app/controllers/articles_controller.rb
class ArticlesController < ApplicationController
  before_action :require_login, except: %i[index show]
  before_action :set_article,   only:   %i[show edit update destroy report]
  before_action :require_owner, only:   %i[edit update destroy]

  # GET /articles
  # Any user (including guests) can read public (published) articles
  def index
    @articles = Article.published.order(created_at: :desc)
  end

  # GET /articles/:id
  def show
    # Anyone can read any published article; archived articles visible to owner only
    unless @article.published? || owner?
      redirect_to root_path, alert: "This article is not available."
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles
  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      redirect_to @article, notice: "Article created successfully."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # GET /articles/:id/edit  (owner only via before_action)
  def edit; end

  # PATCH/PUT /articles/:id  (owner only)
  def update
    if @article.update(article_params)
      redirect_to @article, notice: "Article updated successfully."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /articles/:id  (owner only)
  def destroy
    @article.destroy
    redirect_to articles_path, notice: "Article deleted."
  end

  # POST /articles/:id/report
  # Logged-in users can report *other* users' articles
  def report
    if owner?
      redirect_to @article, alert: "You cannot report your own article."
      return
    end

    @article.increment_reports!
    redirect_to @article, notice: "Article reported. Thank you."
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def require_owner
    unless owner?
      redirect_to root_path, alert: "You are not authorized to do that."
    end
  end

  def owner?
    @article.user == current_user
  end

  def article_params
    params.require(:article).permit(:title, :body, :image)
  end
end
