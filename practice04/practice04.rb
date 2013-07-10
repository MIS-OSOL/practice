# -*- encoding: utf-8 -*-

# 課題5プログラム
# 機能a)郵便番号のDB登録 機能b)郵便番号の前方一致検索 機能c)事業所の部分一致検索（DB登録）

puts "郵便番号プログラム" 

loop do
  puts "1:郵便番号DB登録, 2:事業所DB登録, 3:郵便番号検索, 4:事業所検索, 0:終了"
  puts "数値を入力してください"
  num = gets.chop
  unless num =~ /\D/ 
    case num
      when '0' then
        puts "プログラムを終了します"
        break
      when '1' then
        puts "郵便番号登録プログラムを呼び出します"
        load("practice04_db1.rb")
      when '2' then
        puts "事業所登録プログラムを呼び出します"
        load('./practice04_db2.rb')
      when '3' then
        puts "郵便番号検索プログラムを呼び出します"
        load('./practice04_function_b.rb')
      when '4' then
        puts "事業所検索プログラムを呼び出します"
        load('./practice04_function_c.rb')
      else
        puts "存在しません"
  end
  else  
    puts "数値以外は入力しないでください"
  end
end
