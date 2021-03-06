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

* Point - See <a href="/#geography">how to specify a geography</a> for the latitude and longitude or address syntax.

### Optional Parameters

* Pagination - See <a href="/#pagination">how to specify pagination</a>

### Order

The sort order is by distance from Point.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/places?address=New+Haven,+CT
</pre>

Returns the 20 closest places.

<%= headers 200 %>

<%= 
  json(:place) do |h| 
    { errors: nil,
      metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      places: [h]
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

<%= json(:place) %>

### Errors

Returns error code 404 if no results are found.

<%= headers 404 %>