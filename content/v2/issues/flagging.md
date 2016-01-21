---
title: API v2 - Issues - Flagging an Issue as Inappropriate
---

# Flagging an issue as Inappropriate

Marking an issue as inappropriate alerts our moderators of the content. Flagging can happen on issues or comments. Content can not be unflagged until our moderators look at it.

## Flagging an Issue

Issues can be flagged by any authenticated user.

    POST /issues/<issue_id>/flag

### Request

<%=
  json({message: 'Using profanity.'})
%>

### Response

<%=
  json(flagged: 1)
%>

## Flagging a Comment

Comments can be flagged by any authenticated user.

    POST /comments/<comment_id>/flag

### Request

<%=
  json({message: 'Using profanity.'})
%>

### Response

<%=
  json(flagged: 1)
%>
