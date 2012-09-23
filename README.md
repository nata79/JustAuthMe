# SimplyAuth

SimplyAuth is a gem to manage authorization in the simplest way possible. Most times you just want to check if an object belongs to the current user, SimplyAuth does just that withou any configuration.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'simple_auth'
```

## Usage

SimplyAuth needs a method called 'current_user' that will return the user currently logged in.

If you just want to simply want to authorize a resource, add this line to that resource controller:

```ruby
simple_auth Resource
```

If your resource is nested under other resource you can authorize it through the parent resource by passing the 'through' option like this:

```ruby
simple_auth Resource, through: OtherResource
```

Alternatively you can also pass a block to handle the authorization logic:

```ruby	
simple_auth Resource do |r|
  current_user.role == 'admin' and r.user_id == current_user.id
end
```

With a nested resource:

```ruby
simple_auth Resource, through: OtherResource do |r, o|
  current_user.role == 'admin' and o.user_id == current_user.id
end
```

You can also pass 'only' and 'except' options to simple_auth:
	
```ruby
simple_auth Resource, only: [:new, :create, :destroy]
simple_auth Resource, except: [:show]
```

## Development

Questions or problems? Please post them on the [issue tracker](https://github.com/nata79/simple_auth/issues). You can contribute changes by forking the project and submitting a pull request. You can ensure the tests passing by running `bundle` and `rake`.

This gem is created by André Barbosa and is under the MIT License.
