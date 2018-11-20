require 'rails_helper'

RSpec.feature 'Trainees Public Page', type: :feature do

  describe '#trainee page' do
    let!(:trainees) { create_list(:trainee, 6) }
    let!(:ap) { create(:activity_professor, :with_trainee_current) }
    let!(:static_page) { create(:static_page, :with_trainee) }

    it 'all vacancies' do
      visit trainees_path
      trainees.each do |trainee|
        expect(page).to have_content(trainee.title)
        expect(page).to have_link(href: trainee_path(trainee))
      end
    end

    it 'show with trainee' do
      trainee = trainees.sample
      visit trainee_path(trainee)
      expect(page).to have_content(trainee.title)
      expect(page).to have_content(trainee.description)
    end

    it 'history' do
      visit static_page_history_path(static_page)
      expect(page).to have_content(static_page.title)
    end
  end
end
