class MicropostsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = 'メッセージを投稿しました。'
      redirect_to root_url
    else
      @pagy, @microposts = pagy(current_user.feed_microposts.order(id: :desc))
      flash.now[:danger] = 'メッセージの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = 'メッセージを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    unless @micropost
      redirect_to root_url
    end
  end
  
  
  #お気に入り設定(部分的には「users_controller」に記載すべき？？そもそも「likers」自体いらない？)
  def likings
    @user = User.find(params[:id])
    @pagy, @likings = pagy(@user.likings)
    counts(@likings)
  end
  
  
  
  #def likers
  #  @micropost = Micropost.find(params[:id])
  #  @pagy, @likers = pagy(@micropost.likers)
  #  counts(@user)
  #end
  
  
  
end

