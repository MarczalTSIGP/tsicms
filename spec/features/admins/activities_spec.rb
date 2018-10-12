require 'rails_helper'

RSpec.feature 'Activities', type: :feature do

  let(:admin) {create(:admin)}
  let(:resource_name) {Activity.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do

    before(:each) do
      visit new_admins_activity_path
    end

    context 'with valid fields' do
      it 'create activity' do
        attributes = attributes_for(:activity)

        fill_in 'activity_name', with: attributes[:name]
        fill_in 'activity_description', with: attributes[:description]

        submit_form

        expect(page.current_path).to eq admins_activities_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))
        expect_page_have_in('table tbody', attributes[:name])
      end
    end
    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        expect_page_have_in('div.activity_name', I18n.t('errors.messages.blank'))
        expect_page_have_in('div.activity_description', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    let(:activity) {create(:activity)}
    before(:each) do
      visit edit_admins_activity_path(activity)
    end
    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'activity_name',
          with: activity.name
        expect(page).to have_field 'activity_description',
          with: activity.description
      end
    end
    context 'with valid fields' do
      it 'update activity' do
        attributes = attributes_for(:activity)
        new_name = 'Estagio'
        fill_in 'activity_name', with: new_name
        fill_in 'activity_description', with: attributes[:description]

        submit_form

        expect(page.current_path).to eq admins_activities_path
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))
        expect_page_have_in('table tbody', new_name)
      end
    end
  end

  describe '#destroy' do
    it 'activity' do
      activity = create(:activity)
      visit admins_activities_path
      destroy_link = "a[href='#{admins_activity_path(activity)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      expect_page_not_have_in('table tbody', activity.name)
    end

    it 'activity unless has dependet' do
      ap = create(:activity_professor)
      visit admins_activities_path
      destroy_link = "a[href='#{admins_activity_path(ap.activity)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-warning',
                                    text: 'Não é possível remover atividades que possuem professores vinculados!')

      expect(page).to have_content('table tbody', ap.activity.name)
    end
  end

  describe '#index' do
    let!(:activities) {create_list(:activity, 6)}

    it 'show all activities with options' do
      visit admins_activities_path

      activities.each do |a|
        expect(page).to have_content(a.name)

        expect(page).to have_link(href: edit_admins_activity_path(a))
        destroy_link = "a[href='#{admins_activity_path(a)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
  describe '#show' do
    context 'show activity' do
      it 'show activity page' do
        activity = create(:activity)
        visit admins_activity_path(activity)

        expect(page).to have_content(activity.name)
        expect(page).to have_content(activity.description)
      end
    end
  end
end
