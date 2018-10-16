class StaticPagesController < ApplicationController
  def index
    @static_page = StaticPage.find_by_permalink!(params[:permalink])
  end
end
