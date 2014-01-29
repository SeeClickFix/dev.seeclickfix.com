---
title: API v2 - Issues - Comments
---

# Issue Comments

* TOC
{:toc}

## Commenting on an Issue

Issues can be commented on any authenticated user.

    POST /issues/<issue_id>/comments

### Required Parameters

* **comment**=`:comment` - The user generated comment.
* **logged in** - A user must be logged in to create a comment.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb. Must be png, jpeg, or gif format.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.
* **device_id** - A unique identifier for the device creating the comment. This can help us debug problems.

### Example

<pre class="terminal">
$ curl -i \
       --header "Content-Type: application/json" \
       --data '{"comment": "Pothole getting larger every day"}' \
       <%= root_version_url %>/issues/1/comments
</pre>

### Response

<%= headers 201 %>
<%= json(moderated: false, created_at: Time.now) %>

### Example, with media

If you want to attach a image or video or both to your comment, you must use multipart form data not json. Here is an example including both:

<pre class="terminal">
$ curl -i \
       --header "Content-Type: multipart/form-data" \
       --data "comment=pools+are+nice" \
       --data "image=@photo.png" \
       --data "video=@video.mp4" \
       <%= root_version_url %>/issues/1/comments
</pre>

### Response

<%= headers 201 %>
<%= json(moderated: false, created_at: Time.now) %>

## Listing Comments on an Issue

Returns a collection of comment on the specified issue.

    GET /issues/<issue_id>/comments

### Order

Ordered by created date.

### Example

<pre class="terminal">
$ curl -i <%= root_version_url %>/issues/1/comments
</pre>


### Response

<%= headers 200 %>
<%=
  json(:issue_comment) do |comment|
    { metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      comments: [comment],
      errors: {}
    }
  end
%>

### If for any reason we decide to hold the comment in moderation

We will finish processing the request at a later date.

<%= headers 202 %>
<%= json({ metadata: { moderated: true } }) %>

