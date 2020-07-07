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
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl -i \
       --header "Content-Type: application/json" \
       --data '{"comment": "Pothole is gone"}' \
       <%= root_version_url %>/issues/1/close
</pre>

### Response

<%= headers 201 %>
<%= json(:issue_closed) %>

### Example, with media

If you want to attach a image to your comment, you must use multipart form data not json.

<pre class="terminal" id="with_media">
$ curl -i \
       --header "Content-Type: multipart/form-data" \
       --data "comment=Pothole+is+gone" \
       --data "image=@photo.png" \
       <%= root_version_url %>/issues/1/close
</pre>


## Reopen an Issue

Changing the status of an issue is similar to adding a comment on an issue.

    POST /issues/<issue_id>/open

### Required Parameters

* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl -i \
       --header "Content-Type: application/json" \
       --data '{"comment": "Pothole is back!"}' \
       <%= root_version_url %>/issues/1/open
</pre>

Media can be attached the same way as [closing comments](#with_media)

### Response

<%= headers 201 %>
<%= json(:issue_opened) %>

## Acknowledge an Issue

Changing the status of an issue is similar to adding a comment on an issue.

    POST /issues/<issue_id>/acknowledge

### Required Parameters

* **comment**=`:comment` - A comment is required when changing the status.

### Optional Parameters

* **image** - An image of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example

<pre class="terminal">
$ curl -i \
       --header "Content-Type: application/json" \
       --data '{"comment": "We have seen the pothole."}' \
       <%= root_version_url %>/issues/1/acknowledge
</pre>

Media can be attached the same way as [closing comments](#with_media)

### Response

<%= headers 201 %>
<%= json(:issue_acknowledged) %>
