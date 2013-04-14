---
title: API v2 - Issues - Flagging as Inappropriate
---

# Issue Flagging

## Vote for an Issue

Issues can be voted on any authenticated user.

    PUT /issues/<issue_id>/vote

### Request

<%=
  json({value: 1})
%>

### Response

<%=
  json({
    metadata: nil,
    result: 'success',
    errors: nil
  })
%>

## Revoke a vote for an Issue

Issues can be voted on any authenticated user.

    PUT /issues/<issue_id>/vote

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