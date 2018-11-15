require 'rails_helper'

RSpec.feature 'Activities Public Page', type: :feature do

  describe '#show' do
    let!(:activities) {create_list(:activity, 6)}
    it 'all activities' do
      visit activities_path

      activities.each do |activity|
        expect(page).to have_content(activity.name)
        expect(page).to have_link(href: activity_path(activity))
      end
    end
    it 'activity page' do
      activity = activities.first

      visit activity_path(activity)

      expect(page).to have_content(activity.name)
      expect(page).to have_content(activity.description)
    end
  end
end
