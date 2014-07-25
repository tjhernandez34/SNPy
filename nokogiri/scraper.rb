require 'nokogiri'
require 'open-uri'
require 'byebug'
# genetic = "genetic.html"
# cancers = "cancer.html"
# neurodegenerative = "neurodegenerative.html"
# psychological = "neuropsycological.html"
# heart = "heart.html"
# digestive = "digestive.html"
# addictions = "addictions.html"
# female = "female_specific.html"
# disorders = "miscellaneous.html"


# autoimmune = "autoimmune.html"
# genetic = "genetic.html"
# cancers = "cancer.html"
# neurodegenerative = "neurodegenerative.html"
# psychological = "neuropsycological.html"
# heart = "heart.html"
# digestive = "digestive.html"
# addictions = "addictions.html"
# female = "female_specific.html"
# disorders = "miscellaneous.html"

# @pages = [autoimmune, genetic, cancers, neurodegenerative, psychological, heart, digestive, addictions, female, disorders]

class Parse
  attr_accessor :disease_names, :disease_id, :snp_info, :allele_info, :risk_info

  def initialize(page)
    @cut_page = page
    @page = Nokogiri::HTML(open(page))
    @category_hash = {}
  end

  def do_it
    x = 1
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
        if row.css('.risk').text != ''
          @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"] = row.css('.risk').text
        end
      elsif row.css('.description').text == ''
        if row.css('.snp').text != ''
          @last_snp = row.css('.snp').text
          @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"] = {}
        end
        if row.css('.risk').text != ''
          @category_hash["#{@cut_page}"]["#{@last_description}"]["#{@last_snp}"] = row.css('.risk').text
        end
      end
    end
    p @category_hash
  end

end

  #create all the objects from this category hash

test = Parse.new('autoimmune.html')
test.do_it
