require 'telegram/bot'

class TelegramSender
  class << self

    def send(msg)
      Telegram.bots_config = {
        default: '1601727768:AAHvdJmAaqsP62urSGoOOLHrvRztZ04GZHI',
        chat: {
          token: '1601727768:AAHvdJmAaqsP62urSGoOOLHrvRztZ04GZHI',
          username: 'Bot',
        }
      }

      updates = Telegram.bot.get_updates
      chat_id = updates['result'].last['message']['chat']['id']

      Telegram.bots[:chat].send_message(chat_id: chat_id, text: msg)
    end
  end
end