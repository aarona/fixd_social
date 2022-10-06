# README (FIXD SOCIAL)

The following is the documentation for FIXD Social.

## Testing

The output of the tests are also a form of documentation for the specifications. You can run the tests like so:

```
rspec .
```
## API

### Users

### Posts

**To create a post:**

Method: `POST`

URL: `/posts`

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

Method: `GET`

URL: `/posts/:id` where `:id` is the `id` of the post you want to view.

### Comments

**To add a comment:**

Method: `POST`

URL: `/comments`

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

Method: `DELETE`

URL: `/comments/:id` where `:id` is the `id` of the comment you want to remove.
