RSpec.describe Celluloid::Actor::LockDetector do

  let(:logger) { Specs::FakeLogger.current }

  it "Mutex synchronize deadlock detected" do
    allow(logger).to receive(:crash)
    
    Celluloid.boot

    mutex1 = MutexSync.new
    mutex2 = MutexSync.new
    mutex1.async.wait
    mutex2.async.wait_for(mutex1)

    if RUBY_PLATFORM == "java"
      expect(logger).to receive(:warn).with(/DEADLOCK Detected in the Actor System./)
    elsif RUBY_ENGINE == "rbx" || RUBY_ENGINE == "ruby"
      expect(logger).to receive(:crash)
    end

    sleep 7

    Celluloid.shutdown
  end
end
