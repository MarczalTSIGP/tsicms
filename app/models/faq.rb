class Faq < ApplicationRecord
  validates :title, presence: true, uniqueness: { case_sensitive: false }
  validates :answer, presence: true
end
