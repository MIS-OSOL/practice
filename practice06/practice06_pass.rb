# -*- encoding: utf-8 -*-
require 'base64'

puts "base64を使い暗号化"
print "パスワード = "
pass = gets.chop

encryption = Base64.encode64(pass)
puts "暗号化 = #{encryption}"
