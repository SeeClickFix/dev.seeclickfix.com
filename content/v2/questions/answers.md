---
title: API v2 - Answers
---

# Answers

Answers are user submitted responses to questions.

* TOC
{:toc}

## List answers to a question.

    GET <%= root_version_url %>/questions/<question_id>/answers

### Optional Parameters

None.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/questions/1/answers
</pre>

Returns all answers to question id 1.

<%= headers 200 %>
<%= 
  json(:answer) do |h| 
    { metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      answers: [h],
      errors: {}
    }
  end 
%>

## Answer a Question

    POST <%= root_version_url %>/questions/1/answers

Posts an answer to question id 1.

### Required Parameters

* answer - The answer to be posted.
* user - The user must be logged in.

### Optional Parameters

* locale - The locale the answer is submitted in. Defaults to 'en'.

### Examples

<pre class="terminal">
$ curl --data "answer=Taxes+are+due+Jan.+1st." -i <%= root_version_url %>/questions/1/answers
</pre>

<%= headers 201 %>
<%= json(:answer) %>

### Errors

Returns error code 422 if unable to create user.

<%= headers 422 %>
<%= json(errors: {
  login: "can't be blank."
}) %>



