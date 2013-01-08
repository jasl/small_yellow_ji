# encoding: UTF-8
require 'httpclient'
require 'syck'
require 'digest/sha1'
require 'json'

=begin rdoc
原理是利用'httpclient'模拟在'http://www.simsimi.com/talk.htm'上的操作获取结果。
=end
class SimsimiAgent
  TALK_URL = "http://www.simsimi.com/talk.htm?lc=ch"
  POST_URL = "http://www.simsimi.com/func/req?lc=ch&msg="
  HEADER = {"Referer" => TALK_URL}

	def initialize
    @client = HTTPClient.new
    @client.set_cookie_store("cookie_#{Digest::SHA1.hexdigest('')[0..8]}.dat")
    touch_talk_page
	end

  def chat(question)
    result = JSON.parse @client.get(query_url(question), nil, HEADER).content
    result["response"]
  end

  private
    def touch_talk_page
      @client.get TALK_URL
    end

    def query_url(question)
      "#{POST_URL}#{question}"
    end
end

puts SimsimiAgent.new.chat "你是三黄鸡~"
