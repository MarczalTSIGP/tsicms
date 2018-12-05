class Admins::GalleriesController < Admins::BaseController
  def index
    @gallery = Gallery.find_by!(context: params[:context])
  end
end
