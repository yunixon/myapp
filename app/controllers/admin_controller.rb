class AdminController < ApplicationController
  before_filter :login_required_filter
  before_filter :user_is_admin_filter?

  def tracks
    if params[:tag]
      @search = Track.active.page(params[:page]).per_page(30).tagged_with(params[:tag]).order('name').search(params[:q])
      @tracks = @search.result
    elsif params[:owned]
      @search = Track.where(:owner_id => current_user.id).page(params[:page]).per_page(30).order('name').search(params[:q])
      @tracks = @search.result
    else
      @search = Track.active.page(params[:page]).per_page(30).order('name').search(params[:q])
      @tracks = @search.result
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tracks }
    end
  end

 def dashboard
    @search = User.page(params[:page]).per_page(30).order('email').search(params[:q])
    @users = @search.result

    @count = User.count
  #  @users = User.page(params[:page]).per_page(30).order('email')

 end
end