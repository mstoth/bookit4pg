class VenuesController < ApplicationController
  # GET /venues
  # GET /venues.xml
  def index
    @venues = current_user.venues
    @avail_venues = Venue.where(:user_id=>nil)
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @venues }
    end
  end

  def concerts_near
    @genre = params[:genre]
    @venue = Venue.find(params[:id])
    @concerts = Concert.near(@venue,100)

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
end
