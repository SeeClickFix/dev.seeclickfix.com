---
title: API v2 - Geocoding
---

# Geocoding Services


## Geocode

    GET <%= root_version_url %>/geocode/:point

### Required parameters

* `:point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

For forward geocoding, pass an address as the point and we will return the latitude / longitude. 

For reverse geocoding, pass a latitude / longitude pair and receive the address information.

Our geocoding service uses the most appropriate service for the specified location. In some cases we will use municipal services for validated locations.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/geocode/New+Haven,+CT
</pre>

Returns the geocode object for 'New Haven, CT'.

<%= headers 200, :pagination => true %>

<%= 
  json(:geocode) do |h| 
    { metadata: nil,
      result: h,
      errors: nil
    }
  end 
%>

