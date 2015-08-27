RSpec.describe Celluloid::Actor::LockDetector do

  let(:logger) { Specs::FakeLogger.current }

  it "exclusive block deadlock detected" do
    Celluloid.boot

    exclusive_lock1 = ExclusiveLock.new
    exclusive_lock2 = ExclusiveLock.new
    exclusive_lock1.async.create(exclusive_lock2)
    exclusive_lock2.async.running(exclusive_lock1)

    expect(logger).to receive(:warn).with(/DEADLOCK Detected in the Actor System./)

    sleep 5.5

    Celluloid.shutdown
  end
end
