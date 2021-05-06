module Account
  class Generate
    FIRSTNAME = ['manh', 'ha', 'trung','linh','dat','linh','lam','nhi','trung','yen','thanhmai','huyenthanh','giau','nam','minh','ly','hoa','tan','thi','bin','phuonganh','huy','ngan','van','linh','hanh','hoang','yen','nhu','du','khanh','phuongtrinh','mai','dieu','thieny','lananh','minhanh','vi','tham','myanh','kimanh','uyen','tu','huong','dung','dang','han','vy','tram','jasmine','annie','dieu','trang','thao','ngoc','giang','han','hoang','phung','nga','hung','xuan','phuong','tuyen','tran','le','thy','nha','nguyen','nhung','truc', 'ngocmai']

    LASTNAME = ['nguyen', 'tran', 'trung', 'trinh', 'le','dao','thanh','an','hoang','duong','ha','truong','chau','ngo','truong','thanh','chau','doan','lam','long','dang','vo','do','huynh','pham','phan','bao','phung','hoang','truong','bui','dang','ta','kieu','phuong','lu','mai','nghiem','quach','vuong','hoang','dam','trieu','la']

    class << self
      def run(nums)
        nums.times.map do |i|
          if i % 3 == 0
            "#{FIRSTNAME.sample}.#{LASTNAME.sample}"
          elsif i % 5 == 0
            "#{LASTNAME.sample}_#{FIRSTNAME.sample}"
          elsif i % 7 == 0
            "#{LASTNAME.sample}_#{Time.current.to_i}"
          else
            "#{FIRSTNAME.sample}#{LASTNAME.sample}#{Time.current.to_i}"
          end
        end.uniq
      end
    end
  end
end