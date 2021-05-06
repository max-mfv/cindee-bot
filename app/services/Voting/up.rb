require "redis"

module Voting
  class Up
    class << self
      RANKING = [
        {:rank=>1, :id=>"3E082295-5237-4F30-8C2C-F6C05B2F5DE5"}, #Hoàng Anh 3A
        {:rank=>2, :id=>"C2C27FF7-E14B-43B1-B2BB-1EF26C73ED7B"}, #Phương Chipi
        {:rank=>3, :id=>"C1912378-B2B3-41F9-AC6C-0E5D16043FC7"}, #Nguyễn Văn Chúc
        {:rank=>4, :id=>"CD23765A-16CF-4158-BC9A-C4E626DE2E47"}, #Ha Trinh
        {:rank=>5, :id=>"9E19484D-C2CE-402F-A12D-DA4EA222C8F5"}, #Kỳ Anh Nguyễn
        {:rank=>6, :id=>"AF49D01F-37B0-45E9-9D00-BCD0E7955BDF"}, #7Nghĩa Trịnh
        {:rank=>7, :id=>"38E938B8-F44E-4954-9D9F-81D119583EBA"}, #Nguyễn Hữu Hiếu
        {:rank=>8, :id=>"1E2CB228-E917-4B5D-B1D2-D19E72931E05"}, #Bích Ngọc
        {:rank=>9, :id=>"C281EF5E-577E-43D5-A727-8FBE5B7DE40E"}, #6Nguyễn Đức Minh
        {:rank=>10, :id=>"14D31A2B-0CBA-4C5B-AA42-7A7B3B3C126A"}, #Bùi Quang Thuỵ
        {:rank=>11, :id=>"E892BEC9-9701-4C34-B993-DEDB998E88AA"}, #Phương Mai Nguyễn
        {:rank=>12, :id=>"970DD1E4-C8A4-41BA-8218-032C4A642B63"}  #Châu Vũ Hải An
      ]

      def run
        top10 = Fetching.new.run
        redis = Redis.new

        RANKING.each do |expected_rank|
          current_position = top10.find {|top| top[:uid] == expected_rank[:id]}

          if current_position[:index] > expected_rank[:rank]
            redis.set("running", true)

            TelegramSender.send("Bắt đầu chạy !!!!")
            devote_user = top10.find {|top| top[:index] == expected_rank[:rank]}

            gen_count = (devote_user[:vote].to_i - current_position[:vote].to_i + (41..100).to_a.sample) / 3

            accounts = Account::Generate.run(gen_count)
            puts "Total vote = #{gen_count * 3}"
            accounts.each do |username|
              puts "================================"
              puts "#{username} voted for #{current_position[:author]}"
              puts "================================"
              Account::Hack.run(username, current_position[:uid])
            end
            Report.send
            redis.set("running", nil)
            return
          end
        end
      end
    end
  end
end