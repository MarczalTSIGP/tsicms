class Contact < ApplicationRecord
    validates :name, presence: true
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 },
                        format: { with: VALID_EMAIL_REGEX }
    validates :phone, presence: true
    validates :message, presence: true

    def mark_as_read
        update(read: true)
    end

    def mark_as_unread
        update(read: false)
    end
end