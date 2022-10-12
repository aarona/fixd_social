# README (FIXD SOCIAL)

The following is the documentation for FIXD Social.

## Table of Contents
* [Environment Setup](#environment-setup)
* [Testing](#testing)
* [API](#api)
  * [Users](#users)
  * [Posts](#posts)
  * [Comments](#comments)
  * [Ratings](#ratings)
* [GitHub API](#github-api)

## Environment Setup

To set up the database, run this command:

```
rake db:setup
```

This will create and migrate the database and then seed it with test data.

## Testing

The output of the tests are also a form of documentation for the specifications. You can run the tests like so:

```
rspec .
```

## API

### Users

**To view a user's feed:**

Method:

`GET /users/:id`

where `:id` is the id of the user with the feed you want to view.

**Parameters:**

If you pass no parameters to the URL, it will fetch the first five posts for that user. The URL accepts two parameters that you can pass it: `limit` and `offset`. `Limit` is the number of posts you want returned and `offset` is nth record you want to start at. If `limit` is not passed, it is defaulted to `0`. Likewis, if `offset` is not passed, it is defaulted to `5`.

For example, if you want to view the third set of `10` posts (which starts at `20`) for a particular user with id of `5`, you would query this endpoint:

`GET /users/5?limit=10&offset=20`

**Response format example:**

```json
{
  "posts": [
    {
      "id": 325,
      "type": "Post",
      "user_id": 11,
      "title": "Incidunt amet est perferendis",
      "body": "Qui vitae tenetur. Quisquam autem fugit. Qui dolore aspernatur.",
      "comment_count": 4,
      "posted_at": "2022-10-11T23:12:13.046Z"
    },
    {
      "id": 326,
      "type": "PullRequestEvent",
      "user_id": 11,
      "event_id": 24508326313,
      "number": 1,
      "repo": "aarona/fixd_social",
      "action": "opened",
      "posted_at": "2022-10-11T18:38:08.000Z"
    },
    {
      "id": 327,
      "type": "RatingChange",
      "user_id": 10,
      "rating_threshold": 4,
      "average_rating": 4.5,
      "posted_at": "2022-10-11T01:52:27.657Z"
    },
    {
      "id": 328,
      "type": "CreateEvent",
      "user_id": 11,
      "event_id": 24508312792,
      "repo": "aarona/fixd_social",
      "posted_at": "2022-10-10T18:37:16.000Z"
    },
    {
      "id": 329,
      "type": "PushEvent",
      "user_id": 11,
      "event_id": 24482576663,
      "commits": 1,
      "repo": "aarona/fixd_social",
      "branch": "refs/heads/master",
      "posted_at": "2022-10-09T02:26:26.000Z"
    }
  ]
}
```

If any of the parameters sent are invalid (`offset` and `limit` must be integer values), you receive a response like this:

```json
{
    "errors": [
        "An error occured"
    ]
}
```

### Posts

**To create a post:**

Method:

`POST /posts`

**Parameters:**

`user_id` is the id of post owner.

`title` is the title of the post.

`body` is the body of the post.

All parameters are required.

**Parameter format example:**

```json
{
  "post": {
    "user_id": 1,
    "title": "The title of the post",
    "body": "The body of the post"
  }
}
```

**Response format example:**

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

If the values sent are invalid you will receive an error object as json in the response similar to this:

```json
{
  "errors": [
    "User must exist",
    "Title can't be blank",
    "Body can't be blank"
  ]
}
```

**To view a post:**

Method:

`GET /posts/:id`

where `:id` is the id of the post you want to view.

**Response format example**:

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

Method:

`POST /comments`

**Parameters:**

`user_id` is the id of commenter.

`post_id` is the id of the post bing commented on.

`message` is the message of the comment.

All parameters are required.

**Parameter format example:**

```json
{
  "comment": {
    "user_id": 1,
    "post_id": 1,
    "message": "The message of the comment",
  }
}
```

**Response format example:**

```json
{
  "id": 1,
  "user_id": 1,
  "post_id": 1,
  "message": "The message of the comment",
  "commented_at": "2022-10-09T01:43:09.221Z"
}
```

If the values sent are invalid you will receive an error object as json in the response similar to this:

```json
{
  "errors": [
    "User must exist",
    "Message can't be blank"
  ]
}
```

**To remove a comment:**

Method:

`DELETE /comments/:id`

where `:id` is the `id` of the comment you want to remove. If the comment doesn't exist a status of 404 will be returned and response will look like this:

```json
{
  "errors": ["Record not found"]
}
```

### Ratings

**To rate a user:**

Method:

`POST /ratings`

**Parameters:**

`rater_id` is the id of user making the rating.

`user_id` is the id of usr being rated.

`rating` is the rating. Must be between 1 and 5 (inclusive).

All parameters are required.

**Parameter format example:**

```json
{
  "rating": {
    "rater_id": 1,
    "user_id": 1,
    "rating": 5
  }
}
```

**Response format example:**

```json
{
  "rating": {
    "id": 3,
    "user_id": 2,
    "rater_id": 1,
    "rating": 5,
    "rated_at": "2022-10-09T01:57:21.647Z"
  }
}
```

If the values sent are invalid you will receive an error object as json in the response similar to this:

```json
{
  "errors": [
    "Rater must exist",
    "Rating must be greater than or equal to 1"
  ]
}
```

## GitHub API

To simulate a separate process for pulling down GitHub events, I've set up a rake task to do this. The task takes one or more GitHub user names and as long as a user in the database has that GitHub  user name associated with, it will attempt to process the last 90 days of events. To run the task, you can run this command:

```
rake github_events:import user1 [user2, user3 etc]
```

A quick way to add a user to the system with a github profile associated with the account is to run the following command in `rails console` like so:

```ruby
FactoryBot.create(:user, github_username: "myusername" )
```

and then proceed to import the records using the rake task mentioned above.