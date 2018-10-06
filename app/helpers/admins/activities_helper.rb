module Admins::ActivitiesHelper
  def current_date(date)
    if date.nil?
      t('currently')
    else
      l(date, format: :long)
    end
  end
end
