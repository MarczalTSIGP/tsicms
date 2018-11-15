require 'rails_helper'

RSpec.feature 'Professors Public Page', type: :feature do

  describe '#show' do
    let!(:professors) {create_list(:professor, 6)}
    it 'all professors' do
      visit professors_path

      professors.each do |professor|
        expect(page).to have_content(professor.name)
        expect(page).to have_content(I18n.l(professor.created_at, format: :long))
        expect(page).to have_link(href: professor_path(professor))
      end
    end
    it 'professor page' do
      professor = create(:professor)
      visit professor_path(professor)

      expect(page).to have_content(professor.name)
      expect(page).to have_content(professor.gender)
      expect(page).to have_content(professor.email)
      expect(page).to have_content(professor.lattes)
      expect(page).to have_content(professor.occupation_area)
      expect(page).to have_content(professor.professor_category.name)
      expect(page).to have_content(professor.professor_title.name)
    end
  end
end
