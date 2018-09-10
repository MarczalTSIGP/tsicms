require 'rails_helper'

RSpec.describe 'admin professors page', type: :controller do
  it 'should be display home page to professors page' do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    visit admins_professors_path
    assert_response :sucsess
  end

  it 'should be show professors by id' do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    professor = Professor.first
    visit admins_professor_show_path(professor)
    assert_response :sucsess
  end
end
