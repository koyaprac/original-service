class ArticlesController < ApplicationController
  def index
  @all = Article.all
  @qiita = Article.where(site_name: 'Qiita')
  @gn = Article.where(site_name: 'GoogleNews')
  end
  
  def show
  @article = Article.find_by(id: params['id'])
  @memo = @article.memos.find_or_create_by(user_id: current_user.id)
  end
end
# https://qiita.com/dawn_628/items/13fa64dc6d600e921ce3