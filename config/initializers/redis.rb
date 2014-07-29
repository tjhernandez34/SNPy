if ENV["REDISCLOUD_URL"]
	$redis = Redis.new(:url => ENV["REDISCLOUD_URL"])
end
$redis = Redis.new(:host => 'localhost', :port => 6379)



# redis://rediscloud:LjDZwhZSysSY3vWK@pub-redis-17077.us-east-1-1.2.ec2.garantiadata.com:17077
