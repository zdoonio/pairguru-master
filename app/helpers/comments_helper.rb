module CommentsHelper

  def check_user_commented_movie(user_id, movie_id)
    Comment.where(movie_id: movie_id, user_id: user_id).length >= 1
  end
end
