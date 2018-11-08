class PeriodProfessor < ApplicationRecord
  belongs_to :professor
  belongs_to :professor_category

  validates :date_entry, presence: true
  
  def date_out_human
    return I18n.t('helpers.currently') if self.date_out.nil?
    I18n.l(date_out, format: :long)
  end

end
