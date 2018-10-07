require 'rspec'

RSpec.feature 'Activity Professors', type: :feature do

  let(:admin) {create(:admin)}
  let(:resource_name) {ActivityProfessor.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do

    before(:each) do
      visit new_admins_activity_professors_path
    end

    context 'with valid fields' do
      it 'add activity to professor' do
        attributes = attributes_for(:activity_professor)

        fill_in 'activity_professor_professor_id', with: attributes[:professor]
        fill_in 'activity_professor_activity_id', with: attributes[:activity]

        submit_form

        expect(page.current_path).to eq admins_activities_path

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])

        end
      end
    end
    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.activity_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.activity_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
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

        within('table tbody') do
          expect(page).to have_content(new_name)

        end
      end
    end
  end

  describe '#destroy' do
    it 'activity' do
      activity = create(:activity)
      visit admins_activities_path

      destroy_path = "/admins/activities/#{activity.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(activity.name)
      end
    end
  end

  describe '#index' do
    let!(:activities) {create_list(:activity, 6)}

    it 'show all activities with options' do
      visit admins_activities_path

      activities.each do |a|
        expect(page).to have_content(a.name)
        expect(page).to have_content(a.description)
        expect(page).to have_content(I18n.l(a.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_activity_path(a))
        destroy_link = "a[href='#{admins_activity_path(a)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
