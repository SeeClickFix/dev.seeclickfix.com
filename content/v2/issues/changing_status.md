---
title: API v2 - Issues - Changing Status
---

# Changing the status of an issue

* TOC
{:toc}

Any authenticated user can change the status of an issue from Open to Closed and Closed to Open. Only government employees can change the status from Open to Acknowledged and Acknowledged to Closed. To check if the current user has this permission visit the <a href="/v2/users/#show-current-user">current user</a> page. Issues are Archived after being Closed for 7 days. The status can not change for Archived issues. 

## Close an Issue

Changing the status of an issue is similar to adding a comment on an issue. 
    POST /issues/<issue_id>/close

### Required Parameters

* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl --data "comment=pools+are+nice" -i <%= root_version_url %>/issues/1/close
</pre>

### Response

<%= headers 201 %>
<%= json(moderated: false, created_at: Time.now) %>

## Reopen an Issue

Changing the status of an issue is similar to adding a comment on an issue. 
    POST /issues/<issue_id>/open

### Required Parameters

* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl --data "comment=pools+are+nice" -i <%= root_version_url %>/issues/1/close
</pre>

### Response

<%= headers 201 %>
<%= json(moderated: false, created_at: Time.now) %>

## Acknowledge an Issue

Changing the status of an issue is similar to adding a comment on an issue. 

    POST /issues/<issue_id>/acknowledge

### Required Parameters

* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl --data "comment=pools+are+nice" -i <%= root_version_url %>/issues/1/acknowledge
</pre>

### Response

<%= headers 201 %>
<%= json(moderated: false, created_at: Time.now) %>
