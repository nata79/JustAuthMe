# JustAuthMe

JustAuthMe is a gem to manage authorization in the simplest way possible. Most times you just want to check if an object belongs to the current user, JustAuthMe does just that without any configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'just_auth_me'
```

## Usage

JustAuthMe needs a method called 'current_user' that will return the user currently logged in.

If you just want to simply want to authorize a resource, add this line to that resource controller:

```ruby
just_auth_me Resource
```

If your resource is nested under other resource you can authorize it through the parent resource by passing the 'through' option like this:

```ruby
just_auth_me Resource, through: OtherResource
```

Alternatively you can also pass a block to handle the authorization logic:

```ruby	
just_auth_me Resource do |r|
  current_user.role == 'admin' and r.user_id == current_user.id
end
```

With a nested resource:

```ruby
just_auth_me Resource, through: OtherResource do |r, o|
  current_user.role == 'admin' and o.user_id == current_user.id
end
```

You can also pass 'only' and 'except' options to just_auth_me:
	
```ruby
just_auth_me Resource, only: [:new, :create, :destroy]
just_auth_me Resource, except: [:show]
```

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/nata79/just_auth_me/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by André Barbosa and is under the MIT License.
