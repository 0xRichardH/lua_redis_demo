require_relative 'redis_client'

puts '=' * 10
puts '-- start --'

$redis.multi do
  5.times do |i|
    article_key = "article:#{i}:comments"
    50.times do |item|
      $redis.zadd(article_key, Time.now.to_f, item)
      comment_key = "comment:id:#{item}"
      comment_hash = { id: item, name: "Bob-#{item}", content: "hello, world ! #{item}号" }
      $redis.hmset([comment_key] + comment_hash.to_a.flatten!)
    end
  end
end

puts '-- end --'
puts '=' * 10
