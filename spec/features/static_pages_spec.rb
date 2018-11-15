require 'rails_helper'

RSpec.describe 'StaticPages', type: :feature do
  describe '#show' do
    let(:static_page) {create(:static_page)}

    before(:each) do
      visit static_page_path(static_page.permalink)
    end

    it 'has the correct content' do
      expect(page).to have_content(static_page.title)
      expect(page).to have_content(static_page.sub_title)
      expect(page).to have_content(static_page.content)
    end

    it 'tcc page' do
      static_page = create(:static_page, :with_tcc)
      visit tcc_path
      expect(page).to have_content(static_page.title)
      expect(page).to have_content(static_page.sub_title)
      expect(page).to have_content(static_page.content)
    end

    it 'monitor page' do
      static_page = create(:static_page, :with_monitor)
      visit monitors_path
      expect(page).to have_content(static_page.title)
      expect(page).to have_content(static_page.sub_title)
      expect(page).to have_content(static_page.content)
    end
  end
  describe '#History' do

    it 'tcc' do
      static_page = create(:static_page, :with_tcc)
      activity_professor = create(:activity_professor)
      activity_professor.activity.name = I18n.t('helpers.tcc')
      activity_professor.save
      visit static_page_history_path(static_page)
    end
    it 'monitor' do
      static_page = create(:static_page, :with_monitor)
      activity_professor = create(:activity_professor)
      activity_professor.activity.name = I18n.t('helpers.monitor')
      activity_professor.save
      visit static_page_history_path(static_page)
    end
  end
end
