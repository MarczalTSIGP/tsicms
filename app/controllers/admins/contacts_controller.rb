class Admins::ContactsController < Admins::BaseController
  before_action :set_contact, only: [:show]

  add_breadcrumb I18n.t('breadcrumbs.contacts.name'), :admins_contacts_path

  def index
    @contacts = Contact.order(created_at: :desc)
  end

  def show
    add_breadcrumb I18n.t('breadcrumbs.contacts.show', name: "##{@contact.id}"),
                   :admins_contact_path
    @contact.mark_as_read
  end

  def mark_messages_read
    Contact.where(id: params[:contact_ids]).update(read: true)
  end

  def mark_messages_unread
    Contact.where(id: params[:contact_ids]).update(read: false)
  end

  def mark_all_messages_read
    Contact.find(:all).update(read: true)
  end

  protected

  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :message)
  end

  def set_contact
    @contact = Contact.find(params[:id])
  end
end
