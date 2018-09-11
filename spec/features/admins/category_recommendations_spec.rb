require 'rails_helper'

RSpec.feature 'Category Recommendations', type: :feature do
  before(:each) do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_category_recommendation_path
    end

    context 'with valid fields' do

      it 'create category recommendation' do
        new_name = 'Documentário'

        fill_in 'category_recommendation[name]', with: new_name

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_category_recommendations_path

        within('#category_recommendations_table') do
          expect(page).to have_content(new_name)
        end
      end

    end

    context 'when invalid fields' do

      it 'create category recommendation' do
        fill_in 'category_recommendation[name]', with: ''

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_category_recommendations_path

        expect(page).to have_selector('div.alert.alert-danger', text: 'Existem dados incorretos!')
      end

    end
  end

  describe '#update' do
    before(:each) do
      @category = create(:category_recommendation)
      visit edit_admins_category_recommendation_path(@category)
    end

    context 'with valid fields' do

      it 'update category recommendation' do
        new_name = 'Documentário de teste'
        fill_in 'category_recommendation[name]', with: new_name

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_category_recommendations_path

        within('#category_recommendations_table') do
          expect(page).to have_content(new_name)
        end
      end

    end

    context 'when invalid fields' do

      it 'update category recommendation' do
        fill_in 'category_recommendation[name]', with: ''

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_category_recommendation_path(@category)

        expect(page).to have_selector('div.alert.alert-danger', text: 'Existem dados incorretos!')
      end

    end
  end

  describe '#destroy' do
    it 'destroy category recommendation' do
      @category = create(:category_recommendation)

      visit admins_category_recommendations_path
      category_path = admins_category_recommendation_path(@category)

      expect { click_link '', href: category_path }.to change(CategoryRecommendation, :count).by(-1)
    end
  end
end
