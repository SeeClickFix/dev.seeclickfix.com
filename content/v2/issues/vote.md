---
title: API v2 - Issues - Vote
---

# Issue Voting

To check wether the current user has voted for an issue see the attribute `current_user_relationship` on the issue show or issue list actions.  

## Vote for an Issue

Issues can be voted for by any authenticated user. Multiple votes by the same user will be ignored.

    POST /issues/<issue_id>/vote

### Request

No values are required in the body of the request.

### Response

<%= headers 201 %>
<%= json(vote: 1) %>

Returns the new value of the vote for the current_user on the specified issue.

## Revoke a vote for an Issue

Votes can be revoked by an authenticated user if the user has voted for the issue. One can not downvote an issue. 

    DELETE /issues/<issue_id>/vote

### Request

No values are required in the body of the request.

### Response

<%= headers 204 %>
<%= json(vote: 0) %>
