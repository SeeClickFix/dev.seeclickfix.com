---
title: API v2 - Issues - Report Form
---

# Reporting an Issue

Reporting an Issue is a three step process. Step 1 requires querying for a report form by location. Step 2 is querying the fields for the request type. Step 3 is to create an issue.

* TOC
{:toc}

## Report form

    GET <%= root_version_url %>/issues/new?:point

### Required Parameters

* `:point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/issues/new?address=New+Haven,+CT
</pre>

Return a list of request types for the given location.
Each request type has an explicit organization which can be used to group the request types.
A null organization represents a community request type that isn't associated with any particular organization.

### Response

<%= headers 200 %>
<%= json(:new_issue) %>

## Details about a Request Type

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types/122
</pre>

### Response

<%= headers 200 %>
<%= json(:request_type_122) %>

### Details of another Request Type

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types/657
</pre>

### Response

<%= headers 200 %>
<%= json(:request_type_657) %>

We will always provide an "Other" request_type. In the event one is not supplied by the city we will provide one.

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types/other
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
* **lat** - The latitude of the issue.
* **lng** - The longitude of the issue.
* **answers** - Answers to questions, if any questions are required.
* **request_type_id** - the id of your chosen Request Type

### Optional Parameters

* **anonymize_reporter** - Wether or not to protect the identification of the reporter. Default is false.  will evaluate to true.
* **device_id** - A unique identifier for the device creating the comment. This can help us debug problems.
* **device_os** - Device OS. This can help us debug problems.
* **device_name** - Model of device. This can help us debug problems.

### Example request

<pre class="terminal">
  curl -i \
       --header "Content-Type: application/json" \
       --data '{
         "lat": 42.7265,
         "lng": -72.567,
         "address": "123 State St. New Haven, CT",
         "request_type_id": 122,
         "answers": {
           "142": "SHALLOW",
           "summary": "Big Pothole",
           "description": "Please fix it"
         }
       }' \
       <%= root_version_url %>/issues
</pre>

### Response

<%= headers 201, { Location: "http://seeclickfix.com/issues/1" } %>
<%= json(:issue_no_media) %>

### Example request #2

<pre class="terminal">
  curl -i \
       --header "Content-Type: application/json" \
       --data '{
          "lat":42.7265,
          "lng":-72.567,
          "address": "123 State St. New Haven, CT",
          "request_type_id": 657,
          "answers": {
            "400": ["Brick", "PaintedBrick", "Wood"],
            "401": ["Other"],
            "offensive": false,
            "summary": "Graffiti on a brick wall"
          }
        }' \
       <%= root_version_url %>/issues
</pre>

### Response

<%= headers 201, { Location: "http://seeclickfix.com/issues/1" } %>
<%= json(:issue_no_media) %>

### Example request #3, with image media

If you want to post an image when creating your issue, you must use multipart form data not json.

<pre class="terminal">
$ curl -i \
       --header "Content-Type: multipart/form-data" \
       --form "lat=42.7265" \
       --form "lng=-72.567" \
       --form "address=123 State St. New Haven, CT" \
       --form "request_type_id=other" \
       --form "answers[summary]=Found a pothole" \
       --form "answers[issue_image]=@photo.png" \
       <%= root_version_url %>/issues
</pre>

### Response

<%= headers 201, { Location: "http://seeclickfix.com/issues/1" } %>
<%= json(:issue) %>

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

### If for any reason we decide to hold the report in moderation

We will finish processing the request at a later date.

<%= headers 202 %>
<%= json({ metadata: { moderated: true } }) %>
