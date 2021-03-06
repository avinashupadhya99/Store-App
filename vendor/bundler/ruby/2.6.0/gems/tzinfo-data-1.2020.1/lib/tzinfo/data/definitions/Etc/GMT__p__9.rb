# encoding: UTF-8

# This file contains data derived from the IANA Time Zone Database
# (https://www.iana.org/time-zones).

module TZInfo
  module Data
    module Definitions
      module Etc
        module GMT__p__9
          include TimezoneDefinition
          
          timezone 'Etc/GMT+9' do |tz|
            tz.offset :o0, -32400, 0, :'-09'
            
          end
        end
      end
    end
  end
end
