---
title: API v2 - Places
---

# Places

Places are administrative areas such as neighborhoods, cities, counties etc.. They can be used to define <a href="/#geography">geographical boundaries</a> and therefore content within those boundaries.

* TOC
{:toc}

## List Places

    GET <%= root_version_url %>/places

Returns a list of places closest to `point`.

### Required Parameters

* **point**=`:point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/places?point=New+Haven,+CT
</pre>

Returns the 20 closest places.

<%= headers 200, :pagination => true %>

<%= 
  json(:place) do |h| 
    { metadata: nil,
      result: [h],
      errors: nil
    }
  end 
%>

## Show Place

    GET <%= root_version_url %>/places/:id

Returns a single place by `:id`.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/places/1
</pre>



<%= headers 200 %>

<%= 
  json(:place) do |h| 
    { metadata: nil,
      result: h,
      errors: nil
    }
  end 
%>
