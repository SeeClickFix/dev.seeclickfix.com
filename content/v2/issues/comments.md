---
title: API v2 - Issues - Comments
---

# Issue Comments

## Commenting on an Issue

Issues can be commented on any authenticated user.

    POST /issues/<issue_id>/comments

### Required Parameters

* **comment**=`:comment` - The user generated comment.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Request

<%=
  json({comment: 'The problem is getting larger.'})
%>

### Response

<%= headers 201 %>
<%= 
 json({ 
   metadata: [{moderated: false}],
   result: nil,
   errors: nil
 })
%>

## Listing Comments on an Issue

Votes can be revoked by any authenticated user. This removes the user's vote. It does not vote down an issue. 

    GET /issues/<issue_id>/comments

### Request

<%=
  json({value: -1})
%>

### Response

<%=
  json({
    metadata: nil,
    result: 'success',
    errors: nil
  })
%>
