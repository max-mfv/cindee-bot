require 'telegram/bot'

class TelegramSender
  class << self
    BOT_TOKEN = '1601727768:AAFt0vu1lyLanNRTFtilkEN-AGElpUaioMg'

    def send(msg)
      Telegram.bots_config = {
        default: BOT_TOKEN,
        chat: {
          token: BOT_TOKEN,
          username: 'Hacker',
        }
      }

      updates = Telegram.bot.get_updates
      Telegram.bot == Telegram.bots[:default]
      chat_id = updates['result'].last['message']['chat']['id']

      Telegram.bots[:chat].send_message(chat_id: chat_id, text: msg)
    end
  end
end