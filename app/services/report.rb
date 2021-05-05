class Report
  class << self
    def send
      top = Fetching.new.run
      result = top.map do |post|
        if post[:idol]
          "⭐️#{post[:index]} [#{post[:vote]}] - #{post[:author]} [#{post[:title]}]"
        else
          "❗️#{post[:index]} [#{post[:vote]}] - #{post[:author]} [#{post[:title]}]"
        end
      end

      TelegramSender.send(result.join("\n"))
    end
  end
end