require 'rails_helper'

RSpec.feature 'Trainees', type: :feature do

  let(:admin) {create(:admin)}
  let(:resource_name) {Trainee.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:all) do
      @company = create_list(:company, 3).sample
      @status = create_list(:trainee_status, 3).sample
    end
    before(:each) do
      visit new_admins_trainees_path
    end
    context 'with valid fields' do
      it 'create trainee' do
        attributes = attributes_for(:trainee)
        fill_in 'trainee_title', with: attributes[:title]
        fill_in 'trainee_description', with: attributes[:description]
        select @company.title, from: 'trainee[company_id]'
        select @status.description, from: 'trainee[trainee_status_id]'

        submit_form

        expect(page.current_path).to eq admins_trainees_path

        expect_page_have_in('table tbody', attributes[:title])
      end
    end
    context 'with invalid fields' do

      submit_form

      expect(page.current_path).to eq admins_activities_path

      expect_alert_success(resource_name, 'flash.actions.create.f')

      have_contains('div.treinee_title', I18n.t('errors.messages.blank'))
      have_contains('div.treinee_description', I18n.t('errors.messages.blank'))
      have_contains('div.treinee_company', I18n.t('errors.messages.blank'))
      expect_page_have_in('table tbody', attributes[:name])
    end
  end

  describe '#update' do
    before(:all) do
      @treinee = create(:treinee)
      @update_link = "a[href='#{edit_admins_treinee_path(@treinee)}']"
      visit admins_treinee_path(@treinee)
      find(@update_link).click
    end
    context 'with valid fields' do
      new_title = 'EAEEE'
      @treinee.title = new_title
      submit_form

      expect(page.current_path).to eq admins_treinee_path(@treinee)

      expect(page).to have_content(new_title)
    end
    context 'with invalid fields' do
      @treinee.title = ''
      submit_form
      expect_alert_error('flash.actions.errors')
    end
  end

  describe '#show' do
    let(:treinee) {create(:treinee)}

    it 'all treinees' do
      visit admins_treinees_path

      expect(page).to have_content(treinee.title)
      expect(page).to have_content(I18n.l(treinee.created_at, format: :long))
    end

    it 'treinee page' do
      visit admins_treinee_path(treinee)
      expect(page).to have_content(treinee.title)
      expect(page).to have_content(treinee.description)
    end
  end

  describe '#destroy' do
    before(:each) do
      @treinee = create(:treinee)
      visit admins_treinee_path(@treinee)
    end
    it 'treinee' do
      click_on_destroy_link(admins_treinee_path(@treinee))

      expect_alert_success(resource_name, 'flash.actions.destroy.m')

      expect_page_not_have_in('table tbody', @treinee.title)

    end
  end
end
