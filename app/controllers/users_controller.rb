class UsersController < ApplicationController

  before_filter :require_no_user, :only=>[:new, :create]
  before_filter :require_user, :only=>[:show, :edit, :update]
  before_filter :requre_mst, :only=>[:delete]

  def new
    @user = User.new
  end
  
  def groups_near_me
    @groups = Group.near(current_user)
  end
  
  def venues_near_me
    @venues = Venue.near(current_user)
  end
  
  def join_venue
    @venue = Venue.find(params[:id])
    @venue.user_id = current_user.id
    @venue.save
    current_user.venues << @venue
    current_user.save
    redirect_to "/agent/home", :notice=>"You are now connected to #{@venue.name}. Please edit the venue."
  end
    
  def leave_venue
    @venue = Venue.find(params[:id])
    @venue.user_id = nil
    @venue.save
    redirect_to "/venues", :notice=>"You are not connected with #{@venue.name}."
  end

  def join_group
    gid=params[:id]
    g=Group.find(gid)
    if current_user.groups.include? g
      redirect_to :home, :notice=>'You are already a member of this group.'
    else
      current_user.groups << g
      current_user.save
      redirect_to :home, :notice=>"You have joined #{g.title}"
    end    
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default :home
    else
      render :action => :new
    end
  end

  def show
    @user = current_user
    # @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def delete
      @user = User.find(params[:id])
      @user.destroy
      redirect_to "/admins/allusers"
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end
