require 'sidekiq'
require_relative 'registrations'

class EventWorker
  include Sidekiq::Worker

  sidekiq_options({ retry: true, failures: true })

  def perform(event_name, payload)
    # p event_name, payload
    EventBus::Registrations.instance.announce(event_name, payload, true)
  end
end
