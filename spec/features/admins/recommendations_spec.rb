require 'rails_helper'

RSpec.feature 'Recommendations', type: :feature do
  before(:each) do
    admin = create(:admin)
    login_as(admin, scope: :admin)
  end

  describe '#create' do

    before(:each) do
      @category = create_list(:category_recommendation, 3).sample
      visit new_admins_recommendation_path
    end

    context 'with valid fields' do

      it 'create recommendation' do
        image = Rails.root.join('app', 'assets', 'images', 'logo-tsi-text.png')
        recommendation_title = 'Nova recomendação'

        fill_in 'recommendation[title]', with: recommendation_title
        fill_in 'recommendation[description]', with: 'Descrição'
        attach_file('recommendation[image]', image)
        select @category.name, from: 'recommendation[category_recommendation_id]'

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_recommendations_path

        within('#recommendations_table') do
          expect(page).to have_content(recommendation_title)
        end
      end

    end

    context 'when invalid fields' do

      it 'create recommendation' do
        image = Rails.root.join('app', 'assets', 'images', 'logo-tsi-text.png')

        fill_in 'recommendation[title]', with: ''
        fill_in 'recommendation[description]', with: 'Descrição'
        attach_file('recommendation[image]', image)
        select @category.name, from: 'recommendation[category_recommendation_id]'

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_recommendations_path

        expect(page).to have_selector('div.alert.alert-danger', text: 'Existem dados incorretos!')
      end

    end
  end

  describe '#update' do
    before(:each) do
      @category = create_list(:category_recommendation, 3).sample
      @recommendation = create(:recommendation)
      visit edit_admins_recommendation_path(@recommendation)
    end

    context 'with valid fields' do

      it 'update recommendation' do
        image = Rails.root.join('app', 'assets', 'images', 'logo-tsi-transparente.png')
        recommendation_title = 'Recomendação editada'

        fill_in 'recommendation[title]', with: recommendation_title
        fill_in 'recommendation[description]', with: 'Descrição editada'
        attach_file('recommendation[image]', image)
        select @category.name, from: 'recommendation[category_recommendation_id]'

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_recommendations_path

        within('#recommendations_table') do
          expect(page).to have_content(recommendation_title)
        end
      end

    end

    context 'when invalid fields' do

      it 'update recommendation' do
        image = Rails.root.join('app', 'assets', 'images', 'logo-tsi-text.png')

        fill_in 'recommendation[title]', with: ''
        fill_in 'recommendation[description]', with: 'Descrição editada'
        attach_file('recommendation[image]', image)
        select @category.name, from: 'recommendation[category_recommendation_id]'

        find('input[name="commit"]').click

        expect(page.current_path).to eq admins_recommendation_path(@recommendation)

        expect(page).to have_selector('div.alert.alert-danger', text: 'Existem dados incorretos!')
      end

    end

  end

  describe '#destroy' do
    it 'destroy recommendation' do
      @recommendation = create(:recommendation)

      visit admins_recommendations_path
      recommendation_path = admins_recommendation_path(@recommendation)

      expect { click_link '', href: recommendation_path }.to change(Recommendation, :count).by(-1)
    end
  end
end
