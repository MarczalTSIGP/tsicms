module Helpers
  module Form
    def submit_form(submit = '//input[type=submit]')
      find(submit).click
    end

    def within_blank_field(field, content)
      within(field) do
        expect(page).to have_content(content)
      end
    end
  end
end
