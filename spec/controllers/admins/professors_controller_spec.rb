require 'rails_helper'

RSpec.describe 'admim professors page', type: :controller do
  it 'should be display home page to professors page' do
    get admins_professors_path
    assert_response :sucsess
  end

  it 'should be show professors by id' do
    professor = Professor.first
    get admins_professor_show_path(professor)
    assert_response :sucsess
  end
end
