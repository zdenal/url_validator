$LOAD_PATH.unshift(File.dirname(__FILE__) + '/../lib')
$LOAD_PATH.unshift(File.dirname(__FILE__) + '/resources')
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'rspec'
require 'sqlite3'
require 'active_record'
require 'active_record/base'
require 'active_record/migration'
require 'ruby-debug'

ActiveRecord::Migration.verbose = false
ActiveRecord::Base.establish_connection(
    "adapter"   => "sqlite3",
    "database"  => ":memory:"
)

require File.join(File.dirname(__FILE__), '..', 'init')

autoload :User                 ,'resources/user'
autoload :UserWithBlank        ,'resources/user_with_blank'
autoload :UserWithAr           ,'resources/user_with_ar'
autoload :UserWithCustomScheme ,'resources/user_with_custom_scheme'
autoload :UserWithPrefferedSchema ,'resources/user_with_preffered_schema'

