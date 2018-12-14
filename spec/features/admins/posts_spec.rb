require 'rails_helper'

RSpec.describe 'Admin Posts', type: :feature do
  let(:admin) { create(:admin) }
  let!(:post_category) { create_list(:post_category, 3).sample }
  let(:resource_name) { Post.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_post_path
    end

    context 'with valid fields' do
      it 'create post' do
        attributes = attributes_for(:post)

        fill_in 'post_title', with: attributes[:title]
        fill_in 'post_description', with: attributes[:description]
        select post_category.name, from: 'post_post_category_id'
        submit_form

        expect(page).to have_current_path(admins_posts_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
          expect(page).to have_content(post_category.name)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.post_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.post_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#index' do
    let!(:posts) { create_list(:post, 3) }

    it 'show all posts with options' do
      visit admins_posts_path

      posts.each do |p|
        expect(page).to have_content(p.title)
        expect(page).to have_content(p.post_category.name)
        expect(page).to have_content(I18n.l(p.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_post_path(p))
        destroy_link = "a[href='#{admins_post_path(p)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end

  describe '#update' do
    let(:post) { create(:post) }
    let!(:new_post_category) { create(:post_category) }

    before(:each) do
      visit edit_admins_post_path(post)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'post_title',
                                   with: post.title
        expect(page).to have_field 'post_description',
                                   with: post.description
        expect(page).to have_select 'post_post_category_id',
                                    selected: post.post_category.name
      end
    end

    context 'with valid fields' do
      it 'update post' do
        attributes = attributes_for(:post)

        fill_in 'post_title', with: attributes[:title]
        fill_in 'post_description', with: attributes[:description]
        select new_post_category.name, from: 'post_post_category_id'
        submit_form

        expect(page).to have_current_path(admins_posts_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        within('table tbody') do
          expect(page).to have_content(attributes[:name])
          expect(page).to have_content(new_post_category.name)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'post_title', with: ''
        fill_in 'post_description', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.post_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end

        within('div.post_description') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe 'destroy' do
    it 'post' do
      post = create(:post)
      visit admins_posts_path

      destroy_path = admins_post_path(post)
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(post.title)
      end
    end
  end
end
