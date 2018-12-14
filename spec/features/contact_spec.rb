require 'rails_helper'

RSpec.describe 'Contacts', type: :feature do
  it 'when send a message when all fields are filled correctly', js: true do
    visit root_path

    fill_in 'contact_name', with: 'Diego Marczal'
    fill_in 'contact_email', with: 'marczal@utfpr.edu.br'
    fill_in 'contact_phone', with: '(00) 00000-0000'
    fill_in 'contact_message', with: 'When the ruby on rails course start?'

    expect do
      click_on 'Enviar'
    end.to change(Contact, :count).by(1)

    expect(page).to have_current_path(root_path)
    expect(page).to have_selector('div.alert.alert-success',
                                  text: 'Mensagem enviada com sucesso!')
  end

  it 'when not send a message when exists fields filled incorrectly', js: true do
    visit root_path

    fill_in 'contact_name', with: ' '
    fill_in 'contact_email', with: 'marczal_utfpr.edu.br'
    fill_in 'contact_phone', with: ' '
    fill_in 'contact_message', with: ' '

    expect do
      click_on 'Enviar'
    end.to change(Contact, :count).by(0)

    expect_alert_error('flash.actions.errors')

    within('div.contact_name') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    within('div.contact_email') do
      expect(page).to have_content(I18n.t('errors.messages.invalid'))
    end

    within('div.contact_phone') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end

    within('div.contact_message') do
      expect(page).to have_content(I18n.t('errors.messages.blank'))
    end
  end
end
