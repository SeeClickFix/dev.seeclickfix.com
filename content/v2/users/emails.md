---
title: API v2 - User Emails
---

# User Emails

* TOC
{:toc}

API endpoints to allow the user to manage their emails.

## List emails 

List emails of the currently logged in user.

    GET <%= root_version_url %>/emails

Returns a list of emails.

### Required Parameters

* logged in user - The user must be logged in to view their emails.

### Optional Parameters

none.

### Order

The sort order is alphabetical by email.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/emails
</pre>

Returns the current user's emails

<%= headers 200 %>

<%= 
  json(:email) do |h| 
    { metadata: {},
      emails: [h],
      errors: {}
    }
  end 
%>


## Add an email

Adds an email to the current user.

    POST <%= root_version_url %>/emails

Returns the email just added.

### Required Parameters

* logged in user - The user must be logged in as the user to add an email to.
* email - The new email to be added.

### Optional Parameters

none.

### Examples

<pre class="terminal">
$ curl --data "email=foo@bar.com" -i <%= root_version_url %>/emails
</pre>

Returns the current user's emails

<%= headers 201 %>

<%= 
  json(:email) do |h|
    h
  end 
%>

## Remove an email

Removes an email from the current user.

    DELETE <%= root_version_url %>/emails/:id

Returns the email just removed.

### Required Parameters

* logged in user - The user must be logged in as the user to add an email to.
* id - The id of the email to be added.

### Optional Parameters

none.

### Examples

<pre class="terminal">
$ curl -X DELETE -i <%= root_version_url %>/emails/1
</pre>

Returns the email just deleted.

<%= headers 204 %>

<%= 
  json(:email) do |h|
    h
  end 
%>
