RSpec.describe Celluloid::Actor::LockDetector do

  let(:logger) { Specs::FakeLogger.current }

  it "Mutex Lock deadlock detected" do
    allow(logger).to receive(:crash)

    Celluloid.boot

    mutex_lock1 = MutexLock.new
    mutex_lock2 = MutexLock.new
    mutex_lock1.async.transfer(mutex_lock1,mutex_lock2,100)
    mutex_lock1.async.transfer(mutex_lock2,mutex_lock1,100)

    if RUBY_PLATFORM == "java"
      expect(logger).to receive(:warn).with(/DEADLOCK Detected in the Actor System./)
    elsif RUBY_ENGINE == "rbx" || RUBY_ENGINE == "ruby"
      expect(logger).to receive(:crash)
    end
    

    sleep 5.5

    Celluloid.shutdown
  end
end
