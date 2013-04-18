---
title: API v2 - Request Type Questions - Changing Status
---

# Request Type Questions

* TOC
{:toc}
 
## List Questions

    GET <%= root_version_url %>/request_types/:id

### Get the questions for a request_type

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types/99
</pre>

### Response

<%= headers 200 %>

<%= json(:request_type_with_question) %>

## Question Types

* **text** - Short form text answer.
* **textarea** - Long form text answer.
* **select** - One value from supplied list.
* **multivaluelist** - One or more values from the supplied list.
* **number** - requires a numerical validation.
* **datetime** - ISO 8601 timestamp.
* **note** - No response expected, display as a note to the user.
* **hidden** - field hidden from user.

## Select Values

For **select** amd **multivaluelist** the use should we return a display value (`name`) and a key value (`key`).

## Questions for authenticated users

Some questions are only for specific authenticated users.
