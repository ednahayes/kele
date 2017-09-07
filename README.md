# Kele API Client

### REST API Client

API Client Gem built to access [Bloc's REST API](http://docs.blocapi.apiary.io/#)

## Project Objectives

- Kele retrieves and stores an authentication token when passed valid credentials
- Students can retrieve their info as a JSON blog
- Students can retrieve a list of their mentor's availability
- Students can retrieve roadmaps and checkpoints
- Students can retrieve a list of their messages, respond to an existing message, and create a new message thread
- Students can submit checkpoint assignments

## Built With

- Ruby 2.3.3
- HTTParty Gem
- JSON Gem

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'kele'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install kele

## Usage
**The client can be used as follows, (Populated with your Bloc.io email and password to access the API. 
):**

```ruby
$ irb
>> require './lib/kele'
=> true
>> Kele.new("jane@gmail.com", "abc123")
```
**To retrieve a parsed ruby hash of your Bloc.io account information then run:** 

```ruby
$ kele_client.get_me
```

**To retrieve your mentor's current availability:**

```ruby
$ kele_client.get_mentor_availability(mentor_id)
```
**To retrieve your Bloc.io roadmap:** 

```ruby
$ kele_client.get_roadmap(roadmap_id)
```

**To retrieve information on a particular checkpoint:** 
```ruby
$ kele_client.get_checkpoint(checkpoint_id)
```
**To retrieve your messages:**

```ruby
$ kele_client.get_messages(1) # returns the first page of message threads
$ kele_client.get_messages # returns all message threads
```

**To send a message:** 

```ruby
$ kele.client.create_message(sender, recipient_id, token, subject, text)
```

**To submit a checkpoint:**
```angular2html
$ kele_client.create_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
```

**To update a checkpoint**
```angular2html
$ kele_client.update_submission(checkpoint_id, assignment_branch, assignment_commit_link, comment)
```


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/ednahayes/kele.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
