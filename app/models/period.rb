class Period < ApplicationRecord
  validates :name, presence: true,
                   uniqueness: { case_sensitive: false, scope: :matrix_id }

  has_many :disciplines, dependent: :destroy

  belongs_to :matrix

  def self.periods_to_select
    periods = Period.includes(:matrix).order('matrices.name ASC', 'periods.name ASC')
    periods.map { |p| ["#{p.matrix.name} - #{p.name}", p.id] }
  end
end
