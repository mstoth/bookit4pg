class UserSessionsController < ApplicationController

  before_filter :require_no_user, :only=>[:new,:create]
  before_filter :require_user, :only => :destroy

  def show
    @user=current_user
  end

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Login successful!"
      redirect_back_or_default :home
    else
      render :action => :new
    end
  end

  def destroy
    c=""
    if current_user.login[0..4]=="Guest"
      c=current_user
    end
    current_user_session.destroy
    if c!=""
      if c.login[0..4]=="Guest"
        c.destroy
      end
    end
    flash[:notice] = "Logout successful!"
    redirect_back_or_default new_user_session_url
  end

end
