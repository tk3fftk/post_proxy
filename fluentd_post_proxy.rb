# coding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'json'
require 'net/http'
require 'uri'

set :environment, :production

FLUENTD_HOST = 'HOST_ADDR'
FLUENTD_PORT = 'PORTNUM'

post '/create/:tag' do
	json = request.body.read

	# POSTする準備
	tag = params[:tag]
	URL = "http://#{FLUENTD_HOST}:#{FLUENTD_PORT}/#{tag}"
	uri = URI.parse(URL)
	req = Net::HTTP::Post.new(uri.request_uri)
	# リクエストヘッダの編集
	req["Content-Type"] = "application/json"
	# リクエストボデーのセット
	req.body = json
	
	http = Net::HTTP.new(uri.host, uri.port)
	res = http.request(req)
end

get '/test/:tag' do
	json = {:userid => 'user'}.to_json

	# POSTする準備
	tag = params[:tag]
	uri = URI.parse(URL)
	req = Net::HTTP::Post.new(uri.request_uri)
	# リクエストヘッダの編集
	req["Content-Type"] = "application/json"
	# リクエストボデーのセット
	req.body = json
	
	http = Net::HTTP.new(uri.host, uri.port)
	http.set_debug_output $stderr
	res = http.request(req)
end
