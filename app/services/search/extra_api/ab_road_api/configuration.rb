module Search
  module ExtraApi
    module AbRoadApi
      module Configuration
        mattr_accessor :key

        class << self
          def configure
            yield self

            self
          end
        end
      end
    end
  end
end
