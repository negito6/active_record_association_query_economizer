require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'active_record'
require 'activerecord_preload_economizer'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.boolean :postable
  end

  create_table :posts do |t|
    t.string :body
    t.references :user
  end
end

class User < ActiveRecord::Base
  has_many :posts, preload_if: -> (record) {
    record.postable == true
  }
end

class Post < ActiveRecord::Base
  belongs_to :user
end
