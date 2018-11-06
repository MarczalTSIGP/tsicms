class Professor < ApplicationRecord
  enum gender: { male: 'male', female: 'female'}, _prefix: :gender

  belongs_to :professor_title
  belongs_to :professor_category

  has_many :activities, :through => :activity_professors
  has_many :period_professors, dependent: :destroy
  has_many :activities, through: :activity_professors

  has_many :discipline_monitor_professors
  has_many :discipline_monitors, through: :discipline_monitor_professors

  validates :name, presence: true
  validates :lattes, presence: true, format: { with: URI.regexp }
  validates :occupation_area, presence: true
  validates :email, presence: true, format: { with: Devise.email_regexp }
  validates :professor_title, presence: true
  validates :professor_category, presence: true
  validates :gender, inclusion: { in: Professor.genders.values }

  mount_uploader :image, ProfessorImageUploader

  def self.human_genders
    hash = {}
    genders.keys.each { |key| hash[I18n.t("enums.genders.#{key}")] = key }
    hash
  end

end
