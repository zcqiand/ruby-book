rails generate scaffold User name:string email:string password_digest:string
rails generate scaffold Post content:text user:references
rails generate scaffold Comment content:text post:references user:references
rails generate migration CreateFriendships "follower:references followed:references"