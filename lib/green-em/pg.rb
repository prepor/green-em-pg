require 'green-em'
require 'em/pg'
class Green
  module EM
    class PG < ::EM::PG
      VERSION = "0.1.1"
      def self.new(*args)
        Green.hub # ensure started green hub
        db = super(*args)
        Green::EM.sync db
        db
      end

      [:send_query, :send_prepare, :send_query_prepared, :send_describe_prepared, :send_describe_portal].each do |m|
        define_method(m) do |*args|
          Green::EM.sync super(*args)
        end
      end
    end
  end
end
