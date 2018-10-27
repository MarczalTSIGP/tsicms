module Helpers
  module Form
    def submit_form(submit = '//input[type=submit]')
      find(submit).click
    end

    def expect_page_have_in(field, content)
      within(field) do
        expect(page).to have_content(content)
      end
    end

    def expect_page_not_have_in(field, content)
      within(field) do
        expect(page).not_to have_content(content)
      end
    end

    def not_have_equals(field, content)
      within(field) do
        expect(page).not_to eq(content)
      end
    end

    def expect_alert_error(message)
      expect(page).to have_selector('div.alert.alert-danger',
                                    text: I18n.t(message))
    end

    def expect_alert_success(resource_name, message)
      expect(page).to have_selector('div.alert.alert-success',
                                    text: I18n.t(message,
                                                 resource_name: resource_name))
    end

    def click_on_destroy_link(url)
      destroy_link = "a[href='#{url}'][data-method='delete']"
      find(destroy_link).click
    end
  end
end
