class UsersController < ApplicationController

  before_filter :require_no_user, :only=>[:new, :create]
  before_filter :require_user, :only=>[:show, :edit, :update]
  before_filter :requre_mst, :only=>[:delete]

  def stop_notification
    @user=User.find(params[:id])
    @user.notify=false
    @user.save
  end
  
  def new
    @user = User.new
  end
  
  def guest
    @user = User.new
    @user.login="Guest" + rand.to_s
    @user.password=@user.login
  	@user.password_confirmation=@user.login
  	@user.email=@user.login + "@virtualpianist.com"
  end
  
  def groups_near_me
    @groups = Group.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
    @groups.sort! { |a,b| a.title <=> b.title }
  end
  
  def venues_near_me
    if params["distance"].nil?
      @venues = Venue.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
      @venues.sort! { |a,b| a.name <=> b.name }
      @current_dist = Bookit4pg::Application::SEARCH_RANGE
    else
      @venues = Venue.near(current_user,params["distance"])
      @venues.sort! { |a,b| a.name <=> b.name }
      @current_dist = params["distance"]
    end
  end
  
  def join_venue
    @venue = Venue.find(params[:id])
    current_user.venues << @venue
    current_user.save
    redirect_to edit_venue_path(@venue), :notice=>"Please make sure all the information is correct."
  end
    
  def leave_venue
    @venue = Venue.find(params[:id])
    current_user.venues.delete @venue
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
  
  def leave_group
    gid=params[:id]
    g=Group.find(gid)
    current_user.groups.delete g
    if g.users.length == 0
      g.locked = false
      g.save
    end
    redirect_to :home, :notice=>"You have left the group, #{g.title}"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      if @user.login[0..4]=="Guest"
        flash[:notice]="Welcome Guest"
      else
        flash[:notice] = "Account registered!"
      end
      redirect_back_or_default :home
    else
      if @user.login[0..4]=="Guest"
        render :action=>:guest
      else
        render :action => :new
      end
    end
  end

  def show
    if params[:id].nil?
      @user = current_user
    else
      @user = User.find(params[:id])
    end
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
