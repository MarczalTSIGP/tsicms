class Admins::PicturesController < Admins::BaseController
  before_action :set_picture, only: [:edit, :update, :destroy]
  before_action :set_gallery

  add_breadcrumb I18n.t('breadcrumbs.galleries.name'), :admins_galleries_path
  add_breadcrumb I18n.t('breadcrumbs.pictures.new'), :new_admins_picture_path,
                 only: [:new, :create]

  def new
    @picture = Picture.new
  end

  def create
    # @picture = Picture.new(picture_params)
    #
    # if @picture.save
    #   feminine_success_create_message
    #   redirect_to admins_galleries_path(@gallery.context)
    # else
    #   error_message
    #   render :new
    # end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.pictures.edit', name: "##{@picture.id}"),
                   :edit_admins_picture_path
  end

  def update
    if @picture.update(picture_params)
      feminine_success_update_message
      redirect_to admins_galleries_path(@gallery.context)
    else
      add_breadcrumb I18n.t('breadcrumbs.pictures.edit', name: "##{@picture.id}"),
                     :edit_admins_picture_path

      error_message
      render :edit
    end
  end

  def destroy
    @picture.destroy
    feminine_success_destroy_message
    redirect_to admins_galleries_path(@gallery.context)
  end

  protected

  def picture_params
    params.require(:picture).permit(:label, :image)
  end

  def set_picture
    @picture = Picture.find(params[:id])
  end

  def set_gallery
    @gallery = Gallery.find_by!(context: params[:context])
  end
end
