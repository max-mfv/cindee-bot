require 'nokogiri'
require 'open-uri'
require 'uri'

class Fetching

  IDOL = 'Ha Trinh'

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

    doc = Nokogiri::HTML(response)

    result = doc.css('ul li').each_with_index.map do |link, index|
      root = link.search('div.info_tindi').search('div.diadiem_tacgia')
      vote = root.search('div.bx_vote').children[0].content.gsub(/\s+/, '')
      author = root.search('span.tx_tacgia').first.content
      title = link.search('h5').first.content

      {
        index: index + 1,
        vote: vote,
        author: author,
        title: title,
        idol: author == IDOL
      }
    end
  end
end