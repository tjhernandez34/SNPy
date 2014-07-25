require File.expand_path('../lib', __FILE__)

desc "totaling the karma points"
task :fetch_markers => :environment do


  puts "in the rake task"

  class Parse
  attr_accessor :disease_names, :disease_id, :snp_info, :allele_info, :risk_info

  def initialize(page)
    @cut_page = page
    @page = Nokogiri::HTML(open(page))
    @category_hash = {}
  end

  def do_it
    @cut_page = @cut_page.sub(/.html/, "")
    last_description = ""
    @category_hash["#{@cut_page}"] = {}
    @page.css('#dna tr').map do |row|
      if row.css('.description').text != '' && row.css('.description').text != "Description"
        @last_description = row.css('.description').text
        @category_hash["#{@cut_page}"]["#{@last_description}"] = {}
        if row.css('.snp').text != ''
          @last_snp = row.css('.snp').text
          @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"] = {}
        end
        if row.css('.risk').text != '' && row.css('.risk').text != "Risk alleles"
          row.css('.risk').children.css('font').each do |allele|
            if allele.attributes['color'].value == '#00FF00'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => -3)
            elsif allele.attributes['color'].value == '#006600' || allele.attributes['color'].value == '#FF6633'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => -1)
            elsif allele.attributes['color'].value == '#990000' || allele.attributes['color'].value == '#0000CC'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => 1)
            elsif allele.attributes['color'].value == '#FF0000' || allele.attributes['color'].value == '#0099CC'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => 3)
            end
          end
        end
      elsif row.css('.description').text == ''
        if row.css('.snp').text != ''
          @last_snp = row.css('.snp').text
          @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"] = {}
        end
        if row.css('.risk').text != '' && row.css('.risk').text != "Risk alleles"
          row.css('.risk').children.css('font').each do |allele|
            allele.text.gsub!(", ", "")
            if allele.attributes['color'].value == '#00FF00'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => -3)
            elsif allele.attributes['color'].value == '#006600' || allele.attributes['color'].value == '#FF6633'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => -1)
            elsif allele.attributes['color'].value == '#990000' || allele.attributes['color'].value == '#0000CC'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => 1)
            elsif allele.attributes['color'].value == '#FF0000' || allele.attributes['color'].value == '#0099CC'
              @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"].merge!(allele.text => 3)
            end
          end
        end

      end
    end
    p @category_hash
  end
end

pages = ["autoimmune.html", "genetic.html", "cancer.html", "neurodegenerative.html", "neuropsychological.html", "cardiovascular.html", "digestive.html", "addictions.html", "female_specific.html", "miscellaneous.html"]

pages.each do |page|
  test = Parse.new(page)
  test.do_it
end





  # User.find_each(batch_size: 2000) do |user|

  #   # sum their karma points
  #   total_karma = user.karma_points.sum(:value)

  #   # save sum to total_karma on user
  #   user.total_karma = total_karma
  #   user.save(validate: false)
  #   print "."

end
