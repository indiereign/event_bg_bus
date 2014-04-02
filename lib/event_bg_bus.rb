require_relative 'event_bus/event_worker'
require_relative 'event_bus'

class EventBGBus

  class << self
    #
    # Announce an event in the background to any waiting listeners.
    #
    # The +event_name+ is added to the +payload+ hash (with the key +"event_name"+)
    # before being passed on to listeners.
    #
    # note that the +payload+ hash won't be accessed using the symbol syntax
    # so instead of using +payload[:param]+ you can only use +payload['param']
    # this is due to sidekiq limitation with background jobs
    #
    # @param event_name [String, Symbol] the name of your event
    # @param payload [Hash] the information you want to pass to the listeners
    # @return [EventBGBus] the EventBGBus, ready to be called again.
    #
    def publish(event_name, payload = {})
      case event_name
      when Symbol, String
        EventWorker.perform_async(event_name, payload)
        self
      else
        raise ArgumentError.new('The event name must be a string or a symbol')
      end
    end

    alias :announce :publish
    alias :broadcast :publish

  end

end
