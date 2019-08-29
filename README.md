# Hubot Mind Meld

Ruby script to collapse Hubot's `robot.brain.users` into a single object, keyed by username.

# Why?

The `hubot-irc` adapter at one point had keyed them by first-seen timestamp, but then switched later to using their username. The result is having more than one record with the same `name` property, breaThis script takes the contents of the Redis (or other) brain as a JSON file and transitions the data into the new expected format.
