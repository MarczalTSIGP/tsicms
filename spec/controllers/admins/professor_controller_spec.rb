require 'rails_helper'

RSpec.describe 'admim professor page', type: :controller do
  it 'should be display home page to professors page' do
    get admins_professors_path
    assert_response :sucsess
  end
end
