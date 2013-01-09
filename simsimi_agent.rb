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
  
  attr_accessor :rescue_reply
  attr_reader :id

	def initialize(rescue_reply = "呵呵~")
    @rescue_reply = rescue_reply
    @id = Digest::SHA1.hexdigest('')[0..7]

    @client = HTTPClient.new
    @client.set_cookie_store("cookie_#{@id}.dat")
    
    touch_talk_page
	end

  def chat(dialog)
    begin
      result = JSON.parse @client.get(query_url(dialog), nil, HEADER).content
      result["response"]
    rescue Exception
      @rescue_reply
    end
  end

  private
    def touch_talk_page
      @client.get TALK_URL
    end

    def query_url(dialog)
      "#{POST_URL}#{dialog}"
    end
end
