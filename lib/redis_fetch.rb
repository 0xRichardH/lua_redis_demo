require_relative 'redis_client'

module RedisRb
  class RedisFetch

    def self.get_comment_by_article(article_id, last_time, per_page = 10)
      comment_hash = []
      comment_ids = $redis.zrevrangebyscore("article:#{article_id}:comments", last_time, 0, limit: [0, per_page])
      comment_ids.each do |item|
        comment_hash << $redis.hgetall("comment:id:#{item}")
      end

      return comment_hash
    end

  end
end
