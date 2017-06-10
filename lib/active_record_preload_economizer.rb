require "active_record_preload_economizer/version"

activerecord_version = ActiveRecord.version
case activerecord_version
when Gem::Requirement.create(['>= 4.2', '< 5'])
  require 'active_record_preload_economizer/rails4-2/associations'
else
  puts "active_record_preload_economizer doesn't yet do anything on ActiveRecord #{activerecord_version}"
end
