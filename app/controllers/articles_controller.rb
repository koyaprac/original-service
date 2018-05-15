class ArticlesController < ApplicationController
  def index
  @all = Article.all
  @qiita = Article.where(site_name: 'Qiita')
  @gn = Article.where(site_name: 'GoogleNews')
  end
end
# https://qiita.com/dawn_628/items/13fa64dc6d600e921ce3