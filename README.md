# README (FIXD SOCIAL)

The following is the documentation for FIXD Social.

## Testing

The output of the tests are also a form of documentation for the specifications. You can run the tests like so:

```
rspec .
```
## API

### Users

**To view a user's feed:**

Method: `GET`, URL: `/users/:id` where `:id` is the `id` of the user with the feed you want to view.

Parameters:

If you pass no parameters to the URL, it will fetch the first five posts for that user. The URL accepts two parameters that you can pass it: `limit` and `offset`. `Limit` is the number of posts you want returned and `offset` is nth record you want to start at. 

For example, if you want to view the third set of `10` posts (which starts at `20`) for a particular user with `id` of `5`, you would query this endpoint:

`/users/5?limit=10&offset=20`

### Posts

**To create a post:**

Method: `POST`, URL: `/posts`

Parameters:
```json
{
  post: {
    title: "The title of the post",
    body: "The body of the post",
    user_id: 1 // id of post owner
  }
}
```

**To view a post:**

Method: `GET`, URL: `/posts/:id` where `:id` is the `id` of the post you want to view.

If the post doesn't exist a status of 404 will be returned and response will look like this:

```json
{
  "errors": ["Record not found"]
}
```

### Comments

**To add a comment:**

Method: `POST`, URL: `/comments`

Parameters:
```json
{
  comment: {
    user_id: 1, // id of commenter
    post_id: 1, // id of the post being commented on
    message: "The message of the comment",
  }
}
```

**To remove a comment:**

Method: `DELETE`, URL: `/comments/:id` where `:id` is the `id` of the comment you want to remove.

If the comment doesn't exist a status of 404 will be returned and response will look like this:

```json
{
  "errors": ["Record not found"]
}
```

### Ratings

**To rate a user:**

Method: `POST`, URL: `/ratings`

Parameters:
```json
{
  rating: {
    rater_id: 1, // id of the user who is rating another
    user_id: 1, // id of the user being rated
    rating: 5 // Must be between 1 and 5 (inclusive)
  }
}
```