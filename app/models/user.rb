class User < ActiveRecord::Base
  before_create :create_role
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :nickname, :provider, :url, :username
  attr_accessible :roles, :avatar_cache
  attr_accessible :ava

  attr_accessible :avatar
  mount_uploader :avatar, AvatarUploader
  attr_accessor :avatar_file_name

  has_many :topics
  has_many :posts  
  has_many :comments
  has_many :likes

  def self.find_for_github_oauth access_token
    if user = User.where(:url => access_token.info.urls.GitHub).first
      user
    else 
      User.create!(:provider =>'github' , :url => access_token.info.urls.GitHub,
        :username => access_token.info.nickname, :nickname => access_token.info.nickname,
        :email => '', :password => Devise.friendly_token[0,20],
        :ava=>access_token.extra.raw_info.avatar_url)
    end
  end


  def self.find_for_google_oauth access_token
    if user = User.where(:url => access_token.extra.raw_info.link).first
      user
    else 
      User.create!(:provider => 'google_oauth2', :url => access_token.extra.raw_info.link,
        :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.name,
        :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20],
        :ava => access_token.extra.raw_info.picture)
    end
  end

  def self.find_for_facebook_oauth access_token
    if user = User.where(:url => access_token.info.urls.Facebook).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Facebook, 
        :username => access_token.extra.raw_info.name, :nickname => access_token.extra.raw_info.username,
        :email => access_token.extra.raw_info.email, :password => Devise.friendly_token[0,20],
        :ava=>access_token.info.image)
    end
  end

  def self.find_for_vkontakte_oauth access_token
    if user = User.where(:url => access_token.info.urls.Vkontakte).first
      user
    else 
      User.create!(:provider => access_token.provider, :url => access_token.info.urls.Vkontakte,
        :username => access_token.info.name, :nickname => access_token.extra.raw_info.domain,
        :email => '', :password => Devise.friendly_token[0,20],
        :ava=>access_token.extra.raw_info.photo_big)
    end
  end

  ROLES = %w[admin moder nothing user banned]
  def roles=(roles)
    self.roles_mask = (roles & roles).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask || 0) & 2**ROLES.index(r)).zero?
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
