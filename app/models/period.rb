class Period < ApplicationRecord

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    has_many :disciplines

    belongs_to :matrix

end