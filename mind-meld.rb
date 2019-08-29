require 'json'

brain = JSON.parse(File.open('./hubot-storage.json', 'r').read)

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
end

merged['users'].each do |id, user|
  puts id
  puts user.inspect
end

File.open('./hubot-storage-fixed.json', 'w') do |f|
  f.puts merged.to_json
  f.close
end
