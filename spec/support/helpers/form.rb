module Helpers
  module Form
    def submit_form(submit = '//input[type=submit]')
      find(submit).click
    end

    def have_contains(field, content)
      within(field) do
        expect(page).to have_content(content)
      end
    end

    def not_have_contains(field, content)
      within(field) do
        expect(page).not_to have_content(content)
      end
    end

    def not_have_equals(field, content)
      within(field) do
        expect(page).not_to eq(content)
      end
    end
  end
end
