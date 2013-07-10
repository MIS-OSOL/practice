# -*- encoding: utf-8 -*-

# 郵便番号一覧のCSVファイルを読み込み、DBに登録するプログラム

require 'csv'
require 'sqlite3'
require 'rubygems'

# 「以下に～」がある場合の判定用正規表現リテラル
DELETE_PART = /^以下に.+/

# SQLiteでのテーブルの作成用
sql =<<SQL
drop table if exists zipcode;
create table zipcode (
  id integer primary key,
  code varchar(10) not null,
  pref varchar(10) not null,
  city varchar(255) not null,
  town varchar(255)
);
create index code_index on zipcode(code);
SQL

# ファイルのオープン用
begin
  db = SQLite3::Database.new("zipcodes.db")
# 上記読み込みでSQLのテーブル・インデックス作成
  db.execute_batch(sql) 
  puts "New file is created."
# トランザクション処理
  db.transaction {|tr|
# プリペアドステートメントを使用しInsert 
    pr = tr.prepare('insert into zipcode values(?, ?, ?, ?, ?)')
# ID用count変数    
    @count = 1
# CSV.foreachを用いてCSVファイルを読み込み
    CSV.foreach('KEN_ALL.CSV', encoding: "Shift_JIS:UTF-8"){|row|
      id = @count;
      code = row[2];
      pref = row[6];
      city = row[7];
# 正規表現を使用し「以下の～」を削除
      town = row[8].sub(DELETE_PART, '')
      @count += 1;
      begin
        pr.execute(id, code, pref, city, town)
      rescue SQLite3::SQLException => e
        puts e #=> table SQLException already exists
        exit(1)
      end
    }
    pr.close
  }
  rescue Exception => e
    puts e #=> table Exception already exists
    exit(1)
end
db.close

# 正常終了した場合完了表示
puts 'records success'
