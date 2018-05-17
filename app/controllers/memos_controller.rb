class MemosController < ApplicationController
  def create
    @memo = Memo.new(memo_params)
    @memo.save
    Article.update(params['memo']['article_id'], {is_hold: true})
    redirect_back(fallback_location: root_path)
  end

  def update
    @memo = Memo.find(params[:id])
    @memo.update(memo_params)
    Article.update(params['memo']['article_id'], {is_hold: true})
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def memo_params
    params.require(:memo).permit(:type, :content, :user_id, :article_id)
  end
end
