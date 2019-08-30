require 'date'
require 'json'
require 'redis'

timestamp = DateTime.now.strftime('%Y%jT%H%MZ')

redis = Redis.new
json = redis.get('hubot:storage')

File.open("hubot-storage-#{DateTime.now.strftime('%Y%jT%H%MZ')}.json", 'w') do |f|
  f.write json
  f.close
end

brain = JSON.parse(json)

# Placeholder for new brain objects
users = {}

# Copy brain, clear users field
merged = brain.dup
merged['users'] = users

brain['users'].each do |id, user|
  if merged['users'].key?(user['name'])
    merged['users'][user['name']] = merged['users'][user['name']].merge(user)
  else
    merged['users'][user['name']] = user
  end

  # Set the ID field to match the screen name
  merged['users'][user['name']]['id'] = user['name']
end

File.open("hubot-storage-merged-#{timestamp}.json", 'w') do |f|
  f.write merged.to_json
  f.close
end

puts redis.set('hubot:storage', merged.to_json)
