require 'rails_helper'

RSpec.describe 'admin professors page', type: :controller do

  before(:all) do
    create(:professor_title)
    create(:professor_category)
    create(:professors)
  end

  it 'should be display home page to professors page' do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    visit admins_professors_path
    assert_response :succusses
  end

  it 'should be show professors by id' do
    admin = create(:admin)
    login_as(admin, scope: :admin)
    professor = Professor.first
    visit admins_professor_show_path(professor)
    assert_response :succusses
  end
end
