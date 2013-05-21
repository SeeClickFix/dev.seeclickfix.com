---
title: API v2 - Users
---

# Users

* TOC
{:toc}

## Register

## Show User

    GET <%= root_version_url %>/users/:id

Returns a single user by `:id`.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/users/1
</pre>

<%= headers 200 %>

<%= json(:user) %>

### Errors

Returns error code 404 if no results are found.

<%= headers 404 %>