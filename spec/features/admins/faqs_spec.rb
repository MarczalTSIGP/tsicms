require 'rails_helper'

RSpec.describe 'Faqs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Faq.model_name.human }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_faq_path
    end

    context 'with valid fields' do
      it 'faq' do
        attributes = attributes_for(:faq)

        fill_in 'faq_title', with: attributes[:title]
        fill_in 'faq_answer', with: attributes[:answer]
        submit_form

        expect(page).to have_current_path(admins_faqs_path)
        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.create.f',
                                                   resource_name: resource_name))

        within('#accordion') do
          expect(page).to have_content(attributes[:title])
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.faq_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.faq_answer') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#update' do
    let(:faq) { create(:faq) }

    before(:each) do
      visit edit_admins_faq_path(faq)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'faq_title',
                                   with: faq.title
        expect(page).to have_field 'faq_answer',
                                   with: faq.answer
      end
    end

    context 'with valid fields' do
      it 'faq' do
        attributes = attributes_for(:faq)
        new_title = 'Pergunta Nova'

        fill_in 'faq_title', with: new_title
        fill_in 'faq_answer', with: attributes[:answer]
        submit_form

        expect(page).to have_current_path(admins_faqs_path)

        expect(page).to have_selector('div.alert.alert-success',
                                      text: I18n.t('flash.actions.update.f',
                                                   resource_name: resource_name))

        within('#accordion') do
          expect(page).to have_content(new_title)
        end
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'faq_title', with: ''
        fill_in 'faq_answer', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.faq_title') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
        within('div.faq_answer') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'faq' do
      faq = create(:faq)
      visit admins_faqs_path

      destroy_path = "/admins/faqs/#{faq.id}"
      click_link href: destroy_path

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('#accordion') do
        expect(page).not_to have_content(faq.title)
      end
    end
  end

  describe '#index' do
    let!(:faqs) { create_list(:faq, 2) }

    it 'show all faqs with options' do
      visit admins_faqs_path

      faqs.each do |f|
        expect(page).to have_content(f.title)
        expect(page).to have_css("#collapse#{f.id}", text: f.answer)

        expect(page).to have_link(href: edit_admins_faq_path(f))
        destroy_link = "a[href='#{admins_faq_path(f)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end
  end
end
