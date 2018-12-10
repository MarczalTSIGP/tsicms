require 'rails_helper'

RSpec.describe 'Matrix', type: :feature do
  let(:admin) { create(:admin) }
  let(:resource_name) { Matrix.model_name.human }
  let!(:matrix) { create(:matrix) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#create' do
    before(:each) do
      visit new_admins_matrix_path
    end

    context 'with valid fields' do
      it 'create matrix' do
        attributes = attributes_for(:matrix)

        fill_in 'matrix_name', with: attributes[:name]
        submit_form

        expect(page).to have_current_path(admins_matrices_path)
        text = I18n.t('flash.actions.create.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)

        expect_page_have_in('table tbody', attributes[:name])
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))

        expect_page_blank_message('div.matrix_name')
      end
    end

    context 'when has same name' do
      it 'show errors' do
        fill_in 'matrix_name', with: matrix.name
        submit_form

        expect_page_have_in('div.matrix_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors considering insensitive case' do
        fill_in 'matrix_name', with: matrix.name.downcase
        submit_form
        expect_page_have_in('div.matrix_name', I18n.t('errors.messages.taken'))
      end
    end
  end

  describe '#update' do
    before(:each) do
      visit edit_admins_matrix_path(matrix)
    end

    context 'with fields filled' do
      it 'with correct values' do
        expect(page).to have_field 'matrix_name', with: matrix.name
      end
    end

    context 'with valid fields' do
      it 'update matrix' do
        new_name = 'Matriz22'
        fill_in 'matrix_name', with: new_name

        submit_form

        expect(page).to have_current_path(admins_matrices_path)
        text = I18n.t('flash.actions.update.f', resource_name: resource_name)
        expect(page).to have_flash(:success, text: text)

        expect_page_have_in('table tbody', new_name)
      end
    end

    context 'when invalid fields' do
      it 'show errors' do
        fill_in 'matrix_name', with: ''
        submit_form

        expect(page).to have_flash(:danger, text: I18n.t('flash.actions.errors'))
        expect_page_blank_message('div.matrix_name')
      end
    end

    context 'when has same name' do
      it 'show errors' do
        fill_in 'matrix_name', with: matrix.name
        submit_form

        expect_page_have_in('div.matrix_name', I18n.t('errors.messages.taken'))
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'matrix_name', with: matrix.name.downcase
        submit_form

        expect_page_have_in('div.matrix_name', I18n.t('errors.messages.taken'))
      end
    end
  end

  describe '#index' do
    let!(:matrices) { create_list(:matrix, 3) }

    it 'show all matrix with options' do
      visit admins_matrices_path

      matrices.each do |matrix|
        expect(page).to have_content(matrix.name)
        expect(page).to have_content(I18n.l(matrix.created_at, format: :long))

        expect(page).to have_link(href: edit_admins_matrix_path(matrix))
        expect_page_have_destroy_link(admins_matrix_path(matrix))
      end
    end
  end

  describe '#destroy' do
    it 'matrix' do
      visit admins_matrices_path

      click_on_destroy_link(admins_matrix_path(matrix))

      text = I18n.t('flash.actions.destroy.f', resource_name: resource_name)
      expect(page).to have_flash(:success, text: text)
      expect_page_not_have_in('table tbody', matrix.name)
    end
  end
end
