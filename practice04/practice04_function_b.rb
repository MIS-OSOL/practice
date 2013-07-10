# -*- encoding: utf-8 -*-

# 郵便番号一覧を前方一致で検索するプログラム

require 'sqlite3'
require 'rubygems'

puts "検索したい郵便番号を前方一致で入力してください"
num = gets.chop

# 数値の入力処理
unless num =~ /\D/ 
  begin
# データベース接続    
    db = SQLite3::Database.new("zipcodes.db")
    sql = "select * from zipcode where code like '#{num}%' order by code"
# 表示処理
    puts "-----"
    db.execute(sql) do |row|
      puts row.join(" ")
    end
    puts "-----"
    rescue Exception => e
      puts "エラー"
      exit(1)
   end 
else  
  puts "数値以外は入力しないでください"
end
