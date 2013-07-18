require 'rubygems'
  gem 'json', '~> 1.7.7'
require 'twitter'
require 'pp'
require 'sqlite3'

# BREAK_COUNT = フォロー・フォロワーの取得したい値
# 以下はAPI取得用のキー
BREAK_COUNT = 5
CONSUMER_KEY = 'FFhWK7URx8wAxlJBps81eQ'
CONSUMER_SECRET = 'QrefrWTzwXNNaeZzVQfkxiLM0bBmMkpz7ds6MAm0z6k'
OAUTH_TOKEN = '1585069392-mjPdkojcRi1Q4rgSRyt901gWQgPbOKi0lcUzwh5'
OAUTH_TOKEN_SECRET = 'GLHnkUukZqE2ooiEou0m2WYzPuGjDzloPvpqQi7A9G8'

# キーを用いツイッタークライアントへ接続
client = Twitter::Client.new(
  :consumer_key => CONSUMER_KEY,
  :consumer_secret => CONSUMER_SECRET,
  :oauth_token => OAUTH_TOKEN,
  :oauth_token_secret => OAUTH_TOKEN_SECRET
)

begin
# SQLiteへ接続（Insert処理）
  db = SQLite3::Database.new("twitters.db")
# ツイッターのユーザ名登録
  puts "prease input name ?"
  input_name = gets.chop 
  user_name = input_name
  decision = client.user?(user_name)
  unless decision
    puts "user cannot be found in the twitter"
    exit(0)
  end
# ツイッターからユーザメソッドを呼び出しユーザ情報取得
  twituser = client.user(user_name)
# ユーザ情報の切り分け
  id = twituser[:id]
  name = twituser[:name]
  screen_name = twituser[:screen_name]
  location = twituser[:location]
  description = twituser[:description]
  status_count = twituser[:statuses_count]
  followers_count = twituser[:followers_count]
  friends_count =  twituser[:friends_count]

# ユーザ情報の存在確認
  ids = db.execute('select * from users where id = ?', "#{id}")
  if ids.length > 0
    old_followers = []
    old_friends = []
    db.transaction do
      puts "-----update_mode-----"
      old_followers = db.execute('select name, screen_name from followers')
      old_friends = db.execute('select name, screen_name from friends')
      db.execute('delete from users where id = ?', "#{id}")
      db.execute('delete from followers where id = ?', "#{id}")
      db.execute('delete from friends where id = ?', "#{id}")
      db.execute('delete from timelines where id = ?', "#{id}")
    end
  else
    puts "-----insert_mode-----"
  end
  
# ユーザ情報
  pr = db.prepare('insert into users values(?, ?, ?, ?, ?, ?, ?, ?)')
  begin      
    pr.execute(id, name, screen_name, location, description,
               status_count, followers_count, friends_count)
  rescue SQLite3::SQLException => e       
    puts e #=> table SQLException already exists
    exit(1)
  end
  pr.close

# フォロワー
  follower_ids = []
  break_count = 0
  client.follower_ids(user_name).each do |id|
    break_count += 1
    follower_ids.push(id)
    break if break_count >= BREAK_COUNT
  end

  puts "-----follower-----"
  pr = db.prepare('insert into followers values(?, ?, ?)')
  follower_ids.each do |count|
    follower_id = id
    follower_name = client.user(count)["name"]
    follower_screen_name = "@#{client.user(count)["screen_name"]}"
    print"*"
    begin
      pr.execute(follower_id, follower_name, follower_screen_name)
    rescue SQLite3::SQLException => e        
      puts e #=> table SQLException already exists        
      exit(1)    
    end
  end
  puts ""
  pr.close

# フォロー
  break_count = 0
  friend_ids = []
  client.friend_ids(user_name).each do |id|
    break_count += 1
    friend_ids.push(id)
    break if break_count >= BREAK_COUNT
  end

  puts "-----friend-----"
  pr = db.prepare('insert into friends values(?, ?, ?)')
  friend_ids.each do |count|
    friends_id = id
    friends_name = client.user(count)["name"]
    friends_screen_name = "@#{client.user(count)["screen_name"]}"
    print "*"
    begin
      pr.execute(friends_id, friends_name, friends_screen_name)
    rescue SQLite3::SQLException => e
      puts e #=> table SQLException already exists
      exit(1)
    end
  end
  puts ""
  pr.close

# タイムライン
  break_count = 0
  timelines = []
  client.user_timeline(user_name).each do |res|
    break_count += 1
    timelines.push(res)
    break if break_count >= BREAK_COUNT
  end

  puts "-----timeline-----"
  pr = db.prepare('insert into timelines values(?, ?, ?, ?)')
  timelines.each do |count|
    timeline_id = id
    timeline_name = count.from_user
    timeline_text = count.text
    timeline_created = count.created_at.to_s
    begin
      pr.execute(timeline_id, timeline_name, timeline_text, timeline_created)
    rescue SQLite3::SQLException => e
      puts e #=> table SQLException already exists
      exit(1)
    end 
  end
  pr.close

  puts "-----user-----"
  puts "id : #{id}"
  puts "name : #{name}"
  puts "screen_name : #{screen_name}"
  puts "location : #{location}"
  puts "description : #{description}"
  puts "tweet_count : #{status_count}"
  puts "followers : #{followers_count}"
  puts "friends : #{friends_count}"

  puts "-----new five acount-----"
  followers = db.execute("select name, screen_name from followers where id = ?", "#{id}")
  friends = db.execute("select name, screen_name from friends where id = ?", "#{id}")
 
  puts "[followers]"
  followers.each do |name, s_name|
    puts "#{name} #{s_name}"
  end
  puts "[friends]"
  friends.each do |name, s_name|
    puts "#{name} #{s_name}"
  end
 
  if ids.length > 0
    puts "-----diff five acount-----"
    diff_followers = followers - old_followers
    diff_friends = friends - old_friends

    puts "[diff_followers]"
    diff_followers.each do |name, s_name|
      puts "#{name} #{s_name}"
    end
    puts "[diff_friends]"
    diff_friends.each do |name, s_name|
      puts "#{name} #{s_name}"
    end 
  end

  puts "-----timelines-----"
  timelines = db.execute("select from_user, tweet, created_at
                          from timelines where id = ?", "#{id}")
  timelines.each do |user, tweet, create|
    puts "#{user} : #{tweet} (#{create})" 
  end

  db.close
end
