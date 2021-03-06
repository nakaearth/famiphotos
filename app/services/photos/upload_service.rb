# frozen_string_literal: true
module Photos
  class UploadService
    def self.execute(current_user, photo_params)
      new.instance_eval do
        @photo = current_user.photos.build(photo_params)

        execute
      end
    end

    private

    def execute
      ActiveRecord::Base.transaction do
        Photo.with_writable { @photo.save! }
      end
    end
  end
end
