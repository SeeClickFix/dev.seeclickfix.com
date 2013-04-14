---
title: API v2 - Issues - Flagging as Inappropriate
---

# Issue Flagging as Inappropriate

Marking an issue as inappropriate alerts our moderators of the content. Flagging can happen on issues or comments.

## Flagging an Issue

Issues can be flagged by any authenticated user.

    PUT /issues/<issue_id>/flag

### Request

<%=
  json({reason: 'Using profanity.'})
%>

### Response

<%=
  json({
    metadata: nil,
    result: 'success',
    errors: nil
  })
%>
