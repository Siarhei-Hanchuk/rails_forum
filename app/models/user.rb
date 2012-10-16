class User < ActiveRecord::Base
  attr_accessible :last_visit, :login, :status, :avatar, :pass, :email, :pass_confirmation, :created_at
  has_many :topics
  has_many :posts

  mount_uploader :avatar, AvatarUploader

  attr_accessor :avatar_file_name

  validates :login, :uniqueness => true
  #validates_format_of :login, :with => /\A\w\Z/, :on => :create
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create
  validates :pass, :confirmation => true
  validates :login, :length=> {:minimum=>3, :maximun=>12}
  validates :login, :pass, :status, :presence => true

  def is_admin
    if status%10 == 1
      true
    end
  end

  def banned?
    true if status/10 == 1
  end

  def User.encrypt_password(pass)
  	Digest::SHA2.hexdigest(pass+'salt')
  end

  def pass=(pass)
  	if pass.present?
  		write_attribute(:pass,self.class.encrypt_password(pass))
  	end		
  end

  def pass_confirmation=(pass)
  	if pass.present?
  		write_attribute(:pass_confirmation,self.class.encrypt_password(pass))
  	end		
  end

  def User.auth(login, pass)
  	if user = find_by_login(login)
  		p encrypt_password(pass)
  		if user.pass == encrypt_password(pass)
  			user
  		end
  	end
  end

  def ban
    self.status=status+10 if !self.banned?
  end

  def unban
    self.status=status-10 if self.banned?
  end
end
