class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    user = User.find_by(id: params[:followed_id])
    return redirect_to root_path unless user
    current_user.follow(user)
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end

  def destroy
    user = Relationship.find params[:id].followed
    return redirect_to root_path unless user
    current_user.unfollow user
    respond_to do |format|
      format.html{redirect_to @user}
      format.js
    end
  end
end
