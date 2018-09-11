require 'rails_helper'

RSpec.feature 'Admin Professors', type: :feature do

  before(:all) do
    @title = create(:professor_title)
    @category = create(:professor_category)
    @professor = create(:professors)
  end

  describe '#edit' do
    context 'with valid fields' do
      it "update professor's fields asd" do
        admin = create(:admin)
        login_as(admin, scope: :admin)
        new_name = 'Lucas Sartori'

        visit edit_admins_professor_path
        fill_in 'professor_name', with: new_name

        find('input[name="commit"]').click

        expect(page).to include("Detalhes do professor: #{new_name}")
      end
    end

    # context 'when invalid fields' do
    #   xit "update professors' name" do
    #     admin = create(:admin)
    #     login_as(admin, scope: :admin)
    #   end
    # end
  end

=begin
  describe '#create' do
    context 'with valid fields' do
      xit "create professor' name" do
        admin = create(:admin)
        login_as(admin, scope: :admin)

        visit new_admins_professor_path

      end
    end
    context 'when invalid fields' do
      xit "create professor' name" do
        admin = create(:admin)
        login_as(admin, scope: :admin)

        visit new_admins_professor_path

      end
    end
  end

  xdescribe '#destroy' do
    context 'must be destroy professor' do
      xit "destroy professor' name" do
        admin = create(:admin)
        login_as(admin, scope: :admin)
      end
    end
  end

  describe '#show' do
    context 'with valid fields' do
      xit 'show professor' do
        admin = create(:admin)
        login_as(admin, scope: :admin)

        visit admins_professor_path

      end
    end

    context 'when invalid fields' do
      xit 'show professor' do
        admin = create(:admin)
        login_as(admin, scope: :admin)

        visit admins_professor_path

      end
    end
  end
=end
end
