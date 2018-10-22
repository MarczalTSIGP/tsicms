require 'rails_helper'

RSpec.feature 'Matrix', type: :feature do

  let(:admin) { create(:admin) }
  let(:resource_name) { Matrix.model_name.human }

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

        expect(page.current_path).to eq admins_matrices_path

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

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:matrix) { create(:matrix) }

      it 'show errors' do
        fill_in 'matrix_name', with: matrix.name
        submit_form

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors considering insensitive case' do
        fill_in 'matrix_name', with: matrix.name.downcase
        submit_form

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#update' do
    let(:matrix) { create(:matrix) }

    before(:each) do
      visit edit_admins_matrix_path(matrix)
    end

    context 'fill fields' do
      it 'with correct values' do
        expect(page).to have_field 'matrix_name', with: matrix.name
      end
    end

    context 'with valid fields' do
      it 'update matrix' do
        new_name = 'Matriz22'
        fill_in 'matrix_name', with: new_name

        submit_form

        expect(page.current_path).to eq admins_matrices_path

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
        fill_in 'matrix_name', with: ''
        submit_form

        expect(page).to have_selector('div.alert.alert-danger',
                                      text: I18n.t('flash.actions.errors'))

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.blank'))
        end
      end
    end

    context 'when has same name'  do
      let(:other_matrix) { create(:matrix) }

      it 'show errors' do
        fill_in 'matrix_name', with: other_matrix.name
        submit_form

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end

      it 'show errors cosidering insensitive case' do
        fill_in 'matrix_name', with: other_matrix.name.downcase
        submit_form

        within('div.matrix_name') do
          expect(page).to have_content(I18n.t('errors.messages.taken'))
        end
      end
    end
  end

  describe '#destroy' do
    it 'matrix' do
      matrix = create(:matrix)
      visit admins_matrices_path

      destroy_link = "a[href='#{admins_matrix_path(matrix)}'][data-method='delete']"
      find(destroy_link).click

      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t('flash.actions.destroy.f',
                                                 resource_name: resource_name))

      within('table tbody') do
        expect(page).not_to have_content(matrix.name)
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
        destroy_link = "a[href='#{admins_matrix_path(matrix)}'][data-method='delete']"
        expect(page).to have_css(destroy_link)
      end
    end 
  end

end
