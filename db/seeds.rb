
# category1 = Category.create(name: "disease category")
# disease1 = Disease.create(name: "heart_disease", category_id: 1)
# disease2 = Disease.create(name: "cancer", category_id: 1)
# disease3 = Disease.create(name: "diabetes", category_id: 1)


# marker1 = Marker.create(snp: "rs50", allele: "CC", disease_id: "1")
# marker2 = Marker.create(snp: "rs50", allele: "AT", disease_id: "1")
# marker3 = Marker.create(snp: "rs50", allele: "GG", disease_id: "1")

# marker4 = Marker.create(snp: "rs51", allele: "CC", disease_id: "1")
# marker5 = Marker.create(snp: "rs51", allele: "AT", disease_id: "1")
# marker6 = Marker.create(snp: "rs51", allele: "GG", disease_id: "1")

# marker7 = Marker.create(snp: "rs20", allele: "CC", disease_id: "2")
# marker8 = Marker.create(snp: "rs20", allele: "AA", disease_id: "2")
# marker9 = Marker.create(snp: "rs20", allele: "GT", disease_id: "3")
# marker10 = Marker.create(snp: "rs20", allele: "CG", disease_id: "2")

# marker11 = Marker.create(snp: "rs21", allele: "CC", disease_id: "3")
# marker12 = Marker.create(snp: "rs21", allele: "GG", disease_id: "3")
# marker13 = Marker.create(snp: "rs21", allele: "AT", disease_id: "3")
# marker14 = Marker.create(snp: "rs21", allele: "AA", disease_id: "1")



# @user1 = User.create(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", username: "jerry", password_digest: "password")
# @user2 = User.create(first_name: "John", last_name: "Smith", email: "js@email.com", username: "john", password_digest: "password")

# Genome.create(user_id: 1, file_url:"espn.com")
# Genome.create(user_id: 2, file_url:"espn.com")


# $redis.hset("#{@user1.username}", "rs50", "CC") #yes
# $redis.hset("#{@user2.username}", "rs51", "AT")
# $redis.hset("#{@user1.username}", "rs20", "AG")
# $redis.hset("#{@user2.username}", "rs21", "TT ")
# $redis.hset("#{@user1.username}", "rs51", "AT") #yes
# $redis.hset("#{@user2.username}", "rs51", "AT")
# $redis.hset("#{@user1.username}", "rs21", "GG") #yes
# $redis.hset("#{@user2.username}", "rs21", "TT ")


# Report.create(genome_id: 1)

# Marker.all.each do |marker|
# 	if $redis.hget("#{@user1.username}", marker.snp) == marker.allele
# 		Risk.create(report_id: @user1.reports.last.id, marker_id: marker.id)
# 	end
# end

# $redis.del("#{@user1.username}")


