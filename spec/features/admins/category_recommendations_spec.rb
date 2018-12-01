require 'rails_helper'

RSpec.describe 'Category Recommendations', type: :feature do
  let(:admin) {create(:admin)}
  let(:resource_name) {CategoryRecommendation.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_category_recommendation_path
    end

    context 'with valid fields' do
      it 'create category recommendation' do
        attributes = attributes_for(:category_recommendation)

        fill_in 'category_recommendation_name', with: attributes[:name]
        submit_form

        expect(page).to have_current_path(admins_category_recommendations_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        expect_page_have_blank_message('div.category_recommendation_name')
      end
    end

    context 'when has same name' do
      let(:category) {create(:category_recommendation)}

      it 'show errors' do
        fill_in 'category_recommendation_name', with: category.name
        submit_form
        expect_page_have_in('div.category_recommendation_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors considering insensitive case' do
        fill_in 'category_recommendation_name', with: category.name.downcase
        submit_form
        expect_page_have_in('div.category_recommendation_name', I18n.t('errors.messages.taken'))
      end
    end
  end

  describe '#update' do
    let(:category) {create(:category_recommendation)}

    before(:each) do
      visit edit_admins_category_recommendation_path(category)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'category_recommendation_name', with: category.name
      end
    end

    context 'with valid fields' do
      it 'update category recommendation' do
        new_name = 'Documentário novo'
        fill_in 'category_recommendation_name', with: new_name

        submit_form

        expect(page).to have_current_path(admins_category_recommendations_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))
        expect_page_have_in('table tbody', new_name)
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'category_recommendation_name', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        expect_page_have_blank_message('div.category_recommendation_name')
      end
    end

    context 'when has same name' do
      let(:other_category) {create(:category_recommendation)}

      it 'show errors' do
        fill_in 'category_recommendation_name', with: other_category.name
        submit_form
        expect_page_have_in('div.category_recommendation_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'category_recommendation_name', with: other_category.name.downcase
        submit_form
        expect_page_have_in('div.category_recommendation_name', I18n.t('errors.messages.taken'))
      end
    end

    describe '#destroy' do
      it 'category recommendation' do
        category = create(:category_recommendation)
        visit admins_category_recommendations_path

        click_on_destroy_link(admins_category_recommendation_path(category))

        expect_alert_success(resource_name, 'flash.actions.destroy.f')

        expect_page_not_have_in('table tbody', category.name)
      end
    end

    describe '#index' do
      let!(:categories) {create_list(:category_recommendation, 3)}

      it 'show all category recommendations with options' do
        visit admins_category_recommendations_path

        categories.each do |category|
          expect(page).to have_content(category.name)
          expect(page).to have_content(I18n.l(category.created_at, format: :long))

          expect(page).to have_link(href: edit_admins_category_recommendation_path(category))

          expect_page_have_destroy_link(admins_category_recommendation_path(category))
        end
      end
    end
  end
end
