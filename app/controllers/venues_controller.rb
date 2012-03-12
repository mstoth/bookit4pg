class VenuesController < ApplicationController
  before_filter :require_not_guest, :except=>[:index, :show]
  before_filter :require_mst_or_owner, :only=>[:edit, :destroy, :update]
  
  # GET /venues
  # GET /venues.xml
  def index
    @venues = current_user.venues
    @venue_list = []
    @avail_venues = Venue.near(current_user,Bookit4pg::Application::SEARCH_RANGE)
    @avail_venues.each do |v|
      if v.user_id.nil?
        @venue_list << v
      end
    end
    @avail_venues = @venue_list
    @avail_venues.sort! { |a,b| a.name <=> b.name }
    @venues.sort! { |a,b| a.name <=> b.name }
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  def concerts_near
    @genre = params[:genre]
    @venue = Venue.find(params[:id])
    @concerts = Concert.near(@venue,Bookit4pg::Application::SEARCH_RANGE)
    @concert_list = []
    @concerts_booked = []
    @concerts.each do |c|
      if c.offer
        @concert_list << c
      else
        @concerts_booked << c
      end
    end
    @concerts = @concert_list
    
    @genres = ['All']
    @concerts.each do |c|
      if !(@genres.include? c.genre)
        @genres << c.genre unless c.genre.nil?
      end
    end

    @selected_concerts = []

    if @genre.nil? || @genre=='All'
      @selected_concerts = @concerts
    else
      @concerts.each do |c|
        if c.genre == @genre
          @selected_concerts << c
        end
      end
    end

    @my_venues = current_user.venues

  end

  # GET /venues/1
  # GET /venues/1.xml
  def show

    @venue = Venue.find(params[:id])
    @concerts = Concert.where(:venue_id=>@venue.id)
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/new
  # GET /venues/new.xml
  def new
    @venue = Venue.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @venue }
    end
  end

  # GET /venues/1/edit
  def edit
    @venue = Venue.find(params[:id])
  end

  # POST /venues
  # POST /venues.xml
  def create
    @venue = Venue.new(params[:venue])

    respond_to do |format|
      if @venue.save
        current_user.venues << @venue
        current_user.save
        format.html { redirect_to(@venue, :notice => 'Venue was successfully created.') }
        format.xml  { render :xml => @venue, :status => :created, :location => @venue }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /venues/1
  # PUT /venues/1.xml
  def update
    @venue = Venue.find(params[:id])

    respond_to do |format|
      if @venue.update_attributes(params[:venue])
        format.html { redirect_to(@venue, :notice => 'Venue was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @venue.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1
  # DELETE /venues/1.xml
  def destroy
    @venue = Venue.find(params[:id])
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to(venues_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def require_mst_or_owner
    if current_user.login == 'mstoth'
        return true
    end
    venue=Venue.find(params[:id])
    if current_user.venues.include? venue 
      return true
    end
    render '/agent/error', :notice=>"You do not have permission." 
    return false
  end
  
  def require_not_guest
    if current_user.login[0..4]=="Guest"
      render '/agent/error', :notice=>"You do not have permission as a Guest."
      return false
    end
    return true
  end
  
end
