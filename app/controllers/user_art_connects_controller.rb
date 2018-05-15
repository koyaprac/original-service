class UserArtConnectsController < ApplicationController
  def create
    puts params
    @article = Article.find_by(id: params[:article_id])
    
    if params[:type] == 'Favorite'
      current_user.favorite(@article)
      Article.update(@article.id, {is_hold: true})
    elsif params[:type] == 'Readlater'
      current_user.readlater(@article)
      Article.update(@article.id, {is_hold: true})
    end

    redirect_back(fallback_location: root_path)
  end

  def destroy
    @article = Article.find_by(id: params[:article_id])

    if params[:type] == 'Favorite'
      current_user.unfavorite(@article)
      Article.update(@article.id, {is_hold: false})
    elsif params[:type] == 'Readlater'
      current_user.unreadlater(@article)
      Article.update(@article.id, {is_hold: false})
    end


    redirect_back(fallback_location: root_path)
  end
end
