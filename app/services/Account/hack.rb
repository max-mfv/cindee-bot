require 'nokogiri'
require 'open-uri'
require 'uri'

module Account
  class Hack
    class << self
      CREATE_URL = 'https://checkinvietnam.vtc.vn/User/DKCheckLogin'
      LOGIN_URL = 'https://checkinvietnam.vtc.vn/User/CheckLogin'
      VOTE_URL = 'https://checkinvietnam.vtc.vn/CIHolic/VoteArticle'

      def run(username, id)

        # CREATE ACCOUNT
        regsiter_data = {
          'userName': username,
          'Password': 'asdfasdf',
          'DeviceType': 1
        }

        response_create = HTTParty.post(CREATE_URL,
          body: URI.encode_www_form(regsiter_data),
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )

        # LOGIN ACCOUNT
        login_data = {
          'userName': username,
          'Password': 'asdfasdf',
          'OAuthSystemID': 1
        }

        response_login = HTTParty.post(LOGIN_URL,
          body: URI.encode_www_form(login_data),
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded'
          }
        )

        if response_login.parsed_response['responseCode'] == 1
          cookie_hash = HTTParty::CookieHash.new
          response_login.get_fields('Set-Cookie').each { |c| cookie_hash.add_cookies(c) }

          response_get = HTTParty.get('https://checkinvietnam.vtc.vn/check-in-holic-v1/checkinholic-2-dat-nuoc-can-gio--nghi-le-mot-ngay-thi-di-dau-o-sai-gon/1E2CB228-E917-4B5D-B1D2-D19E72931E05',
            headers: {
              'Cookie': cookie_hash.to_cookie_string
            }
          )

          doc = Nokogiri::HTML(response_get)
          token = doc.search('input[name="__RequestVerificationToken"]').first.values.last

          vote_data = {
            'ArtId': id,
            '__RequestVerificationToken': token
          }

          # cookie_hash2 = HTTParty::CookieHash.new
          response_get.get_fields('Set-Cookie').each { |c| cookie_hash.add_cookies(c) }

          response_vote = HTTParty.post(VOTE_URL,
            body: URI.encode_www_form(vote_data),
            headers: {
              'Content-Type' => 'application/x-www-form-urlencoded',
              'Cookie': cookie_hash.to_cookie_string
            }
          )
        end
      end
    end
  end
end