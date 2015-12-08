module Photos
  class UploadService
    def self.execute(current_user, photo_params)
      new.instance_eval do
        binding.pry
        @photo = current_user.photos.build(photo_params)
      end
    end

    private

    def execute
      ActiveRecord::Base.transaction do
        @photo.save!
      end
    end
  end
end
