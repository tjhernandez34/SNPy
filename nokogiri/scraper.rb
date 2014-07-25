require 'nokogiri'
require 'open-uri'
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
  # @pages.each do |page|
    @cut_page = page
    @page = Nokogiri::HTML(open(page))
    @category_hash = {}
    # @disease_names = []
    # @snp_info = []
    # @allele_info = []
    @risk_info = []
  end

  def do_it
    x = 1
    @cut_page = @cut_page.sub(/.html/, "")
    last_description = ""
    @category_hash["#{@cut_page}"] = {}
      @page.css('tr').map do |row|

        row.css('.description').map do |description|
          if description.text != '' && description.text != "Description"
            last_description = description.text
            @category_hash["#{@cut_page}"]["#{last_description}"] = {}

            row.css('.snp').map do |snp|
              if snp.text != '' && snp.text != "SNP"
                @last_snp = snp.text
                @category_hash["#{@cut_page}"]["#{last_description}"]["#{@last_snp}"] = {}
              end
            end

            row.css('.risk').map do |allele|
              @category_hash["#{@cut_page}"]["#{last_description}"]["#{@last_snp}"] = allele.text
            end

          elsif description.text == ''

            row.css('.snp').map do |snp|
              if snp.text != '' && snp.text != "SNP"
                @last_snp = snp.text
                @category_hash["#{@cut_page}"]["#{last_description}"]["#{@last_snp}"] = {}
              end
            end

            row.css('.risk').map do |allele|
              @category_hash["#{@cut_page}"]["#{last_description}"]["#{@last_snp}"] = allele.text
            end


          end
        end

      end
    puts @category_hash
    end

                      # row.css('.risk').map do |allele|
                  #   # if allele != "" && allele != "Risk Alleles"
                  #   p @category_hash["#{@cut_page}"]["#{last_description}"][snp.text]= [allele.text]
                  #   # else
                  #   #   break
                  #   # end
                  # end
# @last_description = ""
# @category_hash["#{@cut_page}"] = {}

#     def do_it
#       @cut_page = @cut_page.sub(/.html/, "")
#         @page.css('tr').map do |row|
#           get_description(row)
#         end
#     end


#       def get_description(row)
#         row.css('.description').map do |description|
#           if description.text != '' && description.text != "Description"
#           @last_description = description.text
#           @category_hash["#{@cut_page}"]["#{@last_description}"] = {}
#           get_snp(row)
#           end
#         end
#       end

#       def get_snp(row)
#         row.css('.snp').map do |snp|
#           if snp.text != '' && snp.text != "SNP"
#             @category_hash["#{@cut_page}"]["#{@last_description}"][snp.text] = {}
#           end
#         end
#       end

    # puts @category_hash["#{@cut_page}"]
    # puts @cut_page
    # puts @risk_info
    # @risk_info.each do |hash|
    #   @category_hash.add(hash)
    # end

    # def get_alleles
    #   row.css('.risk').map do |snp|
    #           if snp.text != '' && snp.text != "SNP"
    #           @category_hash["#{@cut_page}"]["#{last_description}"][snp.text] = {}
    #           end
    # end

  end




  # def get_disease_info
  #   @page.css('tr td[class="description"]').map do |description|
  #     if description.inner_text != "" && description.inner_text != "Description"
  #       @disease_names << description.text
  #     end
  #   end

  #   @disease_id#we noticed that it was running through the table, and doing row with description, and empty row before it was entering the table

  #   @page.css('td[class="snp"]').map do |snp|
  #     # if snp.inner_text != "SNP"
  #       @snp_info << snp.inner_text
  #       # page.search('.dna .snp .risk').map do |risk|
  #       #   snp_risks = risk.split(%r{,\s*})
  #       #     snp_risks.each do |allele|
  #     # end

  #       #       allele_info << allele
  #   end
  #       # p @snp_info..shift(2)
  #       p @snp_info
  #       p @disease_id
  # end

  #   puts snp_info
  # end
# end

# @files = ['addictions.html', 'autoimmune.html', 'cancer.html', 'cardiovascular.html', 'digestive.html', 'female_specific.html', 'genetic.html', 'miscellaneous.html', 'neurodegenerative.html', 'neuropsychological.html']

# @files.each do |file|
#   Parse.new(file)
#   #should create a category hash with diseases that have snps that have alleles structure of hash (hash >> category >> disease >> snp >> allele )
#   #Create associated objects for that parse
# end

  #create all the objects from this category hash

test = Parse.new('autoimmune.html')
test.do_it
