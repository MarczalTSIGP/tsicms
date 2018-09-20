class Academic < ApplicationRecord
    validates :name, presence: true, uniqueness: { case_sensitive: false }
    validates :contact, presence: true
    validates_format_of :contact, with: URI.regexp
    validate :correct_image_type
    has_one_attached :image

    def correct_image_type
        if image.attached? && !image.content_type.in?(%w(image/jpeg iamge/png))
            errors.add(:image, 'Image, precisar ser JPEG ou PNG!')
        elsif image.attached? == false   
            errors.add(:image, 'Uma imagem precisa ser selecionada!') 
        end    
    end
end
