require 'rails_helper'

RSpec.describe 'home page', type: :feature do
  let!(:discipline_monitors) { create_list(:discipline_monitor, 4, year: Time.zone.now.year,
                                            semester: DisciplineMonitor.current_semester) }
  let!(:efetive_professors) { create_list(:professor, 2,
                                          professor_category: create(:professor_category, name: 'Efetivo')) }
  let!(:temporary_professors) { create_list(:professor, 2,
                                            professor_category: create(:professor_category, name: 'Temporário')) }
  let!(:companies) { create_list(:company, 2) }
  let!(:trainees) { create_list(:trainee, 3) }
  let!(:faqs) { create_list(:faq, 3) }

  describe '#show' do
    before(:each) do
      visit root_path
    end

    it 'show all discipline monitors' do

      discipline_monitors.each do |m|
        expect(page).to have_content(m.year)
        expect(page).to have_content(m.description)
        expect(page).to have_content(I18n.t("enums.semesters.#{m.semester}"))

        expect(page).to have_content(m.academic.name)
        expect(page).to have_content(m.monitor_type.name)
        expect(page).to have_content(m.disciplines.first.name)
        expect(page).to have_content(m.professors.first.name)

      end
    end

    it 'show all efetive professors' do

      efetive_professors.each do |professor|
        expect(page).to have_content(professor.name)
        expect(page).to have_content(professor.email)
        expect(page).to have_content(professor.lattes)
        expect(page).to have_content(professor.occupation_area)

        expect(page).to have_content(professor.professor_category.name)
        expect(page).to have_content(professor.professor_title.name)
      end
    end

    it 'show all temporary professors' do
      temporary_professors.each do |professor|
        expect(page).to have_content(professor.name)
        expect(page).to have_content(professor.email)
        expect(page).to have_content(professor.lattes)
        expect(page).to have_content(professor.occupation_area)

        expect(page).to have_content(professor.professor_category.name)
        expect(page).to have_content(professor.professor_title.name)
      end
    end

    it 'show all companies' do
      companies.each do |company|
        expect(page).to have_content(company.name)
        expect(page).to have_content(company.operation)
        expect(page).to have_link(href: company.site)
        expect(page).to have_css("img[src*='#{company.image}']")
      end
    end

    it 'show all trainees' do
      trainees.each do |trainee|
        expect(page).to have_content(trainee.title)
        expect(page).to have_content(trainee.description)


        expect(page).to have_content(trainee.company.name)
        expect(page).to have_content(trainee.trainee_status.name)
        expect(page).to have_link(href: trainee.company.site)
        expect(page).to have_css("img[src*='#{trainee.company.image}']")
      end
    end

    it 'show all faqs' do
      faqs.each do |faq|
        expect(page).to have_content(faq.title)
        expect(page).to have_content(faq.answer)
      end
    end
  end
end
