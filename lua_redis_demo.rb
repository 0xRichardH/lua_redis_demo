require 'benchmark'
require_relative 'lib/lua_redis_fetch'
require_relative 'lib/redis_fetch'

puts "#{'#' * 10} -- benchmark -- #{'#' * 10}"

lua_redis_time = Benchmark.realtime do
  Lua::LuaRedisFetch.get_comment_by_article(1, Time.now.to_f)
end

puts "lua fetch: #{lua_redis_time}"


redis_time = Benchmark.realtime do
  RedisRb::RedisFetch.get_comment_by_article(1, Time.now.to_f)
end

puts "redis fetch: #{redis_time}"

