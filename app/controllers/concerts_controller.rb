class ConcertsController < ApplicationController


  def venues_near
    @concert = Concert.find(params[:id])
    @venues = Venue.near(@concert,20)
  end

  def near_venue
    if !params[:id].nil?
      @venue=Venue.find(params[:id])
      @concerts=Concert.near(@venue,20)
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
    @venues = Venue.all
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
    if !@concert.venue_id.nil? 
      @concert.zip = Venue.find(@concert.venue_id).zip
    else
      @concert.zip = Group.find(@concert.group_id).zip
    end

    respond_to do |format|
      if @concert.save
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

    if !@concert.venue_id.nil? 
      @concert.zip = Venue.find(@concert.venue_id).zip
    else
      @concert.zip = Group.find(@concert.group_id).zip
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
      format.html { redirect_to(concerts_url) }
      format.xml  { head :ok }
    end
  end
end
