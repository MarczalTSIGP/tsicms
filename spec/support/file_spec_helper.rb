module FileSpecHelper
  class << self
    def pdf
      File.open(Dir["#{Rails.root}/spec/samples/pdfs/*"].sample)
    end

    def image
      File.open(Dir["#{Rails.root}/spec/samples/images/*"].sample)
    end
  end
end
