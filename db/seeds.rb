disease1 = Disease.create(name: "heart_disease")
disease2 = Disease.create(name: "cancer")
disease3 = Disease.create(name: "diabetes")


marker1 = Marker.create(rsid: "rs50", snp: "CC", disease_id: "1")
marker2 = Marker.create(rsid: "rs50", snp: "AT", disease_id: "1")
marker3 = Marker.create(rsid: "rs50", snp: "GG", disease_id: "1")

marker4 = Marker.create(rsid: "rs51", snp: "CC", disease_id: "1")
marker5 = Marker.create(rsid: "rs51", snp: "AT", disease_id: "1")
marker6 = Marker.create(rsid: "rs51", snp: "GG", disease_id: "1")

marker7 = Marker.create(rsid: "rs20", snp: "CC", disease_id: "2")
marker8 = Marker.create(rsid: "rs20", snp: "AA", disease_id: "2")
marker9 = Marker.create(rsid: "rs20", snp: "GT", disease_id: "3")
marker10 = Marker.create(rsid: "rs20", snp: "CG", disease_id: "2")

marker11 = Marker.create(rsid: "rs21", snp: "CC", disease_id: "3")
marker12 = Marker.create(rsid: "rs21", snp: "GG", disease_id: "3")
marker13 = Marker.create(rsid: "rs21", snp: "AT", disease_id: "3")
marker14 = Marker.create(rsid: "rs21", snp: "AA", disease_id: "1")

10.times do 
	Risk.create(genome_id: 1, marker_id: rand(1..14))
end

Genome.create(user_id: 1, file_url:"espn.com")

User.create(first_name: "Jerry", last_name: "Berry", email: "jb@email.com", password_digest: "password")
