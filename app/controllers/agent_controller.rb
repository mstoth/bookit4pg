class AgentController < ApplicationController


  def contact
  end

  def error
  end

  def home
    if current_user.nil?
      redirect_to user_sessions_new_path
      return
    end
    @group = current_user.groups.first
    if !@group.nil?
      @group_id=@group.id
    end
    @venue = current_user.venues.first
    if  !@venue.nil?
      @venue_id=@venue.id
    end
  end

  def about
  end

  def search
  end

  def help
    id=params[:id]
    case id
      when '1'
      render :action=>'whatis'
      when '2'
      render :action=>'imavenue'
      when '3'
      render :action=>'imagroup'
      when '4'
      render :action=>'canbeboth'
      when '5'
      render :action=>'cost'
      when '6'
      render :action=>'how2book'
      when '7'
      render :action=>'getknown'
    else
    end
  end

end
