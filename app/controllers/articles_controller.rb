class ArticlesController < ApplicationController

	def index
		@article = Article.new
		@articles = Article.all
	end

	def create
		@article = Article.new(article_params)

		if @article.save
			Pusher['test_channel'].trigger('reload', { event: "create"})
			redirect_to articles_path
		else
			render 'new'
		end
	end

	def destroy
		@article = Article.find(params[:id])
		@article.destroy
		Pusher['test_channel'].trigger('reload', { event: "destroy"})
		redirect_to articles_path
	end

	private

	def article_params
		params.require(:article).permit(:name)
	end
end
