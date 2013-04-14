---
title: API v2 - Issues - Follow
---

# Issue Following

## Follow an Issue

Issues can be followed by any authenticated user.

    PUT /issues/<issue_id>/follow

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

## Revoke following an Issue

Issues can be unfollowed by any authenticated user.

    PUT /issues/<issue_id>/follow

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