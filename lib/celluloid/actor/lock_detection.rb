$CELLULOID_LOCKDETECTOR ||= true
$CELLULOID_LOCKDETECTOR_CHECKING ||= 1
$CELLULOID_LOCKDETECTOR_INTERVAL ||= 4

module Celluloid
  class Actor
    module LockDetector
      class << self
        def included(object)
          object.initializer!(:initialize_unlocker)
          object.actor_created!(:detector_watching)
          object.actor_removed!(:detector_releasing)
        end
      end

      def initialize_unlocker
        @actors = []
        @addresses = []
        @timers = []
        @watchers = []
      end

      #Actor remove from the array & remove all other consecutive arrays 
      def detector_releasing(actor)
        index = @actors.index(actor)
        @actors.delete_at(index)
        @addresses.delete_at(index)
        @timers.delete_at(index)
        @watchers.delete_at(index)
      end

      def unlocking(interval)
      
      end

      #ReportEvent System Event return to here
      def report!(uuid,timer)
        index = @addresses.index(uuid)
        @timers[index] = Time.now
      end

      #Detecting deadlocks
      def timer_watching(timer,actor)
        current = Time.now
        diff = current - timer

        if diff > $CELLULOID_LOCKDETECTOR_INTERVAL
          Internals::Logger.warn "DEADLOCK Detected in the Actor System."

          actor.tasks.to_a.each do |task|
            if task.running? 
              
            end
          end
          index = @actors.index(actor)
          @timers[index] = Time.now
        end
      end

      #ReportEvent SystemEvent call on each actor from $CELLULOID_LOCKDETECTOR_CHECKING Time Interval
      def detect!(actor)
        index = @actors.index(actor)
        actor.mailbox << Celluloid::Actor::Manager::ReportEvent.new(@addresses[index],@timers[index])
        timer_watching(@timers[index],actor)

        after($CELLULOID_LOCKDETECTOR_CHECKING) { detect!(actor) }
      end

      #All newly created actors handle here
      def detector_watching(actor)
        unless @actors.include?(actor)
          @actors << actor
          @addresses << Celluloid.uuid
          @timers << Time.now
          @watchers << after($CELLULOID_LOCKDETECTOR_CHECKING) { detect!(actor) }
        end
      end

    end
  end
end
