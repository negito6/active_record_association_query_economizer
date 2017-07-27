require "active_record_association_query_economizer/version"

activerecord_version = ActiveRecord.version
case activerecord_version
when Gem::Requirement.create(['>= 4.2', '< 5'])
  require 'active_record_association_query_economizer/rails4-2/associations'
when Gem::Requirement.create(['>= 5.0', '<= 5.1.1'])
  require 'active_record_association_query_economizer/rails5/associations'
else
  puts "active_record_association_query_economizer doesn't yet do anything on ActiveRecord #{activerecord_version}"
end
