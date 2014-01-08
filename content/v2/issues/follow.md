---
title: API v2 - Issues - Follow
---

# Issue Following

To check wether the current user is following an issue see the attribute `current_user_relationship` on the issue show or issue list actions. 

## Follow an Issue

Issues can be followed by any authenticated user. After following an issue, the user will receive updates via email. Trying to follow the same issue twice will return an error.

    POST /issues/<issue_id>/follow

### Request

No values are required in the body of the request.

### Response

<%= headers 201 %>
<%= json(follow: 1) %>

Returns 1 if the follow was succesful.

## Stop following an issue

Following an issue can be stopped by an authenticated user if the user is following the issue. 

    DELETE /issues/<issue_id>/follow

### Request

No values are required in the body of the request.

### Response

<%= headers 204 %>
<pre class="highlight"><code>
BODY INTENTIONALLY BLANK
</code></pre>
