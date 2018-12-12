class Admins::DocumentsController < Admins::BaseController
  before_action :set_document, only: [:destroy]
  before_action :set_gallery

  add_breadcrumb I18n.t('breadcrumbs.galleries.name'), :admins_galleries_path
  add_breadcrumb I18n.t('breadcrumbs.documents.new'), :new_admins_document_path,
                 only: [:new, :create]

  def new; end

  def create
    if @gallery.upload_documents(gallery_params)
      feminine_success_create_message
      redirect_to admins_galleries_path(@gallery.context)
    else
      error_message
      render :new
    end
  end

  def destroy
    @document.destroy
    feminine_success_destroy_message
    redirect_to admins_galleries_path(@gallery.context)
  end

  protected

  def document_params
    params.require(:document).permit(:document)
  end

  def gallery_params
    if params[:gallery] && params[:gallery][:documents]
      params[:gallery][:documents]
    else
      []
    end
  end

  def set_document
    @document = Document.find(params[:id])
  end

  def set_gallery
    @gallery = Gallery.find_by!(context: params[:context])
  end
end
