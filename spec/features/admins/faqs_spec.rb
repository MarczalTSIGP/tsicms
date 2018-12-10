require 'rails_helper'

RSpec.describe 'Faqs', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Faq.model_name.human }
  let!(:faq) { create(:faq) }

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
        text = I18n.t('flash.actions.create.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)

        expect_page_have_in('#accordion', attributes[:title])
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        fields = %w[div.faq_title div.faq_answer]
        expect_page_blank_messages(fields)
      end
    end
  end

  describe '#update' do
    before(:each) do
      visit edit_admins_faq_path(faq)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect_page_have_value('faq_title', faq.title)
        expect_page_have_value('faq_answer', faq.answer)
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
        text = I18n.t('flash.actions.update.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)
        expect_page_have_in('#accordion', new_title)
      end
    end

    context 'with invalid fields' do
      it 'show errors' do
        fill_in 'faq_title', with: ''
        fill_in 'faq_answer', with: ''
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        fields = %w[div.faq_title div.faq_answer]
        expect_page_blank_messages(fields)
      end
    end
  end

  describe '#destroy' do
    it 'faq' do
      visit admins_faqs_path

      click_on_destroy_link(admins_faq_path(faq))
      text = I18n.t('flash.actions.destroy.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: text)
      expect_page_not_have_in('#accordion', period.name)
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
        expect_page_have_destroy_link(admins_faq_path(f))
      end
    end
  end
end
