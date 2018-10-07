require 'rspec'

def select_start_date
  select '1', from: 'activity_professor[start_date(3i)]'
  select 'Janeiro', from: 'activity_professor[start_date(2i)]'
  select '2018', from: 'activity_professor[start_date(1i)]'
end

RSpec.feature 'Activity Professors', type: :feature do
  let(:admin) {create(:admin)}
  let(:resource_name) {ActivityProfessor.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      @professor = create_list(:professor, 5).sample
      @activity = create_list(:activity, 5).sample
      visit new_admins_activity_professor_path
    end

    context 'with valid fields' do
      it 'add activity to professor with out and date' do
        attributes = attributes_for(:activity_professor)

        select @professor.name, from: 'activity_professor[professor_id]'
        select @activity.name, from: 'activity_professor[activity_id]'

        select_start_date

        submit_form

        expect(page.current_path).to eq admins_professor_path(@professor)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within_have_content('table tbody', attributes[:name])
      end
      it 'add activity to professor with and date' do
        attributes = attributes_for(:activity_professor)

        select @professor.name, from: 'activity_professor[professor_id]'
        select @activity.name, from: 'activity_professor[activity_id]'

        select_start_date

        select '1', from: 'activity_professor[end_date(3i)]'
        select 'Janeiro', from: 'activity_professor[end_date(2i)]'
        select '2019', from: 'activity_professor[end_date(1i)]'
        submit_form

        expect(page.current_path).to eq admins_professor_path(@professor)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within_have_content('table tbody', attributes[:name])
      end
    end
    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within_have_content('div.activity_professor_professor', I18n.t('errors.messages.blank'))
        within_have_content('div.activity_professor_activity', I18n.t('errors.messages.blank'))
        within_have_content('div.activity_professor_start_date', I18n.t('errors.messages.blank'))
      end
    end
  end

  describe '#update' do
    let(:activity_professor) {create(:activity_professor)}

    before(:each) do
      visit edit_admins_activity_professor_path(activity_professor)
    end

    context 'fill fields' do
      it 'with correct values' do
      end
      it 'with incorrect values' do
      end
    end
  end
end
