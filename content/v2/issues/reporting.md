---
title: API v2 - Issues - Report Form
---

# Reporting an Issue

Reporting an Issue is a two step process. Step 1 requires querying for a report form by latitude and longitude. Step 2 is to create an issue.

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
<%= 
 json(:report_form) do |h| 
   { metadata: nil,
     result: h,
     errors: nil
   }
 end
%>

## Create an issue

Issues can be created by any authenticated user.

    POST <%= root_version_url %>/issues

### Required Parameters

* **summary** - A user written summary of the issue.
* **address** - A written description of the location of the issue.
* **latitude** - The latitude of the issue.
* **longitude** - The longitude of the issue.


### Optional Parameters

* **description** - A user written description of the issue. 
* **anonymize_reporter** - Wether or not to protect the identification of the reporter. Default is false. A value of '1' will evaluate to true.
* **image** - An image of the problem. Limited to 20Mb.
* **video** - A video of the problem. Limited to 20Mb.
* **youtube_url** - A link to a youtube video showing the problem.

### Example request

<%= 
 json({ 
   summary: 'Big Pothole',
   description: 'Please fix it',
   latitude: 42.7265,
   longitude: -72.567,
   address: '123 State St. New Haven, CT'
 })
%>

### Response

<%= headers 201 %>
<%= 
 json({ 
   metadata: [{moderated: false}],
   result: nil,
   errors: nil
 })
%>
