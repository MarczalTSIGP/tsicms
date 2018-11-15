class Admins::FaqsController < Admins::BaseController
  before_action :set_faq, only: [:edit, :update, :destroy, :show]

  add_breadcrumb I18n.t('breadcrumbs.faqs.name'), :admins_faqs_path
  add_breadcrumb I18n.t('breadcrumbs.faqs.new'), :new_admins_faq_path, only: [:new, :create]

  def index
    @faqs = Faq.order(created_at: :desc).page params[:page]
  end

  def new
    @faq = Faq.new
  end

  def create
    @faq = Faq.new(faq_params)

    if @faq.save
      feminine_success_create_message
      redirect_to admins_faqs_path
    else
      error_message
      render :new
    end
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.faqs.edit', name: "##{@faq.id}"),
                   :edit_admins_faq_path
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.faqs.show', name: "##{@faq.id}"),
                   :admins_faq_path
  end

  def update
    if @faq.update(faq_params)
      feminine_success_update_message
      redirect_to admins_faqs_path
    else
      add_breadcrumb I18n.t('breadcrumbs.faqs.edit', name: "##{@faq.title}"),
                     :edit_admins_faq_path

      error_message
      render :edit
    end
  end

  def destroy
    @faq.destroy
    feminine_success_destroy_message
    redirect_to admins_faqs_path
  end

  protected

  def faq_params
    params.require(:faq).permit(:title, :answer)
  end

  def set_faq
    @faq = Faq.find(params[:id])
  end
end
