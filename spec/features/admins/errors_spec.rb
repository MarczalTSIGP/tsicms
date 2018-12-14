require 'rails_helper'

RSpec.describe 'Errors Admins Page', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#not_found' do
    it '404 - resource not found' do
      visit admins_404_url

      expect(page).to have_content(text: '404 - Not Found')
      expect(page).to have_content(text: 'Ops!! Seems we could`t find the page you`re looking for.')
    end
  end

  describe '#unacceptable' do
    it '422 - params unacceptable' do
      visit admins_422_url

      expect(page).to have_content(text: '422 - Unacceptable')
      expect(page).to have_content(text: 'Hey, looks like we doing something wrong.
                                         Please check it and try again.')
    end
  end

  describe '#internal_error' do
    it '500 - internal server error' do
      visit admins_500_url

      expect(page).to have_content(text: '500 - Internal Error')
      expect(page).to have_content(text: 'Hey, looks like we had a problem at our server.')
      expect(page).to have_content(text: 'We`ll be trying to solve the problem faster as we can.')
    end
  end
end
