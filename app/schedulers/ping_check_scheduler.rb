# frozen_string_literal: true

class PingCheckScheduler
  include Sidekiq::Worker

  def perform
    Check.run
  end
end
