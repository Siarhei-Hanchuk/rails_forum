module ControllerMacros
  def login role = nil
    before(:each) do
      user=User.create
      user.roles_mask=8
      user.roles_mask=11 if role==:admin
      user.username='UserName'
      user.save
      session[:user_id]=user.id
    end
  end
end