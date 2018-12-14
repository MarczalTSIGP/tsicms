require 'rails_helper'

RSpec.describe 'Errors Public Page', type: :feature do
  describe '#not_found' do
    it '404 - resource not found' do
      visit '404'

      expect(page).to have_content("404 - Not Found\nOops!! Seems we could't find the page you're",
                                   'looking for.')
    end
  end

  describe '#unacceptable' do
    it '422 - params unacceptable' do
      visit '422'

      expect(page).to have_content('422 - Unacceptable\nHey, looks like we doing something wrong.',
                                   'Please check it and try again.')
    end
  end

  describe '#internal_error' do
    it '500 - internal server error' do
      visit '500'

      expect(page).to have_content('500 - Internal Error\nHey, looks like we had a problem at our ',
                                   "server.\nWe'll be trying to solve the problem.")
    end
  end
end
