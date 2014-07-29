require 'open-uri'

class Report < ActiveRecord::Base
  belongs_to :genome
  has_many :risks

  attr_reader :create_report

  def parse(bucket, key)
    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    puts params[:bucket]
    puts params[:key] 

    puts "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    data = open("https://s3.amazonaws.com/#{bucket}/#{key}") 
    puts "--------------------------------------------------"
    data.read.each_line do |line|
      puts "x"
      snp = line.scan(/(^rs\d+|^i\d+)/)
      allele = line.scan(/\s([A,T,G,C]{2})(\s|\z)/)
      if snp != "" && allele != ""
        puts "y"
        snp = snp.join.strip
        allele = allele.join.strip
        $redis.hset(current_user.username, snp, allele)
      end

    end

    Marker.all.each do |marker|
      if $redis.hget(current_user.username, marker.snp) == marker.allele
        puts "z"
        Risk.create(report_id: self.id, marker_id: marker.id)
      end
    end
    $redis.del(current_user.username)
    
  end



end
