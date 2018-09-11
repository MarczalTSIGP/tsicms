require 'rails_helper'

RSpec.describe Admins::ApplicationHelper, type: :helper do
  it 'return image tag' do
    @recommendation = create :recommendation

    expect(helper.image_tag_preview(@recommendation)).to have_xpath('//img')
  end
end
