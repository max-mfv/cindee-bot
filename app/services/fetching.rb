require 'nokogiri'
require 'open-uri'
require 'uri'
require 'telegram/bot'

class Fetching

  def run

    data = {
      "CateID": "620776E6-32E0-46FF-9219-FC52CB2A8C19",
      "SortASC": 3,
      "Page": 1
    }

    url = "https://checkinvietnam.vtc.vn/CIHolic/ContestArticleList"

    response = HTTParty.post(url,
      body: URI.encode_www_form(data),
      headers: {
        'Content-Type' => 'application/x-www-form-urlencoded'
      }
    )


    Telegram.bots_config = {
      default: '1601727768:AAFt0vu1lyLanNRTFtilkEN-AGElpUaioMg',
      chat: {
        token: '1601727768:AAFt0vu1lyLanNRTFtilkEN-AGElpUaioMg',
        username: 'Hacker',
      },
    }

    updates = Telegram.bot.get_updates
    Telegram.bot == Telegram.bots[:default] # true
    chat_id = updates['result'].last['message']['chat']['id']

    # Fetch and parse HTML document
    doc = Nokogiri::HTML(response)

    # Search for nodes by css
    # doc.css('ul ul.menu li a', 'article h2').each do |link|
    #   puts link.content
    # end

    result = doc.css('ul li').each_with_index.map do |link, index|
      root = link.search('div.info_tindi').search('div.diadiem_tacgia')
      vote = root.search('div.bx_vote').children[0].content.gsub(/\s+/, '')
      author = root.search('span.tx_tacgia').first.content
      title = link.search('h5').first.content

      if author == 'Ha Trinh' && index + 1 > 5
        Telegram.bots[:chat].send_message(chat_id: chat_id, text: "🚨🚨🚨 #{author} bị rớt top rồi !!!!!!!!")
        Telegram.bots[:chat].send_message(chat_id: chat_id, text: "🚨🚨🚨 #{author} bị rớt top rồi !!!!!!!!")
        Telegram.bots[:chat].send_message(chat_id: chat_id, text: "🚨🚨🚨 #{author} bị rớt top rồi !!!!!!!!")
        Telegram.bots[:chat].send_message(chat_id: chat_id, text: "🚨🚨🚨 #{author} bị rớt top rồi !!!!!!!!")
      end

      "❗️#{index + 1} [#{vote}] - #{author} [#{title}]"
    end



    Telegram.bots[:chat].send_message(chat_id: chat_id, text: result.join("\n"))

    # # Search for nodes by xpath
    # doc.xpath('//nav//ul//li/a', '//article//h2').each do |link|
    #   puts link.content
    # end

    # # Or mix and match
    # doc.search('nav ul.menu li a', '//article//h2').each do |link|
    #   puts link.content
    # end
  end
end