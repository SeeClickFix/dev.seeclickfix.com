---
title: Issues | SeeClickFix API
---

# Issues

* TOC
{:toc}

## List issues

    GET <%= root_version_url %>/issues

### Optional Parameters

* **area**=`:geography` - Limit results to the specified area. See <a href="/#geography">how to specify a geography</a> for syntax help. 

* **page**=`:page_number` - number of the page to return, default: 1

* **per_page**=`:per_page` - number of issues returned per page, default: 20

* **status**=`:status1,:status2` - one of 'Open', 'Acknowledged', 'Closed', 'Archived'. default: Open,Acknowledged,Closed

* **sort**=`:order` - one of 'updated_at', 'created_at', 'distance' or 'rating'. default: created_at.

* **sort_direction**=`:direction` - "asc" or "desc" default: 'desc'.

* **after**=`:time` - can be either a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ OR an integer representing minutes since current time.

* **before**=`:time` - can be either a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ OR an integer representing minutes since current time.

### Notes

For performance reasons, results larger than 30 will be abbreviated.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/issues?page=1&per_page=5
</pre>

Returns the last five issues.

<%= headers 200, :pagination => true %>

<%= 
  json(:issue) do |h| 
    { metadata: nil,
      result: [h],
      errors: nil
    }
  end 
%>

## Get a single issue

    GET /issues/:id

### Response

<%= headers 200 %>
<%= 
  json(:issue) do |h| 
    { metadata: nil,
      result: h,
      errors: nil
    }
  end 
%>

## Create an Issue

See the <a href="/v2/issues/report_form/">reporting an issue</a>.
