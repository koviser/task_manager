require 'mime/types'
require 'mini_magick'

module Modules

  module Uploader
    def self.included(base)
      base.send(:include, InstanceMethods)
      base.send(:extend, ClassMethods)
    end
  end

  module ClassMethods
    def self.extended(base)

      base.class_eval do

        def store_dir
          "uploads/#{model.class.to_s.underscore}/#{mounted_as}"
        end

        def extension_white_list
          %w(jpg jpeg gif png bmp tiff)
        end

        def filename
          if file.respond_to? :extension
            extension = file.extension
          else
            extension = 'jpg'
          end
          if model.new_record?
            next_id = begin
              table_name = model.class.table_name
              id = ActiveRecord::Base.connection.execute("SELECT last_value + 1 FROM #{table_name}_id_seq").values.flatten.first.to_i
              id = 1 if id == 2 && Project.all.count == 0
              id
            rescue
              1
            end
            name =  "#{next_id}.#{extension}"
          else
            name =  "#{model.id}.#{extension}"
          end
          return name
        end

      end
    end
  end

  module InstanceMethods

    def strip
      manipulate! do |img|
        img.strip
        img = yield(img) if block_given?
        img
      end
    end

    def quality(percentage)
      manipulate! do |img|
        img.quality(percentage)
        img = yield(img) if block_given?
        img
      end
    end

    def extract_content_type
      if file.content_type == 'application/octet-stream' || file.content_type.blank?
        content_type = MIME::Types.type_for(original_filename).first
      else
        content_type = file.content_type
      end

      model.data_content_type = content_type.to_s
    end

    def set_size
      model.data_file_size = file.size
    end

    def read_dimensions
      if model.image? && model.has_dimensions?
        magick = ::MiniMagick::Image.new(current_path)
        model.width, model.height = magick[:width], magick[:height]
      end
    end

    def read_dimensions_picture
      if model.picture?
        magick = ::MiniMagick::Image.new(current_path)
        model.width, model.height = magick[:width], magick[:height]
      end
    end

    
  end

end