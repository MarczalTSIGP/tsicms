require 'rails_helper'

RSpec.describe 'Galleries', type: :feature do
  let(:admin) { create(:admin) }

  before(:each) do
    login_as(admin, scope: :admin)
  end

  describe '#index static_page' do

    it 'has the correct content' do
      test_gallery_index(:context_course, 'picture')
      test_gallery_index(:context_document, 'document')
      test_gallery_index(:context_static_page, 'picture')
    end
  end

  def test_gallery_index(context, model)
    gallery = create(:gallery, context)

    visit admins_galleries_path(gallery.context)

    expect(page).to have_css("#gallery-#{gallery.context}")

    gallery.send(model.pluralize).each do |p|
      expect(page).to have_link(href: send("edit_admins_#{model}_path", gallery.context, p))
      destroy_link = "a[href='#{send("admins_#{model}_path", gallery.context, p)}'][data-method='delete']"
      expect(page).to have_css(destroy_link)
    end
  end
end
