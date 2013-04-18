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

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types?point=New+Haven,+CT
</pre>

<%= headers 200 %>

<%= json(:enhacned_watch_areas) %>

<pre class="terminal">
$ curl -i <%= root_version_url %>/request_types?point=Boston,+Ma&ids=201
</pre>

<%= headers 200 %>

<%= json(:enhacned_watch_areas_with_ids) %>

## Request Types for authenticated users

Some Request Types are only for specific authenticated users.
