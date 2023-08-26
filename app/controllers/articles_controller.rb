class ArticlesController < ApplicationController
  before_action :set_article, only: %i[ show edit update destroy ]

  # GET /sample_articles or /sample_articles.json
  def index
    @articles = Article.all
  end

  # GET /sample_articles/1 or /sample_articles/1.json
  def show
  end

  # GET /sample_articles/new
  def new
    @article = Article.new
  end

  # GET /sample_articles/1/edit
  def edit
  end

  # POST /sample_articles or /sample_articles.json
  def create
    @article = Article.new(article_params)
      if @article.save
        redirect_to article_url(@article), notice: "article was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
  end

  # PATCH/PUT /sample_articles/1 or /sample_articles/1.json
  def update
      if @article.update(article_params)
        redirect_to article_url(@article), notice: "article was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /sample_articles/1 or /sample_articles/1.json
  def destroys
    @article.destroy
    redirect_to articles_url, notice: "article was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content)
    end
end
