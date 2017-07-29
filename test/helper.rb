require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'active_record'
require 'active_record_association_query_economizer'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')

ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :users do |t|
    t.boolean :postable
    t.boolean :activated
  end

  create_table :posts do |t|
    t.string :body
    t.references :user
  end

  create_table :profiles do |t|
    t.string :name
    t.references :user
  end
end

class User < ActiveRecord::Base
  has_many :posts, preload_if:[ -> (record) {
    record.postable == true
  }, :active?]

  has_one :profile, preload_if: :active?

  def active?
    activated
  end
end

class Post < ActiveRecord::Base
  belongs_to :user
end

class Profile < ActiveRecord::Base
  belongs_to :user
end
