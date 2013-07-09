# -*- encoding: utf-8 -*-

# 事業所名称を部分一致で検索し、対応する情報をを表示するプログラム

require 'sqlite3'
require 'rubygems'

puts "検索したい事業所名称を部分一致で入力してください"
name = gets.chop

begin
# データベース接続    
  db = SQLite3::Database.new("zipcodes.db")
  sql = "select * from officecode where office_name like '%#{name}%' order by id"
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
