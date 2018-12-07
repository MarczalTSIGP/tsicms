require 'rails_helper'

RSpec.describe 'StaticPages', type: :feature do
  describe '#show' do
    let(:static_page) { create(:static_page) }

    before(:each) do
      visit static_page_path(static_page.permalink)
    end

    it 'has the correct content' do
      expect(page).to have_content(static_page.title)
      expect(page).to have_content(static_page.sub_title)
      expect(page).to have_content(static_page.content)
    end

    context 'with activity' do
      let!(:static_page) { create(:static_page, :with_activity) }

      it 'page' do
        visit static_page_path(static_page)
        expect(page).to have_content(static_page.title)
        expect(page).to have_content(static_page.sub_title)
        expect(page).to have_content(static_page.content)
      end
      it 'history ' do
        visit static_page_history_path(static_page)
      end
    end
  end
end
