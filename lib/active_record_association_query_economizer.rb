require "active_record_association_query_economizer/version"
require 'active_record_association_query_economizer/association_extension'

activerecord_version = ActiveRecord.version
case activerecord_version
when Gem::Requirement.create(['>= 4.2', '< 5'])
  require 'active_record_association_query_economizer/rails4-2/associations'
when Gem::Requirement.create(['>= 5.0', '<= 5.1.6'])
  require 'active_record_association_query_economizer/rails5/associations'
else
  Kernel.warn "active_record_association_query_economizer doesn't yet do anything on ActiveRecord #{activerecord_version}"
end
