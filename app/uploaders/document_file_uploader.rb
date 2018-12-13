class DocumentFileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_whitelist
    %w[pdf doc docx xls xlsx ppt pptx csv odt odp ods]
  end
end
