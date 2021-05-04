class Check
  class << self
    IDOL = 'Ha Trinh'
    TOP_INDEX = 3

    def run
      top = Fetching.new.run
      idol = top.find{|a| a[:idol] == true}

      if idol[:index] > TOP_INDEX
        TelegramSender.send("🚨🚨🚨 #{idol[:author]} bị rớt top #{TOP_INDEX} rồi !!!!!!!!")
      end
    end
  end
end