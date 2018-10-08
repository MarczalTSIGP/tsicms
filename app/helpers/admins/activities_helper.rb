module Admins::ActivitiesHelper
  def current_date(date)
    if date.nil?
      I18n.t('helpers.currently')
    else
      l(date, format: :long)
    end
  end
end
