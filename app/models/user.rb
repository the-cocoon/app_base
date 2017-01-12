class User < ActiveRecord::Base
  include ::RoleSystem
  include ::TheCommentsBase::User
  include ::TheCommentsBase::Commentable

  #################################
  # UserRoom::User
  #################################

  include ::UserRoom::User

  def to_param; self.login end

  def oauth_default_email_domain
    'example.com'
  end

  def comments_admin?
    admin?
  end

  #################################
  # ~ UserRoom::User
  #################################

  if defined? ::RailsShop
    include ::RailsShop::User
  end

  has_many :hubs
  has_many :pages
  has_many :posts
  has_many :pub_tags

  has_many :attached_images
end
