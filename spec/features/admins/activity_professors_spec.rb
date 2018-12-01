require 'rails_helper'

RSpec.describe 'Activity Professors', type: :feature do
  let(:admin) {create(:admin)}
  let(:resource_name) {ActivityProfessor.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    let!(:professor) {create_list(:professor, 5).sample}
    let!(:activity) {create_list(:activity, 5).sample}

    before(:each) do
      visit new_admins_activity_professor_path
    end

    context 'with valid fields' do
      it 'add activity to professor with out and date' do
        attributes = attributes_for(:activity_professor)

        select professor.name, from: 'activity_professor[professor_id]'
        select activity.name, from: 'activity_professor[activity_id]'

        select '1', from: 'activity_professor[start_date(3i)]'
        select 'Janeiro', from: 'activity_professor[start_date(2i)]'
        select '2018', from: 'activity_professor[start_date(1i)]'

        submit_form

        expect(page).to have_current_path(admins_activities_path)

        expect(page).to have_flash(:success, text: I18n.t('flash.actions.create.f', resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end

      it 'add activity to professor with and date' do
        attributes = attributes_for(:activity_professor)

        select professor.name, from: 'activity_professor[professor_id]'
        select activity.name, from: 'activity_professor[activity_id]'

        select '1', from: 'activity_professor[start_date(3i)]'
        select 'Janeiro', from: 'activity_professor[start_date(2i)]'
        select '2018', from: 'activity_professor[start_date(1i)]'

        select '1', from: 'activity_professor[end_date(3i)]'
        select 'Janeiro', from: 'activity_professor[end_date(2i)]'
        select '2019', from: 'activity_professor[end_date(1i)]'

        submit_form

        expect(page).to have_current_path(admins_activities_path)

        expect(page).to have_flash(:success, text: I18n.t('flash.actions.create.f', resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form
        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        fields = '%w[div.activity_professor_professor div.activity_professor_activity div.activity_professor_start_date]'
        expect_page_have_blank_messages(fields)
      end
    end
  end

  describe '#update' do
    context 'with success' do
      let(:activity_professor) {create(:activity_professor)}
      let(:update_link) {"a[href='#{edit_admins_activity_professor_path(activity_professor)}']"}
      let(:new_year) {'2020'}

      it 'with correct values in professor path' do
        visit admins_professor_path(activity_professor.professor)

        find(update_link).click

        select new_year, from: 'activity_professor[start_date(1i)]'

        submit_form

        expect(page).to have_current_path(admins_professor_path(activity_professor.professor))

        expect(page).to have_content(new_year.to_s)
      end
      it 'with correct values in activity path' do
        visit admins_activity_path(activity_professor.activity)
        find(update_link).click
        select new_year, from: 'activity_professor[start_date(1i)]'

        submit_form

        expect(page).to have_current_path(admins_activity_path(activity_professor.activity))

        expect(page).to have_content(new_year.to_s)
      end
    end

    context 'with invalid fields' do
      let(:activity_professor) {create(:activity_professor)}

      before(:each) do
        visit edit_admins_activity_professor_path(activity_professor)
      end

      it 'with incorrect values' do
        select '', from: 'activity_professor[start_date(3i)]'
        select '', from: 'activity_professor[start_date(2i)]'
        select '', from: 'activity_professor[start_date(1i)]'
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
      end
    end
  end

  describe '#show' do
    let(:activity_professor) {create(:activity_professor)}

    it 'professor with activities history' do
      visit admins_professor_path(activity_professor.professor)

      expect(page).to have_content(activity_professor.activity.name)
      expect(page).to have_content(I18n.l(activity_professor.start_date, format: :long))
      expect(page).to have_content(activity_professor.end_date_human)
    end
    it 'activity with professors history' do
      visit visit admins_activity_path(activity_professor.activity)

      expect(page).to have_content(activity_professor.professor.name)
      expect(page).to have_content(I18n.l(activity_professor.start_date, format: :long))
      expect(page).to have_content(activity_professor.end_date_human)
    end
  end

  describe '#destroy' do
    let(:activity_professor) {create(:activity_professor)}

    it 'activity from professor' do
      visit admins_professor_path(activity_professor.professor)

      click_on_destroy_link(admins_activity_professor_path(activity_professor))
      expect(page).to have_flash(:success, text: I18n.t('flash.actions.destroy.f', resource_name: resource_name))
      expect_page_not_have_in('table tbody', activity_professor.activity.name)
    end

    it 'professor from activity' do
      visit admins_activity_path(activity_professor.activity)

      click_on_destroy_link(admins_activity_professor_path(activity_professor))
      expect(page).to have_flash(:success, text: I18n.t('flash.actions.destroy.f', resource_name: resource_name))
      expect_page_not_have_in('table tbody', activity_professor.professor.name)
    end
  end
end
