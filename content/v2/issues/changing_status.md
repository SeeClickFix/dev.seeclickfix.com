---
title: API v2 - Issues - Changing Status
---

# Changing the status of issues

Any authenticated user can change the status of an issue from Open to Closed and Closed to Open. Only government employees can change the status from Open to Acknowledged and Acknowledged to Closed. Issues are Archived after being Closed for 7 days. The status can not change for Archived issues. 

## Changing the status of an Issue

The status of an issue is similar to adding a comment on an issue. 

    POST /issues/<issue_id>/status

### Required Parameters

* **new_status**=`:status` - The new status of an issue.
* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Request

<%=
  json({
    comment: 'The problem is getting larger.',
    new_status: 'Closed'
  })
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
