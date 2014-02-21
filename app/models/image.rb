class Image < ActiveRecord::Base
  belongs_to :user_venue
  has_attached_file :photo, :styles =>
    { :medium => "300x300>", :thumb => "30x40>" }
  validates :title,:presence => true
  validates_attachment_content_type :photo, :content_type => ['image/jpeg','image/jpg','image/tiff', 'image/png', 'image/gif','image/bmp', 'image/x-png', 'image/pjpeg']
end
