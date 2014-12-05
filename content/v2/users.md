---
title: API v2 - Users
---

# Users

* TOC
{:toc}

## Show Current User

    GET <%= root_version_url %>/profile

Returns the currently logged in user.

### Example

<pre class="terminal">
$ curl -i <%= root_version_url %>/profile
</pre>

If the user is logged in.

<%= headers 200 %>
<%= json(:user) %>

If the user is not logged in.

<%= headers 200 %>
<%= json(id: nil) %>

## Show User by Id

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
    { errors: {},
      metadata: pagination: SeeClickFix::Resources::PAGINATION_METADATA,
      users: [h]
    }
  end 
%>

## Register

    POST <%= root_version_url %>/users

Registers a new user

### Required Parameters

* name - Name displayed on site. Must be between 3 and 40 characters long.
* email - Can't be blank.
* password - Must be between 4 and 40 characters long.
* password_confirmation - Must be equal to password above.
* accept_terms - Must be set to 'true'. Confirms user has read <http://seeclickfix.com/registration/new> 

### Optional Parameters

* place_url_name - The `url_name` attribute of a place object, which represents the home of the user.
* uploaded_data - The image of the user.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/users
</pre>

<%= headers 201 %>

<%= json(:user) %>

### Errors

Returns error code 422 if unable to create user.

<%= headers 422 %>
<%= json(errors: {
  login: "can't be blank."
}) %>

## Update User Settings

    PUT <%= root_version_url %>/profile

Updates the settings for the current user. 

### Required Parameters

* name - Name displayed on site. Must be between 3 and 40 characters long.
* email - Can't be blank.
* password - Must be between 4 and 40 characters long.
* password_confirmation - Must be equal to password above.
* accept_terms - Must be set to 'true'. Confirms user has read <http://seeclickfix.com/registration/new> 

### Optional Parameters

* place_url_name - The `url_name` attribute of a place object, which represents the home of the user.
* uploaded_data - The image of the user.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/profile
</pre>

<%= headers 200 %>

<%= json(:user) %>

### Errors

Returns error code 422 if unable to update the user.

<%= headers 422 %>
<%= json(errors: {
	login: "can't be blank."
}) %>
