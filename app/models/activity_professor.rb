class ActivityProfessor < ApplicationRecord
  validates :start_date, presence: true
  validates :professor, presence: true
  validates :activity, presence: true

  belongs_to :professor
  belongs_to :activity

  def end_date_human
    return I18n.t('helpers.currently') if end_date.nil?

    I18n.l(end_date, format: :long)
  end
end
