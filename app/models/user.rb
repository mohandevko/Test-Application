class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable,:confirmable, :validatable
  has_many :user_venues,:dependent => :destroy
  validates :first_name,:last_name,:username,:presence => true
  #validates_format_of :username, :with => /^[a-z\d_]+$/,:multiline => true
  has_attached_file :attach, :styles =>
    { :medium => "300x300>", :thumb => "30x40>" },:default_url => "/assets/avatar.png"

  validates_attachment_presence :attach,:on => :update
  validates_attachment_content_type :attach, :content_type => ['image/jpeg','image/jpg','image/tiff', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg'],:on => :update
	# Validation of the size of the attached file
  def self.create_from_omniauth(auth)
    user = User.find_by_provider_and_uid(auth["provider"],auth["uid"])
    unless user
      user = User.new(:first_name => auth["extra"]["raw_info"]["first_name"],:last_name => auth["extra"]["raw_info"]["last_name"],:username => auth["extra"]["raw_info"]["username"])
      user.email = auth["extra"]["raw_info"]["email"]
      user.uid = auth["uid"]
      user.provider = auth["provider"]
      user.photo = auth["info"]["image"]
      user.save(:validate => false)
      user.confirm!
    end    
    return user
  end
end
