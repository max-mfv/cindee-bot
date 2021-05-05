# frozen_string_literal: true

class PingReportScheduler
  include Sidekiq::Worker

  def perform
    Report.send
  end
end
