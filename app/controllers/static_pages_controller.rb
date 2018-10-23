class StaticPagesController < ApplicationController
  def index
    @static_page = StaticPage.find_by!(permalink: params[:permalink])
  end
end
