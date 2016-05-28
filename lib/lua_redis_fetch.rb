require_relative 'redis_client'
require 'digest/sha1'

module Lua
  class LuaRedisFetch

    def self.get_comment_by_article(article_id, last_time, per_page = 10)
      # 获取Lua脚本
      lua_script = nil
      File.open("lib/get-article-by-post.lua") do |file|
        lua_script = file.read()
      end
      script_sha1 = Digest::SHA1.hexdigest(lua_script)
      keys = [ "article:#{article_id}:comments" ]
      args = [ last_time, 0, per_page ]

      # 执行redis.eval
      comment_list = []
      begin
         comment_list = $redis.evalsha(script_sha1, keys, args)
      rescue => e
        if e.message.match(/NOSCRIPT/)
           comment_list = $redis.eval(lua_script, keys, args)
        else
          raise
        end
      end

      # 处理查询结果
      comment_hash = []
      comment_list.each do |item|
         comment_hash << Hash[*item]
      end

      return comment_hash
    end

  end
end
