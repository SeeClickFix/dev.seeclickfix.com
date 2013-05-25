---
title: API v2 - Users
---

# Users

* TOC
{:toc}

## Register

## Current User

    GET <%= root_version_url %>/users/me

Returns the currently logged in user.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/users/me
</pre>

If the user is logged in.

<%= headers 200 %>
<%= json(:user) %>

If the user is not logged in.

<%= headers 200 %>
<%= json(id: nil) %>

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

## List Users

    GET <%= root_version_url %>/users

Returns a list of users closest to `point`.

### Required Parameters

* Point - See <a href="/#geography">how to specify a geography</a> for the latitude and longitude or address syntax.

### Optional Parameters

* Pagination - See <a href="/#pagination">how to specify pagination</a>

### Order

The sort order is by distance from Point.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/users?address=New+Haven,+CT
</pre>

Returns the 20 closest users.

<%= headers 200 %>

<%= 
  json(:user) do |h| 
    { metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      places: [h],
      errors: nil
    }
  end 
%>

## Update User Settings

