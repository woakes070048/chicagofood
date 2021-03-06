class CommentsController < ApplicationController
	before_filter :authenticate_user!, except: [:index, :show]
	before_action :set_comment, only: [:show, :edit, :update, :destroy]
	before_action :set_display_user, only: [:index, :show]
	before_action :set_venue, only: [:create]

	def index
		@comments = @user.comments.sort{ |a,b| b.updated_at <=> a.updated_at }
	end

	def create
    @comment = @venue.comments.create(comment_params)
    @comment.user_id = current_user.id
    @comment.save
    redirect_to venue_path(@venue)
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to venue_path(@comment.venue) }
    end
  end

  private
  	def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:user_id, :body, :private)
    end

end
