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

<%=
  json({
    vote: 1
  })
%>

Returns the new value of the vote for the current_user on the specified issue.

## Revoke a vote for an Issue

Votes can be revoked by any authenticated user only if the user has voted for the issue. It does not vote down an issue. 

    DELETE /issues/<issue_id>/vote

### Request

No values are required in the body of the request.

### Response

<%=
  json({
    vote: 0
  })
%>
