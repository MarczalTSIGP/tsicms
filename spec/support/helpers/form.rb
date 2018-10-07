module Helpers
  module Form
    def submit_form(submit = '//input[type=submit]')
      find(submit).click
    end

    def within_have_content(field, content)
      within(field) do
        expect(page).to have_content(content)
      end
    end
    def within_not_have_content(field, content)
      within(field) do
        expect(page).not_to have_content(content)
      end
    end
  end
end
