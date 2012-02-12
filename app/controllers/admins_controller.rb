class AdminsController < ApplicationController
  before_filter :require_mst

  # GET /admins
  # GET /admins.xml
  def index
    @users = User.all
    @groups = Group.all
    @concerts = Concert.all
    @venues = Venue.all
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @admins }
    end
  end

  def error
  end

  def venues
    @venues=Venue.all
  end

  def groups
    @groups=Group.all
  end

  def concerts
    @concerts=Concert.all
  end

  def allusers
    @users_list = User.all
  end

end
