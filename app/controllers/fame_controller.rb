class FameController < ApplicationController
  def index
    @users = User.includes(:comments).where("DATE(comments.created_at) > ?", Date.today - 7).references(:comments).limit(10)
  end
end
