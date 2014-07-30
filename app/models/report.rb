require 'open-uri'

class Report < ActiveRecord::Base
  belongs_to :genome
  has_many :risks

  attr_reader :create_report

  def parse(bucket, key, user)
    puts 'xxxxxxxxxxxxx'
    data = open("https://s3.amazonaws.com/#{bucket}/#{key}") 
    data.read.each_line do |line|
      snp = line.scan(/(^rs\d+|^i\d+)/)
      allele = line.scan(/\s([A,T,G,C]{2})(\s|\z)/)
      if snp != "" && allele != ""
        snp = snp.join.strip
        allele = allele.join.strip
        $redis.hset(user.username, snp, allele)
      end
    end
    Marker.all.each do |marker|
      if $redis.hget(user.username, marker.snp) == marker.allele
        Risk.create(report_id: self.id, marker_id: marker.id)
      end
    end
    puts 'z'
    $redis.del(user.username)
  end
end
