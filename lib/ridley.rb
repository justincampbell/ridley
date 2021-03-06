require 'chozo'
require 'active_support/core_ext'
require 'celluloid'
require 'faraday'
require 'addressable/uri'
require 'multi_json'
require 'active_model'
require 'active_support/inflector'
require 'forwardable'
require 'thread'
require 'pathname'

if jruby?
  require 'json/pure'
else
  require 'json/ext'
end

require 'ridley/version'
require 'ridley/errors'

JSON.create_id = nil

# @author Jamie Winsor <jamie@vialstudios.com>
module Ridley
  CHEF_VERSION = '10.16.2'.freeze

  autoload :Bootstrapper, 'ridley/bootstrapper'
  autoload :Client, 'ridley/resources/client'
  autoload :Connection, 'ridley/connection'
  autoload :ChainLink, 'ridley/chain_link'
  autoload :Cookbook, 'ridley/resources/cookbook'
  autoload :DataBag, 'ridley/resources/data_bag'
  autoload :DataBagItem, 'ridley/resources/data_bag_item'
  autoload :DSL, 'ridley/dsl'
  autoload :Environment, 'ridley/resources/environment'
  autoload :Logging, 'ridley/logging'
  autoload :Node, 'ridley/resources/node'
  autoload :Resource, 'ridley/resource'
  autoload :Role, 'ridley/resources/role'
  autoload :Search, 'ridley/resources/search'
  autoload :SSH, 'ridley/ssh'

  class << self
    extend Forwardable

    def_delegator "Ridley::Logging", :logger
    alias_method :log, :logger

    def_delegator "Ridley::Logging", :logger=
    def_delegator "Ridley::Logging", :set_logger

    def connection(*args)
      Connection.new(*args)
    end

    def sync(*args, &block)
      Connection.sync(*args, &block)
    end

    # @return [Pathname]
    def root
      @root ||= Pathname.new(File.expand_path('../', File.dirname(__FILE__)))
    end
  end
end

require 'ridley/middleware'
