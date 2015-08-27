#Deadlock using Mutex Synchronize
class MutexSync
  include Celluloid

  def initialize
    @mutex = Mutex.new
  end

  def wait
    @mutex.synchronize do
      sleep 10
    end
  end

  def wait_for(obj)
    obj.wait
  end
end

#Deadlock using Mutex Lock
class MutexLock 
  include Celluloid

  def initialize
    @mutex = Mutex.new
    @balance = 500
  end

  def withdraw(amount)
    @balance = @balance - amount;
  end

  def deposit(amount)
    @balance = @balance + amount;
  end

  def transfer(from, to, amount)
    @mutex.lock
    from.withdraw(amount)
    to.deposit(amount)
    @mutex.unlock
  end
end

#Deadlock with exclusive block
class ExclusiveLock
  include Celluloid

  def create(obj)
    exclusive do
      sleep 5
      obj.create_two
    end
  end

  def create_two
    exclusive do
      sleep 3
    end
  end

  def running(obj)
    obj.create(obj)
  end
end
