---
title: API v2 - Questions
---

# Questions

Questions and answers are only available in places where the data_classification is of type "City".

* TOC
{:toc}

## List questions

    GET <%= root_version_url %>/<place_url_name>/questions

### Optional Parameters

* **page**=`:page_number` - number of the page to return, default: 1

* **per_page**=`:per_page` - number of issues returned per page, default: 20

* **search**=`:search` - limit results by search terms.

* **subset**=`:subset` - One of 'answered', 'unanswered', or blank. A blank subset will return answered and unanswered questions.

### Order

The default sort order is by popularity.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/new-haven/questions
</pre>

Returns questions asked within the city of New Haven, CT, where the place_url is 'new-haven'.

<%= headers 200 %>
<%= 
  json(:question) do |h| 
    { errors: {},
      metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      questions: [h],
    }
  end 
%>

## Get a single question

    GET /questions/:id

Returns a single question by id.

### Example

<pre class="terminal">
$ curl -i <%= root_version_url %>/questions/1
</pre>

### Response

<%= headers 200 %>
<%= 
  json(:question) do |h| 
    h
  end 
%>

### Errors

If a question with the specified id is not found a response code 404 will be returned.

<%= headers 404 %>

## Ask a Question

    POST <%= root_version_url %>/:place_url_name/questions

Posts a question within city of `:place_url_name`.

### Required Parameters

* question - The question to ask.
* user - The user must be logged in.
* place_url_name - The place_url_name is part of the url. 

### Optional Parameters

* locale - The locale the question is asked in. Defaults to 'en'.

### Examples

<pre class="terminal">
$ curl --data "question=When+are+taxes+due?" -i <%= root_version_url %>/new-haven/questions
</pre>

<%= headers 201 %>
<%= json(:question) %>

### Errors

Returns error code 422 if unable to create user.

<%= headers 422 %>
<%= json(errors: {
  login: "can't be blank."
}) %>



