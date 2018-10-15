class StaticPage < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, presence: true,
                        uniqueness: { case_sensitive: false },
                        format: { with: /\A[a-zA-Z]+\z/, message: 'Only allows letters, numbers and dashes' }

  # before_create :create_slug
  #
  # def create_slug
  #   self.permalink = self.permalink.parameterize
  # end
end
