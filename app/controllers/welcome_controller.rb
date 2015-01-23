class WelcomeController < ApplicationController

  def index
  	@venuetypes = Venuetype.all
  	@neighborhoods = Neighborhood.all

  	@recentActivity = Venue.recent + Neighborhood.recent + Venuetype.recent + Try.recent + Rating.recent + Comment.recent + ItemRating.recent
    @recentActivity.sort_by(&:updated_at)
  end

  def map
    @venues = Venue.all
  end

end
