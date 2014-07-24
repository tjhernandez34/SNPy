disease1 = Disease.create(name: "heart_disease")
disease2 = Disease.create(name: "cancer")
disease3 = Disease.create(name: "diabetes")


marker1 = Marker.create(snp: "rs50", allele: "CC", disease_id: "1")
marker2 = Marker.create(snp: "rs50", allele: "AT", disease_id: "1")
marker3 = Marker.create(snp: "rs50", allele: "GG", disease_id: "1")

marker4 = Marker.create(snp: "rs51", allele: "CC", disease_id: "1")
marker5 = Marker.create(snp: "rs51", allele: "AT", disease_id: "1")
marker6 = Marker.create(snp: "rs51", allele: "GG", disease_id: "1")

marker7 = Marker.create(snp: "rs20", allele: "CC", disease_id: "2")
marker8 = Marker.create(snp: "rs20", allele: "AA", disease_id: "2")
marker9 = Marker.create(snp: "rs20", allele: "GT", disease_id: "3")
marker10 = Marker.create(snp: "rs20", allele: "CG", disease_id: "2")

marker11 = Marker.create(snp: "rs21", allele: "CC", disease_id: "3")
marker12 = Marker.create(snp: "rs21", allele: "GG", disease_id: "3")
marker13 = Marker.create(snp: "rs21", allele: "AT", disease_id: "3")
marker14 = Marker.create(snp: "rs21", allele: "AA", disease_id: "1")



# 10.times do
# 	Risk.create(genome_id: 1, marker_id: rand(1..14))
# end


@user1 = User.create(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", username: "jerry", password_digest: "password")
@user2 = User.create(first_name: "John", last_name: "Smith", email: "js@email.com", username: "john", password_digest: "password")

Genome.create(user_id: 1, file_url:"espn.com")
Genome.create(user_id: 2, file_url:"espn.com")

# Marker.all do |marker|
#   $redis.set("#{@user1.username}", marker.rsid, marker.snp)
# end

$redis.hset("#{@user1.username}", "rs50", "CC") #yes
$redis.hset("#{@user2.username}", "rs51", "AT")
$redis.hset("#{@user1.username}", "rs20", "AG")
$redis.hset("#{@user2.username}", "rs21", "TT ")
$redis.hset("#{@user1.username}", "rs51", "AT") #yes
$redis.hset("#{@user2.username}", "rs51", "AT")
$redis.hset("#{@user1.username}", "rs21", "GG") #yes
$redis.hset("#{@user2.username}", "rs21", "TT ")


# $redis.set("#{@user2.username}rs51", "AT")
# $redis.set("#{@user1.username}rs20", "AG")
# $redis.set("#{@user2.username}rs21", "TT")


Marker.all.each do |marker|
	if $redis.hget("#{@user1.username}", marker.snp) == marker.allele
		Risk.create(genome_id: @user1.genome.id, marker_id: marker.id)
	end
end

$redis.del("#{@user1.username}")


