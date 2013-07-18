require "sqlite3"

sql =<<SQL
  drop table if exists users;
  drop table if exists followers;
  drop table if exists friends;
  drop table if exists timelines;
  create table users (
    id integer primary key,
    name text,
    screen_name text,
    location text,
    description text,
    status_count integer,
    followers_count integer,
    friends_count integer
  );
  create table followers (
    id integer,
    name text,
    screen_name text
  );
  create table friends (
    id integer,
    name text,
    screen_name text
  );
  create table timelines (
    id integer,
    from_user text,
    tweet text,
    created_at text
  );  
SQL

puts "drop/create table?(y/other)"
confirmation = gets.chop
if(confirmation == "y")
  puts "Are you sure ?(y/other)"
  confirmation2 = gets.chop
  if(confirmation == "y")
    db = SQLite3::Database.new("twitters.db")
# 上記読み込みでSQLのテーブル・インデックス作成  
    db.execute_batch(sql)   
    puts "New file is created."
  else
    puts "other"
  end
else
  puts "other" 
end
