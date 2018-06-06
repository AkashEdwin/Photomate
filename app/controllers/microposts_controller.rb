class MicropostsController < ApplicationController
  self.responder = ApplicationResponder
  before_action :logged_in_user, only: [:create, :destroy, :vote ]
  before_action :correct_user,   only: [:destroy]
  before_action :find_post, only: [:vote]
  respond_to :js, :json, :html

  def index
    @micropost = Micropost.all
  end

  #Display resources
  def show
    @micropost= Micropost.find(params[:id])
    @comments= Comment.where(micropost_id: @micropost).order("created_at DESC")
  end

  #Post creation
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
    @value=params[:val]
    if !@value == params[:val]
        redirect_to @micropost.user
    else
      redirect_to @micropost
    end
 end

  #Destroying the post
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

  def find_post
    @micropost = Micropost.find_by(id: params[:val])
  end
end