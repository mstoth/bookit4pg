class AgentController < ApplicationController


  
  def contact
  end

  def error
  end
  
  def forgot
    if request.post? 
      @user = User.find_by_email(params[:email])
      if @user
 	      @new_password = random_password
	      @user.password = @new_password
	      @user.save
	      UserMailer.send_password(@user,@new_password).deliver
	      redirect_to user_sessions_new_path, :notice=>'Your new password has been sent to your email address.'
	      return
      end
    end
  end
  
  def change_password
    @user = current_user
    if request.post? 
      @newpw1=params[:newpw1]
      @newpw2=params[:newpw2]
      @oldpw = params[:oldpw]
      if @newpw1 != @newpw2
	      redirect_to :change_password, :notice=>'Passwords are not equal'
	      return
      end
      if User.authenticate(@user.email,@oldpw)
	      @user.password=@newpw1
	      @user.save
	      redirect_to '/admin/index',:notice=>'Password changed.'
	      return
      else
	      redirect_to '/admin/change_password', :notice=>'Invalid password.'
	      return
      end
    end
  end
      

  def random_password(size = 8)
    chars = (('a'..'z').to_a + ('0'..'9').to_a) - %w(i o 0 1 l 0)
    (1..size).collect{|a| chars[rand(chars.size)] }.join
  end

  def home
    if current_user.nil?
      redirect_to user_sessions_new_path
      return
    end
    @booked=[]
    @unbooked=[]
    @group = current_user.groups.first
    if !@group.nil?
      @group_id=@group.id
      @groups = current_user.groups
      if @groups.length > 0
        @groups.each do |g|
          g.concerts.each do |c|
            if c.offer
              @unbooked << c
            else
              @booked << c
            end
          end
        end
      end
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
      when '8'
      render :action=>'nowebsite'
    else
    end
  end

end
