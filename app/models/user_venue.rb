class UserVenue < ActiveRecord::Base
  has_many :images,:dependent => :destroy
  belongs_to :user
  accepts_nested_attributes_for :images,  :allow_destroy  => true,:reject_if => proc {|attrs| attrs['photo_file_name'].blank?}
  validates :name,:city,:presence => true
end
