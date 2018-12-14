require 'rails_helper'

RSpec.describe 'Contacts', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Contact.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#index' do
    let!(:contacts) { create_list(:contact, 3) }

    it 'show all contacts' do
      visit admins_contacts_path
      contacts.each do |c|
        expect(page).to have_content(c.name)
        expect(page).to have_content(c.email)
        expect(page).to have_content(I18n.l(c.created_at, format: :short))
      end
    end
  end

  describe '#show' do
    it 'show contact page' do
      contact = create(:contact)
      visit admins_contact_path(contact)

      expect(page).to have_content(contact.name)
      expect(page).to have_content(contact.email)
      expect(page).to have_content(contact.phone)
      expect(page).to have_content(contact.message)
      expect(page).to have_content(I18n.l(contact.created_at, format: :short))
      expect(page).to have_link(href: admins_contacts_path)
    end
  end
end
