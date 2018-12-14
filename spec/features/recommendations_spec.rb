require 'rails_helper'

RSpec.describe 'Recommendation Public Page', type: :feature do
  describe '#index' do
    let!(:recommendations) { create_list(:recommendation, 3) }

    it 'all recommendations' do
      visit recommendations_path

      recommendations.each do |recommendation|
        expect(page).to have_content(recommendation.title)
        expect(page).to have_content(recommendation.description)
        expect(page).to have_content(l(recommendation.created_at, format: :long))

        expect(page).to have_link(href: recommendation_path(recommendation))
      end
    end
  end

  describe '#show' do
    it 'recommendation page' do
      recommendation = create(:recommendation)
      visit recommendation_path(recommendation)

      expect(page).to have_content(recommendation.title)
      expect(page).to have_content(recommendation.description)
      expect(page).to have_content(l(recommendation.created_at, format: :long))

      expect(page).to have_link(href: recommendations_path)
    end
  end
end
