require 'rails_helper'

RSpec.describe 'public discipline monitor', type: :feature do
  describe '#index' do
    let!(:discipline_monitors) { create_list(:discipline_monitor, 2) }

    it 'show all discipline monitors' do
      visit discipline_monitors_path

      discipline_monitors.each do |m|
        expect(page).to have_content(m.year)
        expect(page).to have_content(I18n.t("enums.semesters.#{m.semester}"))
        expect(page).to have_content(m.academic.name)

        expect(page).to have_content(m.disciplines.first.name)
        expect(page).to have_content(m.professors.first.name)

        expect(page).to have_link(href: discipline_monitor_path(m))
      end
    end
  end

  describe '#show' do
    it 'show discipline monitors selected' do
      discipline_monitor = create(:discipline_monitor)

      visit discipline_monitor_path(discipline_monitor)

      expect(page).to have_content(discipline_monitor.year)
      expect(page).to have_content(discipline_monitor.description)
      expect(page).to have_content(discipline_monitor.monitor_type.name)
      expect(page).to have_content(I18n.t("enums.semesters.#{discipline_monitor.semester}"))
      expect(page).to have_content(discipline_monitor.academic.name)
      expect(page).to have_css("img[src*='#{discipline_monitor.academic.image.url}']")

      expect(page).to have_content(discipline_monitor.disciplines.first.name)
      expect(page).to have_content(discipline_monitor.professors.first.name)
      expect(page).to have_css("img[src*='#{discipline_monitor.professors.first.image.url}']")
    end
  end
end
