class MicropostsController < ApplicationController
  self.responder = ApplicationResponder
  before_action :logged_in_user, only: [:create, :destroy, :vote ]
  before_action :correct_user,   only: [:destroy, :vote]
  respond_to :js, :json, :html

  def index
    @micropost = Micropost.all
  end

  def show
    @micropost= Micropost.find(params[:id])
  end

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "Micropost created!"
      redirect_to root_url
    else
      @feed_items = []
      render 'staticpage/home'
    end
  end

  def vote
    if !current_user.liked? @micropost
      @micropost.liked_by current_user
    else
      @micropost.unliked_by current_user
    end
    redirect_to @micropost.user
 end

  def destroy
    @micropost.destroy
    flash[:success] = "Micropost deleted"
    redirect_to request.referrer || root_url
  end

  private

  def micropost_params
    params.require(:micropost).permit(:content, :picture,:privat)
  end

  def correct_user
    @micropost = current_user.microposts.find_by(id: params[:id])
    redirect_to root_url if @micropost.nil?
  end
end