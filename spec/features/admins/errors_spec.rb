require 'rails_helper'

RSpec.describe 'Errors Admins Page', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#not_found' do
    it '404 - resource not found' do
      visit 'administradores/404'

      expect(page).to have_content("404 - Not Found\nOops!! Seems we could't find the page you're",
                                   'looking for.')
    end
  end

  describe '#unacceptable' do
    it '422 - params unacceptable' do
      visit 'administradores/422'

      expect(page).to have_content('422 - Unacceptable\nHey, looks like we doing something wrong.',
                                   'Please check it and try again.')
    end
  end

  describe '#internal_error' do
    it '500 - internal server error' do
      visit 'administradores/500'

      expect(page).to have_content('500 - Internal Error\nHey, looks like we had a problem at our ',
                                   "server.\nWe'll be trying to solve the problem.")
    end
  end
end
