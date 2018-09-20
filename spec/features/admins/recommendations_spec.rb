require 'rails_helper'

RSpec.feature 'Recommendations', type: :feature do

  let(:admin) { create(:admin) }
  let!(:category) { create_list(:category_recommendation, 3).sample }
  let(:resource_name) { Recommendation.model_name.human }

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

        expect(page.current_path).to eq admins_recommendations_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
          expect(page).to have_content(category.name)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        attach_file 'recommendation_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.recommendation_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.recommendation_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.recommendation_image') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: '"pdf"',
                                              allowed_types: 'jpg, jpeg, gif, png'))
        end
      end
    end
  end

  describe '#update' do
    let(:recommendation) { create(:recommendation) }
    let!(:new_category) { create(:category_recommendation) }

    before(:each) do
      visit edit_admins_recommendation_path(recommendation)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'recommendation_title',
          with: recommendation.title
        expect(page).to have_field 'recommendation_description',
          with: recommendation.description
        expect(page).to have_select 'recommendation_category_recommendation_id',
          selected: recommendation.category_recommendation.name
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

        expect(page.current_path).to eq admins_recommendations_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
          expect(page).to have_content(new_category.name)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'recommendation_title', with: ''
        fill_in 'recommendation_description', with: ''
        attach_file 'recommendation_image', FileSpecHelper.pdf.path
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.recommendation_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.recommendation_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.recommendation_image') do
          expect(page).to have_content(I18n.t('errors.messages.extension_whitelist_error',
                                              extension: '"pdf"',
                                              allowed_types: 'jpg, jpeg, gif, png'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'recommendation' do
      recommendation = create(:recommendation)
      visit admins_recommendations_path

      destroy_path = "/admins/recommendations/#{recommendation.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(recommendation.title)
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
        destroy_link = "a[href='#{admins_recommendation_path(r)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end 
  end

end
