class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[ index show ]
  before_action :set_article, only: %i[ edit update destroy ]

  # GET /sample_articles or /sample_articles.json
  def index
    # @articles = Article.all
    # @articles = Article.all.page params[:page]
    articles = Article.all.preload(:tags)
    articles = articles.where("title LIKE ?", "%#{params[:title]}%") if params[:title].present?
    @articles = articles.page params[:page]
  end

  # GET /sample_articles/1 or /sample_articles/1.json
  def show
    @article = Article.find(params[:id])
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
    # @article = Article.new(article_params)
    @article = current_user.articles.new(article_params)
      if @article.save
        redirect_to article_url(@article), notice: "#{t('activerecord.models.article')}を作成しました。"
      else
        render :new, status: :unprocessable_entity
      end
    end

  # PATCH/PUT /sample_articles/1 or /sample_articles/1.json
  def update
      if @article.update(article_params)
        redirect_to article_url(@article), notice: "#{t('activerecord.models.article')}を編集しました。"
      else
        render :edit, status: :unprocessable_entity
      end
  end

  # DELETE /sample_articles/1 or /sample_articles/1.json
  def destroy
    @article.destroy
    redirect_to articles_url, notice: "#{t('activerecord.models.article')}を削除しました。"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = current_user.articles.find(params[:id])
      # @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :content, tag_ids:[])
    end
end
