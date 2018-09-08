class Professor < ApplicationRecord
  validates :name, presence: true
  validates :lattes, presence: true
  validates :occupation_area, presence: true
  validates :email, presence: true
end
