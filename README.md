# Hubot Mind Meld

Ruby script to collapse Hubot's `robot.brain.users` into a single object, keyed by username.

# Usage

```bash
bundle install --path=vendor/bundle
bundle exec ruby mind-meld.json
```

The current brain is saved in this directory as a timestamped JSON file for safe keeping.

# Why?

The `hubot-irc` adapter at one point had keyed them by first-seen timestamp, but then switched later to using their username. The result is having more than one record with the same `name` property, breaThis script takes the contents of the Redis (or other) brain as a JSON file and transitions the data into the new expected format.

Note if you are using Slack or some other adapter, this script is likely not a good fit. It purposefully overrides the `id` parameter as well to match the screen name.
