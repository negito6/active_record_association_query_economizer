require "activerecord_preload_economizer/version"

activerecord_version = ActiveRecord.version.to_s
case activerecord_version
when /\A4\.2/
  require 'activerecord_preload_economizer/rails4-2/associations'
else
  puts "activerecord_preload_economizer doesn't yet do anything on ActiveRecord #{activerecord_version}"
end
