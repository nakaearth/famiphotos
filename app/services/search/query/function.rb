module Search
  module Query
    class Function
      def initialize(input_params, target_fields)
        @conditions = input_params
        @function   = []
        @fields     = target_fields
      end
    end
  end
end
