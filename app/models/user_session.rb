class UserSession < Authlogic::Session::Base
  
  logout_on_timeout true # default if false
  
  def to_key
    new_record? ? nil : [ self.send(self.class.primary_key) ]
  end

end
