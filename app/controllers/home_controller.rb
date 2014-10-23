class HomeController < ApplicationController
  def index
  end

  def login
  end

  def signup
  end

  def world
      if params[:search].present?
         @listings = Listing.near(params[:search], 50, :order => :distance)
      else
         @listings = Listing.all
         @hash = Gmaps4rails.build_markers(@locations) do |location, marker|
            marker.lat location.latitude
            marker.lng location.longitude
            marker.json({:id => location.id})
         end
      end
  end
end
