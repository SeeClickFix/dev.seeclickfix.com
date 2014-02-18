---
title: Organizations | SeeClickFix API
---

# Organizations

* TOC
{:toc}

## List All Organizations

    GET <%= root_version_url %>/organizations

This endpoint returns a collection of organization objects.  The
collection only contains organizations associated with the authenticated
user.

Authentication: Required

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/organizations
</pre>

<%= headers 200 %>
<%= json(:organization) { |h| [h] } %>

## Get a Single Organization

    GET <%= root_version_url %>/organizations/:id

This endpoint returns a single organization object. The endpoint
will return a 404 error if the authenticated user is not associated
with requested object.

Authentication: Required

### Example

<pre class="terminal">
$ curl -i <%= root_version_url %>/organizations/3
</pre>

### Response

<%= headers 200 %>
<%= json(:organization) %>
