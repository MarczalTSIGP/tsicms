class Period < ApplicationRecord

    validates :name, presence: true, uniqueness: { case_sensitive: false }

    has_many :disciplines,  dependent: :destroy

    belongs_to :matrix

end