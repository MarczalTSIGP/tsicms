require 'rails_helper'

RSpec.describe 'Post Categories', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { PostCategory.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_post_category_path
    end

    context 'with valid fields' do
      it 'create post category' do
        attributes = attributes_for(:post_category)

        fill_in 'post_category_name', with: attributes[:name]
        submit_form

        expect(page).to have_current_path(admins_post_categories_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name' do
      let(:category) { create(:post_category) }

      it 'show errors' do
        fill_in 'post_category_name', with: category.name
        submit_form

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors considering insensitive case' do
        fill_in 'post_category_name', with: category.name.downcase
        submit_form

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#update' do
    let(:category) { create(:post_category) }

    before(:each) do
      visit edit_admins_post_category_path(category)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'post_category_name', with: category.name
      end
    end

    context 'with valid field' do
      it 'update post category' do
        new_name = 'Nova Notícia'
        fill_in 'post_category_name', with: new_name
        submit_form

        expect(page).to have_current_path(admins_post_categories_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(new_name)
        end
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'post_category_name', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name' do
      let(:another_category) { create(:post_category) }

      it 'show errors' do
        fill_in 'post_category_name', with: another_category.name
        submit_form

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors considering insensitive case' do
        fill_in 'post_category_name', with: another_category.name.downcase
        submit_form

        within('div.post_category_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#index' do
    let!(:categories) { create_list(:post_category, 3) }

    it 'show all post categories' do
      visit admins_post_categories_path

      categories.each do |category|
        expect(page).to have_content(category.name)
        expect(page).to have_content(I18n.l(category.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_post_category_path(category))

        destroy_path = admins_post_category_path(category)
        destroy_link = "a[href='#{destroy_path}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#destroy' do
    it 'post category' do
      category = create(:post_category)
      visit admins_post_categories_path

      destroy_path = admins_post_category_path(category)
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(category.name)
      end
    end
  end
end
