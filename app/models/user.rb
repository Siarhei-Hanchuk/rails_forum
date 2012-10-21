class User < ActiveRecord::Base
  before_create :create_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :provider, :url, :username
  attr_accessible :roles

  attr_accessible :avatar
  mount_uploader :avatar, AvatarUploader
  attr_accessor :avatar_file_name

  has_many :topics
  has_many :posts  
  has_many :comments

  has_many :likes

  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, 
        :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username,
        :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20])
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte,
        :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain,
        :email => access_token.extra.raw_info.domain+'@vk.com', :password => Devise.friendly_token[0,20]) 
    end
  end

  UsersRole = %w[admin moder author user banned]
  def roles=(roles)
    self.roles_mask = (roles & UsersRole).map { |r| 2**UsersRole.index(r) }.inject(0, :+)
  end

  def roles
    UsersRole.reject do |r|
      ((roles_mask || 0) & 2**UsersRole.index(r)).zero?
    end
  end

  def is?(role)
    roles.include?(role.to_s)
  end

  private
    def create_role
      self.roles = ["user"]
    end  
end
