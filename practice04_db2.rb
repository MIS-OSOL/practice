# -*- encoding: utf-8 -*-

# 事業所一覧のCSVファイルを読み込みDBに登録するプログラム

require 'csv'
require 'sqlite3'
require 'rubygems'

# SQLiteでのテーブルの作成用
sql =<<SQL
drop table if exists officecode;
create table officecode (
  id integer primary key,
  office_name varchar(255) not null, 
  code varchar(10) not null,
  pref varchar(10) not null,
  city varchar(255) not null,
  town varchar(255),
  house_number varchar(255),
  post_office_name varchar(255),
  individual varchar(255),
  plural varchar(255)
);
create index office_code_index on officecode(code);
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
    pr = tr.prepare('insert into officecode values(?, ?, ?, ?, ?, ?, ?, ?, ?, ?)')
# ID用count変数    
    @count = 1
# CSV.foreachを用いてCSVファイルを読み込み
    CSV.foreach('JIGYOSYO.CSV', encoding: "Shift_JIS:UTF-8"){|row|
      id = @count;
      office_name = row[2]
      code = row[7];
      pref = row[3];
      city = row[4];
      town = row[5];
      house_number = row[6];
      post_office_name = row[9];
      individual = row[10];
      plural = row[11];
      @count += 1;
      begin
        pr.execute(id, office_name, code, pref, city, town, 
                   house_number, post_office_name, individual, plural)
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
