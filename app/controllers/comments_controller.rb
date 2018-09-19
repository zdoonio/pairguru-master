class CommentsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.build(comment_params())
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Comment added."
      redirect_to movie_path(@movie)
    else
      flash[:alert] = "There is some errors."
      redirect_to movie_path(@movie)
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @comment = @movie.comments.find(params[:id])
    if @comment.user.id == current_user.id
      @comment.destroy
      flash[:notice] = "Comment deleted."
      redirect_to movie_path(@movie)
    else
      flash[:alert] = "That comment does not belongs to you."
      redirect_to movie_path(@movie)
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
