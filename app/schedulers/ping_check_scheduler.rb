# frozen_string_literal: true
require "redis"

class PingCheckScheduler
  include Sidekiq::Worker

  def perform
    redis = Redis.new
    return if redis.get('running').present?

    Voting::Up.run
  end
end
