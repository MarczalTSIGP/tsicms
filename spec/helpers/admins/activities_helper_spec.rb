require 'rails_helper'

RSpec.describe Admins::ActivitiesHelper, type: :helper do
  describe 'End date' do
    it 'with date' do
      date = current_date(Date.today)
      expect(date).to have_content(l(Date.today, format: :long))
    end
    it 'with out date' do
      date = current_date(nil)
      expect(date).to have_content(I18n.t('helpers.currently'))
    end
  end
end
