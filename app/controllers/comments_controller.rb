class CommentsController < ApplicationController
  before_action :find_post
  before_action :find_comment ,only: [:destroy,:edit,:update,:commenter]
  before_action :commenter ,only: [:destroy,:edit,:update]
  def create
    @comment = @micropost.comments.create(params[:comment].permit(:content))
    @comment.user_id = current_user.id
    @comment.save

    if @comment.save
      redirect_to micropost_path(@micropost)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to micropost_path(@micropost)

  end

  def edit

  end

  def update
    if @comment.update(params[:comment].permit(:content))
      redirect_to micropost_path(@micropost)
    end
  end

  private

  def find_post
    @micropost= Micropost.find(params[:micropost_id])
  end

  def find_comment
    @comment= @micropost.comments.find(params[:id])
  end

  def commenter
    unless current_user.id==@comment.user_id
      flash[:notice]="You are not allowed"
      redirect_to @micropost
    end
  end
end
