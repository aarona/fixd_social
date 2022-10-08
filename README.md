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

Response format example:

```json
{
  "posts": [
    {
      "id": 2,
      "user_id": 1,
      "title": "Post Title 1",
      "body": "The body of the post",
      "posted_at": "2022-10-06T13:37:28.086Z",
      "comment_count": 2
    },
    {
      "id": 3,
      "user_id": 1,
      "title": "Post Title 2",
      "body": "The body of the post",
      "posted_at": "2022-10-07T23:35:55.391Z",
      "comment_count": 0
    }
  ]
}
```

### Posts

**To create a post:**

Method: `POST`, URL: `/posts`

Parameter format example:
```json
{
  post: {
    title: "The title of the post",
    body: "The body of the post",
    user_id: 1 // id of post owner
  }
}
```

Response format example:
```json
{
  "post": {
    "id": 4,
    "user_id": 1,
    "title": "The title of the post",
    "body": "The body of the post",
    "posted_at": "2022-10-07T23:36:04.702Z"
  }
}
```

**To view a post:**

Method: `GET`, URL: `/posts/:id` where `:id` is the `id` of the post you want to view.

Response format example:

```json
{
  "post": {
    "id": 1,
    "user_id": 1,
    "title": "Post Title",
    "body": "Post Body",
    "posted_at": "2022-10-06T13:37:28.086Z",
    "comments": [
      {
        "comment": {
          "id": 1,
          "user_id": 1,
          "post_id": 1,
          "message": "A comment",
          "commented_at": "2022-10-06T13:38:06.663Z"
        },
        "user": {
          "id": 1,
          "email": "test@example.com",
          "name": "A User Name",
          "github_username": "example",
          "registered_at": "2022-10-05T23:46:38.944Z",
          "average_rating": 1
        }
      }
    ]
  }
}
```

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