require 'rails_helper'

RSpec.describe 'Admin Trainees', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Trainee.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    let!(:company) { create_list(:company, 3).sample }
    let!(:trainee_status) { create_list(:trainee_status, 3).sample }

    before(:each) do
      visit new_admins_trainee_path
    end

    context 'with valid fields' do
      it 'create trainee' do
        attributes = attributes_for(:trainee)
        fill_in 'trainee_title', with: attributes[:title]
        fill_in 'trainee_description', with: attributes[:description]
        select company.name, from: 'trainee[company_id]'
        select trainee_status.name, from: 'trainee[trainee_status_id]'

        submit_form

        expect(page).to have_current_path(admins_trainees_path)

        expect_page_have_in('table tbody', attributes[:title])
      end
    end

    context 'with invalid fields' do
      it 'cannot create trainee' do
        submit_form

        expect(page).to have_current_path(admins_trainees_path)

        expect_alert_error('flash.actions.errors')

        fields = '%w[div.trainee_title div.trainee_description div.trainee_company]'
        expect_page_have_blank_messages(fields)
      end
    end
  end

  describe '#update' do
    let(:trainee) { create :trainee }

    before(:each) do
      visit edit_admins_trainee_path(trainee)
    end

    context 'with valid fields' do
      it 'update trainee' do
        new_title = 'EAEEE'
        fill_in 'trainee_title', with: new_title
        submit_form

        expect(page).to have_current_path(admins_trainee_path(trainee))

        expect(page).to have_content(new_title)
      end
    end

    context 'with invalid fields' do
      it 'cannot update trainee' do
        fill_in 'trainee_title', with: ''
        submit_form
        expect_alert_error('flash.actions.errors')
      end
    end
  end

  describe '#show' do
    let!(:traineess) { create_list(:trainee, 2) }

    it 'all trainees' do
      visit admins_trainees_path

      traineess.each do |trainee|
        expect(page).to have_content(trainee.title)
        expect(page).to have_content(I18n.l(trainee.created_at, format: :long))
      end
    end

    it 'trainee page' do
      trainee = create(:trainee)
      visit admins_trainee_path(trainee)
      expect(page).to have_content(trainee.title)
      expect(page).to have_content(trainee.description)
    end
  end

  describe '#destroy' do
    it 'trainee' do
      trainee = create(:trainee)
      visit admins_trainees_path

      click_on_destroy_link(admins_trainee_path(trainee))

      expect_alert_success(resource_name, 'flash.actions.destroy.f')

      expect_page_not_have_in('table tbody', trainee.title)
    end
  end
end
