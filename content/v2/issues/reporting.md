---
title: API v2 - Issues - Report Form
---

# Reporting an Issue

Reporting an Issue is a three step process. Step 1 requires querying for a report form by location. Step 2 is querying the fields for the request type. Step 3 is to create an issue.

* TOC
{:toc}

## Report form

    GET <%= root_version_url %>/new?:point

### Required Parameters

* `:point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/new?address=New+Haven,+CT
</pre>

Returns a list of service requests and their follow up questions for a particular location. TODO this is different from our current API. I don't think this would work for remote APIs like DC.

### Response

<%= headers 200 %>
<%= json(:new_issue) %>

## Details about a Request Type

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_type/122
</pre>

### Response

<%= headers 200 %>
<%= json(:request_type_122) %>

We will always provide an "Other" category, in the event one is not supplied by th city we will provide one

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_type/other
</pre>

### Response

<%= headers 200 %>
<%= json(:request_type_other) %>

## Question Types

* **text** - Short form text answer.
* **textarea** - Long form text answer.
* **select** - One value from supplied list.
* **multivaluelist** - One or more values from the supplied list. Submitted as an array.
* **number** - requires a numerical validation.
* **datetime** - ISO 8601 timestamp.
* **boolean** - Only `true`/`false` are acceptable answers
* **hidden** - field hidden from user.
* **note** - No response expected, display as a note to the user.

## Select Values

For **select** amd **multivaluelist** the use should we return a display value (`name`) and a key value (`key`).

## Request Type & Questions for authenticated users

Some request types & questions are only for specific authenticated users.


## Create an issue

Issues can be created by any authenticated user.

    POST <%= root_version_url %>/issues

### Required Parameters

* **address** - A written description of the location of the issue.
* **latitude** - The latitude of the issue.
* **longitude** - The longitude of the issue.
* **questions** - Answers to questions
* **request_type_id** - the id of your chosen Request Type

### Optional Parameters

* **anonymize_reporter** - Wether or not to protect the identification of the reporter. Default is false.  will evaluate to true.
* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example request

<%=
 json({
   latitude: 42.7265,
   longitude: -72.567,
   address: '123 State St. New Haven, CT',
   response_type_id: 122,
   questions: {
     "142" => "SHALLOW",
     "summary" => 'Big Pothole',
     "description" => 'Please fix it'
   }
 })
%>

### Response

<%= headers 201, { Location: "http://seeclickfix.com/issues/987654321" } %>
<%=
 json({
   metadata: {moderated: false}
 })
%>

### In the event of validation errors

<%= headers 422 %>
<%=
 json({
   errors: [
     "An Address is required",
     "Question: 'Depth of pothole?' is required"
   ]
 })
%>
