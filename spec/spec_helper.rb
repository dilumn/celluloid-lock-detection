require "coveralls"
Coveralls.wear!

require "rubygems"
require "bundler/setup"

# Require in order, so both CELLULOID_TEST and CELLULOID_DEBUG are true
require "celluloid/test"
require "celluloid/actor/lock_detection"

module CelluloidSpecs
  def self.included_module
    # Celluloid::IO implements this with with 'Celluloid::IO'
    Celluloid
  end

  # Timer accuracy enforced by the tests (50ms)
  TIMER_QUANTUM = 0.05
end

$CELLULOID_DEBUG = true

require "celluloid/probe"
require "rspec/log_split"

Celluloid.shutdown_timeout = 1

=begin
logfile = File.open(File.expand_path("../../log/test.log", __FILE__), 'a')
logfile.sync = true
Celluloid.logger = Logger.new(logfile)
=end

Dir["./spec/support/*.rb, ./spec/shared/*.rb"].map { |f| require f }

RSpec.configure do |config|
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.disable_monkey_patching!

  config.log_split_dir = File.expand_path("../../log/#{Time.now.iso8601}", __FILE__)
  config.log_split_module = Celluloid

  config.around do |ex|
    Celluloid.actor_system = nil

    Thread.list.each do |thread|
      next if thread == Thread.current
      if RUBY_PLATFORM == "java"
        # Avoid disrupting jRuby's "fiber" threads.
        next if /Fiber/ =~ thread.to_java.getNativeThread.get_name
      end
      thread.kill
    end

    ex.run
  end

  config.around actor_system: :global do |ex|
    Celluloid.boot
    ex.run
    Celluloid.shutdown
  end

  config.around actor_system: :within do |ex|
    Celluloid::Actor::System.new.within do
      ex.run
    end
  end

  config.filter_gems_from_backtrace(*%w(rspec-expectations rspec-core rspec-mocks rspec-retry))

  config.mock_with :rspec do |mocks|
    mocks.verify_doubled_constant_names = true
    mocks.verify_partial_doubles = true
  end

  config.around(:each) do |example|
    example.run
  end

end