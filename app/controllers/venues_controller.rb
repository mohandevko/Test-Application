class VenuesController < ApplicationController
  before_filter :is_login
  before_filter :is_approved,:except => [:index]
  
  def index
    @venues = current_user.user_venues
  end
  
  def new
    @venue = UserVenue.new
    1.times{@venue.images.build}
  end
  
  def create
    @venue = UserVenue.new(venue_params)
    @venue.user_id = current_user.id
    if @venue.save
    @location = Location.new(:name => params[:user_venue][:city],:tag => params[:tag] )
    @location.save
      if params[:user_venue][:images_attributes]
        params[:user_venue][:images_attributes].each do |img|
          Image.create(:title => img.last["title"],:photo => img.last["photo"],:credit => img.last["credit"],:user_venue_id => @venue.id) if !img.last["photo"].blank?
        end
      end
      redirect_to venues_path
    else
      1.times{@venue.images.build}
      render :action => :new
    end
  end
  
  def show
    @venue = UserVenue.find(params[:id])
  end
  
  def is_approved
    unless current_user.approved == true
      flash[:error] = "You are not approved by admin!"
      redirect_to root_path
    end
  end
  
  private
  
  def venue_params
    params.require(:user_venue).permit(:name, :description,:city,:state,:country, :images_attributes => [:title,:photo,:credit])
  end
end
