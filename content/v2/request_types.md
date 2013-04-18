---
title: Request Types | SeeClickFix API
---

# Request Types

* TOC
{:toc}
 
## List Request Types

    GET <%= root_version_url %>/request_types
    
### Required Parameters

* `point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

### Optional Parameters

* `ids` - Comma seperated list of plus_watch_area ids that will be returned in addition to any request types that exist at the specified location.

### Get availavle Request Types at a location

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types?point=New+Haven,+CT
</pre>

### Response

<%= headers 200 %>

<%= json(:enhacned_watch_areas) %>

### Get availavle Request Types at a location in addition to those of a known id

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types?point=Boston,+Ma&ids=201
</pre>

### Response

<%= headers 200 %>

<%= json(:enhacned_watch_areas_with_ids) %>

## Request Types for authenticated users

Some Request Types are only for specific authenticated users.
