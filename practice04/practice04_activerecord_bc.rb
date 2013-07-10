# -*- encoding: utf-8 -*-

# Active Racordを用いたプログラム
# 機能b) 郵便番号一覧を前方一致で検索
# 機能c) 事業所名称情報を部分一致で検索

require 'sqlite3'
require 'rubygems'
require "active_record"

#アクティブレコードを使用し、SQLite3へ接続
ActiveRecord::Base.establish_connection(
  :adapter  => "sqlite3",
  :database => "zipcodes.db"
)

# 郵便番号テーブル読み込み
class Zipcode < ActiveRecord::Base
   self.table_name = 'zipcode'
end

# 事業所テーブル読み込み
class Officecode < ActiveRecord::Base
   self.table_name = 'officecode'
end

# 検索・表示部分のクラス分け
class Display
# 機能b) 郵便番号
  def zip
  puts "検索したい郵便番号を前方一致で入力してください"
  num = gets.chop
    unless num =~ /\D/ 
      codes = Zipcode.find(:all, :conditions=>["code like ?", num + '%'])
      puts "-----"
      codes.each do |code|
        rows = []
        Zipcode.columns.each do |column|
          rows << "#{column.name}: #{code.__send__(column.name)}"
        end
        puts rows.join(", ")
      end
      puts "-----"
    else  
      puts "数値以外は入力しないでください"
    end
  end

# 機能c) 事業所情報
  def office
    puts "検索したい事業所名称を部分一致で入力してください"
    str = gets.chop
    codes = Officecode.find(:all, :conditions=>["office_name like ?", "%#{str}%"])
    puts "-----"
    codes.each do |code|
      rows = []
      Officecode.columns.each do |column|
        rows << "#{code.__send__(column.name)}"
      end
      puts rows.join(", ")
    end
    puts "-----"
  end
end

puts "検索用プログラム"
display = Display.new
loop do
  puts "1: 郵便番号検索, 2:事業所名称検索, 0:終了"
  number = gets.chop
# 数値かどうかの判定
  unless number =~ /\D/
    case number
      when '1' then
        display.zip
      when '2' then
        display.office
      when '0' then
        break
      else
        puts "0～2の数値を入力してください"
     end
  else
    puts "数値以外は入力しないでください"
  end
end 
