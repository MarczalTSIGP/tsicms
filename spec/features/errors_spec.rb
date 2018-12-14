require 'rails_helper'

RSpec.describe 'Errors Public Page', type: :feature do
  describe '#not_found' do
    it '404 - resource not found' do
      visit url: '404'

      expect(page).to have_content(text: '404 - Not Found')
      expect(page).to have_content(text: 'Ops!! Seems we could`t find the page you`re looking for.')
    end
  end

  describe '#unacceptable' do
    it '422 - params unacceptable' do
      visit url: '422'

      expect(page).to have_content(text: '422 - Unacceptable')
      expect(page).to have_content(text: 'Hey, looks like we doing something wrong.
                                         Please check it and try again.')
    end
  end

  describe '#internal_error' do
    it '500 - internal server error' do
      visit url: '500'

      expect(page).to have_content(text: '500 - Internal Error')
      expect(page).to have_content(text: 'Hey, looks like we had a problem at our server.')
      expect(page).to have_content(text: 'We`ll be trying to solve the problem faster as we can.')
    end
  end
end
