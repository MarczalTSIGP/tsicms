require 'rails_helper'

RSpec.describe 'Post Public Page', type: :feature do
  describe '#index' do
    let!(:posts) { create_list(:post, 3, posted: true) }

    it 'all posts' do
      visit posts_path

      posts.each do |post|
        expect(page).to have_content(post.title)
        expect(page).to have_content(post.description)
        expect(page).to have_content(l(post.created_at, format: :long))

        expect(page).to have_link(href: post_path(post))
      end
    end
  end

  describe '#show' do
    it 'post page' do
      post = create(:post)
      visit post_path(post)

      expect(page).to have_content(post.title)
      expect(page).to have_content(post.description)
      expect(page).to have_content(l(post.created_at, format: :long))

      expect(page).to have_link(href: posts_path)
    end
  end
end
