class FavoritesController < ApplicationController
  before_action :require_user_logged_in
 #お気に入り登録の設定
  def create

    micropost = Micropost.find(params[:like_id])
    current_user.like(micropost)
    flash[:success] = '投稿をお気に入り登録しました。'
    redirect_to current_user
  end

  def destroy

    micropost = Micropost.find(params[:like_id])
    current_user.unlike(micropost)
    flash[:success] = '投稿のお気に入りを解除しました。'
    redirect_to current_user
  end
  
    
  
end
