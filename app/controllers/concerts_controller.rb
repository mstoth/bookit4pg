class ConcertsController < ApplicationController

  before_filter :require_mst_or_owner, :only=>[:destroy, :edit, :update]
  
  def venues_near
    @concert = Concert.find(params[:id])
    @venues = Venue.near(@concert,current_user,Bookit4pg::Application::SEARCH_RANGE)
  end

  def near_venue
    if !params[:id].nil?
      @venue=Venue.find(params[:id])
      @concerts=Concert.near(@venue,current_user,Bookit4pg::Application::SEARCH_RANGE)
    else
      @venue=nil
      @concerts=Concert.all
    end

    @venues=Venue.all
    @groups=Group.all
    @my_venues=current_user.venues
  end


  # GET /concerts
  # GET /concerts.xml
  def index
    @concerts = current_user.my_concerts
    @booked_concerts = []
    @concert_list = []
    @concerts.each do |c|
      if c.offer == false
        @booked_concerts << c
      else
        @concert_list << c
      end
    end
    @concerts = @concert_list
    
    @venues = Venue.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
    @groups = current_user.groups
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @concerts }
    end
  end

  # GET /concerts/1
  # GET /concerts/1.xml
  def show
    @concert = Concert.find(params[:id])
    @venues = Venue.all
    my_groups=current_user.groups
    # determine if owner and allow editing if so.
    @can_edit=false
    if my_groups.length > 0 
      my_groups.each do |mg|
	      if @concert.group_id == mg.id
	        @can_edit=true
	      end
      end
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @concert }
    end
  end

  # GET /concerts/new
  # GET /concerts/new.xml
  def new
    @concert = Concert.new
    @venues = Venue.all
    @groups = current_user.groups

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @concert }
    end
  end

  # GET /concerts/1/edit
  def edit
    @concert = Concert.find(params[:id])
    @groups = current_user.groups
    @venues = Venue.all
    my_groups=current_user.groups
    @can_edit=false
    if my_groups.length > 0 
      my_groups.each do |mg|
	      if @concert.group_id == mg.id
	        @can_edit=true
	      end
      end
    end
  end

  # POST /concerts
  # POST /concerts.xml
  def create
    @concert = Concert.new(params[:concert])
    no_webpage = params["no_webpage"]
    if no_webpage == "true"
      @concert.webpage = Group.find(@concert.group_id).website
    end
    @venues = Venue.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
    @groups = current_user.groups
    if !@concert.venue_id.nil? 
      @concert.zip = Venue.find(@concert.venue_id).zip
    else
      @concert.zip = Group.find(@concert.group_id).zip
    end

    respond_to do |format|
      if @concert.save
        if  @concert.offer
          send_concert_announcement(@concert)
        end
        format.html { redirect_to(@concert, :notice => 'Concert was successfully created.') }
        format.xml  { render :xml => @concert, :status => :created, :location => @concert }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @concert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /concerts/1
  # PUT /concerts/1.xml
  def update
    @concert = Concert.find(params[:id])
    @venues = Venue.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
    @groups = current_user.groups
    
    no_webpage = params["no_webpage"]
    if no_webpage == "true"
      params[:concert]["webpage"] = Group.find(@concert.group_id).website
    end
    
    if !@concert.venue_id.nil? 
      params[:concert]["zip"] = Venue.find(@concert.venue_id).zip
    else
      params[:concert]["zip"] = Group.find(@concert.group_id).zip
    end

    respond_to do |format|
      if @concert.update_attributes(params[:concert])
        format.html { redirect_to(@concert, :notice => 'Concert was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @concert.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /concerts/1
  # DELETE /concerts/1.xml
  def destroy
    @concert = Concert.find(params[:id])
    @concert.destroy

    respond_to do |format|
      format.html { redirect_to(concerts_url, :notice=> 'Concert was deleted.') }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def send_concert_announcement(c)
    venue_list = Venue.near(c,Bookit4pg::Application::SEARCH_RANGE)
    venue_list.each do |v|
      if !v.user_id.nil?
        u = User.find(v.user_id)
        if !u.nil? && u.notify
          UserMailer.new_concert(c,u).deliver
        end
      end
    end
  end
  
  def require_mst_or_owner
    if current_user.login == 'mstoth'
        return true
    end
    concert=Concert.find(params[:id])
    group=Group.find(concert.group_id)
    if current_user.groups.include? group
      return true
    end
    render '/agent/error', :notice=>"You do not have permission." 
    return false
  end
end
