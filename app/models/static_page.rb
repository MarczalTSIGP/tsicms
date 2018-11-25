class StaticPage < ApplicationRecord

  validates :title, presence: true
  validates :content, presence: true
  validates :permalink, uniqueness: { case_sensitive: false },
                        format: { with: /\A[\w\.\-]+\z/,
                                  message: I18n.t('errors.messages.permalink') }
  belongs_to :activity
end
