require 'rails_helper'

RSpec.describe 'Recommendations', type: :feature do
  let(:admin) { create(:admin) }
  let!(:category) { create_list(:category_recommendation, 3).sample }
  let(:resource_name) { Recommendation.model_name.human }
  let!(:recommendation) { create(:recommendation) }
  let!(:new_category) { create(:category_recommendation) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_recommendation_path
    end

    context 'with valid fields' do
      it 'create recommendation' do
        attributes = attributes_for(:recommendation)

        fill_in 'recommendation_title', with: attributes[:title]
        fill_in 'recommendation_description', with: attributes[:description]
        attach_file 'recommendation_image', FileSpecHelper.image.path
        select category.name, from: 'recommendation_category_recommendation_id'
        submit_form

        expect(page).to have_current_path(admins_recommendations_path)

        i18msg = 'flash.actions.create.f'
        expect(page).to have_flash(:success, text: I18n.t(i18msg, resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
        expect_page_have_in('table tbody', category.name)
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        attach_file 'recommendation_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        fields = %w[div.recommendation_title div.recommendation_description]
        expect_page_blank_messages(fields)
        text = I18n.t('errors.messages.extension_whitelist_error',
                      extension: '"pdf"',
                      allowed_types: 'jpg, jpeg, gif, png')
        expect_page_have_in('div.recommendation_image', text)
      end
    end
  end

  describe '#update' do
    before(:each) do
      visit edit_admins_recommendation_path(recommendation)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect_page_have_value('recommendation_title', recommendation.title)
        expect_page_have_value('recommendation_description', recommendation.description)
        expect_page_have_selected('recommendation_category_recommendation_id', recommendation.category_recommendation.name)
        expect(page).to have_css("img[src*='#{recommendation.image}']")
      end
    end

    context 'with valid fields' do
      it 'update recommendation' do
        attributes = attributes_for(:recommendation)

        fill_in 'recommendation_title', with: attributes[:title]
        fill_in 'recommendation_description', with: attributes[:description]
        attach_file 'recommendation_image', FileSpecHelper.image.path
        select new_category.name, from: 'recommendation_category_recommendation_id'
        submit_form

        expect(page).to have_current_path(admins_recommendations_path)

        text = I18n.t('flash.actions.update.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)

        expect_page_have_in('table tbody', attributes[:name])
        expect_page_have_in('table tbody', new_category.name)
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'recommendation_title', with: ''
        fill_in 'recommendation_description', with: ''
        attach_file 'recommendation_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

        fields = %w[div.recommendation_title div.recommendation_description]
      
        expect_page_blank_messages(fields)
        i18msg = 'errors.messages.extension_whitelist_error'
        text = I18n.t(i18msg, extension: '"pdf"', allowed_types: 'jpg, jpeg, gif, png')
        expect_page_have_in('div.recommendation_image', text)
      end
    end
  end

  describe '#index' do
    let!(:recommendations) { create_list(:recommendation, 3) }

    it 'show all recommendations with options' do
      visit admins_recommendations_path

      recommendations.each do |r|
        expect(page).to have_content(r.title)
        expect(page).to have_content(r.category_recommendation.name)
        expect(page).to have_content(I18n.l(r.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_recommendation_path(r))
        expect_page_have_destroy_link(admins_recommendation_path(r))
      end
    end
  end

  describe '#destroy' do
    it 'recommendation' do
      visit admins_recommendations_path

      click_on_destroy_link(admins_recommendation_path(recommendation))
      text = I18n.t('flash.actions.destroy.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: text)
      expect_page_not_have_in('table tbody', recommendation.title)
    end
  end
end
