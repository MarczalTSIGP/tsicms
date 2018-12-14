require 'rails_helper'

RSpec.describe 'public discipline monitor', type: :feature do
  let!(:discipline_monitors) { create_list(:discipline_monitor, 2) }
  describe '#index' do

    it 'show all discipline monitors' do
      visit discipline_monitors_path

      discipline_monitors.each do |m|
        expect(page).to have_content(m.year)
        expect(page).to have_content(I18n.t("enums.semesters.#{m.semester}"))
        expect(page).to have_content(m.academic.name)
        expect(page).to have_content(m.disciplines.first.name)
        expect(page).to have_content(m.professors.first.name)

        expect(page).to have_link(href: root_path)
      end
    end
  end
end
