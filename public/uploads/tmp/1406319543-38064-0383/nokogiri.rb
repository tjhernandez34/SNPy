 require "nokogiri"
  require "open-uri"
desc 'Fetch risk markers'
task :fetch_markers => :environment do


# class Parse
#   attr_accessor :disease_names, :disease_id, :snp_info, :allele_info, :risk_info

#   def initialize(page)
#     @cut_page = page
#
#   end

#   def do_it
#     x = 1
  def parse(url)
    @cut_page = url
    @page = Nokogiri::HTML(open(url))
    @cut_page = @cut_page.sub(/.html/, "")
    last_description = ""
    @cut_page.gsub!("_", " ")
    category = Category.create(name: @cut_page)
    @page.css('#dna tr').map do |row|
      if row.css('.description').text != '' && row.css('.description').text != "Description"
        @last_description = row.css('.description').text
        @disease = Disease.create(name: @last_description, category_id: category.id)
        # if row.css('.snp').text != ''
        #   @last_snp = row.css('.snp').text
        # end

        if row.css('.risk').text != '' && row.css('.risk').text != "Risk alleles"

          row.css('.risk').children.css('font').each do |allele|
            if allele.attributes['color'].value == '#00FF00'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: -3, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#006600' || allele.attributes['color'].value == '#FF6633'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: -1, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#990000' || allele.attributes['color'].value == '#0000CC'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: 1, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#FF0000' || allele.attributes['color'].value == '#0099CC'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: 3, disease_id: @disease.id)
            end
          end
        end

      elsif row.css('.description').text == ''
        if row.css('.snp').text != ''
          @last_snp = row.css('.snp').text
        end
        if row.css('.risk').text != '' && row.css('.risk').text != "Risk alleles"
          row.css('.risk').children.css('font').each do |allele|
            allele.text.gsub!(", ", "")
            if allele.attributes['color'].value == '#00FF00'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: -3, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#006600' || allele.attributes['color'].value == '#FF6633'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: -1, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#990000' || allele.attributes['color'].value == '#0000CC'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: 1, disease_id: @disease.id)
            elsif allele.attributes['color'].value == '#FF0000' || allele.attributes['color'].value == '#0099CC'
              Marker.create(snp: row.css('.snp').text, allele: allele.text, risk_level: 3, disease_id: @disease.id)
            end
          end
        end

      end
    end
end

  #create all the objects from this category hash
  pages = ["autoimmune.html", "genetic.html", "cancer.html", "neurodegenerative.html", "neuropsychological.html", "cardiovascular.html", "digestive.html", "addictions.html", "female_specific.html", "miscellaneous.html"]
  # urls = ["http://www.eupedia.com/genetics/autoimmune_diseases_snp.shtml"]
  pages.each do |page|
    parse(page)
  end
end
