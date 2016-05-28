-- get-comment-by-article_id

local rep = {}
local comment_ids_table = redis.call('ZREVRANGEBYSCORE', KEYS[1], ARGV[1], ARGV[2], 'LIMIT', 0, ARGV[3] )
for i, v in pairs(comment_ids_table) do
  local comment_key = string.format("comment:id:%d", v)
  table.insert(rep,redis.call('hgetall', comment_key))
end
return rep
