class StaticPage < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\.\-]+\z/,
                                  message: I18n.t('errors.messages.permalink') }
  # has_one :activity
  belongs_to :activity, optional: true
end
