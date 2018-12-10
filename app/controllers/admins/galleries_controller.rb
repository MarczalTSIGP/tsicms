class Admins::GalleriesController < Admins::BaseController
  def index
    @gallery = Gallery.find_by!(context: params[:context])

    if @gallery.contains_pictures
      render :pictures
    else
      render :documents
    end
  end

  def pictures; end

  def documents; end
end
