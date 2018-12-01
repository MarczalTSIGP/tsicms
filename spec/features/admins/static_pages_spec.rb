require 'rails_helper'

RSpec.describe 'Admins::StaticPages', type: :feature do
  let(:admin) {create(:admin)}
  let(:resource_name) {StaticPage.model_name.human}

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_static_page_path
    end

    context 'with valid fields' do
      it 'create static_page' do
        attributes = attributes_for(:static_page)

        fill_in 'static_page_title', with: attributes[:title]
        fill_in 'static_page_sub_title', with: attributes[:sub_title]
        fill_in 'static_page_permalink', with: attributes[:permalink]
        fill_in 'static_page_content', with: attributes[:content]
        submit_form

        expect(page).to have_current_path(admins_static_pages_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))
        expect_page_have_in('table tbody', attributes[:title])
        expect_page_have_in('table tbody', attributes[:sub_title])
        within('table tbody') do
          expect(page).to have_link(href: static_page_path(attributes[:permalink]))
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'static_page_permalink', with: 'awesome#page'
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        expect_page_have_in('div.static_page_permalink', I18n.t('errors.messages.permalink'))
        fields = '%w[div.static_page_title div.static_page_content]'
        expect_page_have_blank_messages(fields)
      end
    end
  end

  describe '#update' do
    let(:static_page) {create(:static_page)}

    before(:each) do
      visit edit_admins_static_page_path(static_page)
    end

    context 'with filled fields' do
      it 'with correct values' do
        expect(page).to have_field 'static_page_title',
                                   with: static_page.title
        expect(page).to have_field 'static_page_sub_title',
                                   with: static_page.sub_title
        expect(page).to have_field 'static_page_permalink',
                                   with: static_page.permalink
        expect(page).to have_field 'static_page_content',
                                   with: static_page.content
      end
    end

    context 'with valid fields' do
      it 'update static_page' do
        attributes = attributes_for(:static_page)

        fill_in 'static_page_title', with: attributes[:title]
        fill_in 'static_page_sub_title', with: attributes[:sub_title]
        fill_in 'static_page_permalink', with: attributes[:permalink]
        fill_in 'static_page_content', with: attributes[:content]
        submit_form

        expect(page).to have_current_path(admins_static_pages_path)
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        expect_page_have_in('table tbody', attributes[:title])
        expect_page_have_in('table tbody', attributes[:sub_title])
        within('table tbody') do
          expect(page).to have_link(href: static_page_path(attributes[:permalink]))
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        new_permalink = 'awesome@page'

        fill_in 'static_page_title', with: ''
        fill_in 'static_page_permalink', with: new_permalink
        fill_in 'static_page_content', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))
        fields = '%w[div.static_page_title div.static_page_content]'
        expect_page_have_blank_messages(fields)
        expect_page_have_in('div.static_page_permalink', I18n.t('errors.messages.permalink'))
      end
    end
  end

  describe '#destroy' do
    it 'static_page' do
      static_page = create(:static_page)
      visit admins_static_pages_path

      destroy_path = "/admins/static_pages/#{static_page.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))
      expect_page_have_in('table tbody', static_page.title)
      within('table tbody') do
        expect(page).not_to have_link(href: static_page_path(static_page.permalink))
      end
    end
  end

  describe '#index' do
    let!(:static_pages) {create_list(:static_page, 3)}

    it 'show all static_pages with options' do
      visit admins_static_pages_path

      static_pages.each do |s|
        expect(page).to have_content(s.title)
        expect(page).to have_content(s.sub_title)
        expect(page).to have_content(I18n.l(s.created_at, format: :long))

        expect(page).to have_link(href: static_page_path(s.permalink))
        expect(page).to have_link(href: edit_admins_static_page_path(s))
        destroy_link = "a[href='#{admins_static_page_path(s)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
