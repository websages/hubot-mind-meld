require 'date'
require 'json'
require 'redis'

redis = Redis.new
json = redis.get('hubot:storage')

File.open("hubot-storage-#{DateTime.now.strftime('%Y%jT%H%MZ')}.json", 'w') do |f|
  f.write json
  f.close
end

brain = JSON.parse(json)

# Placeholder for new brain objects
users = {}

# Clone brain, clear users field
merged = brain.clone
merged['users'] = users

brain['users'].each do |id, user|
  if merged['users'][user['name']].nil?
    merged['users'][user['name']] = user
  else
    merged['users'][user['name']] = merged['users'][user['name']].merge(user)
  end
  # Set the ID field to match the screen name
  merged['users'][user['name']]['id'] = user['name']
end

redis.set('hubot:storage', merged.to_json)
