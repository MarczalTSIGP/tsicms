class ProfessorPeriod < ApplicationRecord
  belongs_to :professor
  belongs_to :professor_category

  validates :date_entry, presence: true
  validate :date_period

  def date_out_human
    return I18n.t('helpers.currently') if date_out.nil?

    I18n.l(date_out, format: :long)
  end

  def date_period
    errors.add(:date_entry, I18n.t('errors.messages.date.less_thee')) if
      !date_out.nil? && date_entry >= date_out
  end
end
