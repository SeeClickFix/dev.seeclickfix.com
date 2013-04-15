---
title: API v2 - Mobile Customizations
---

# Mobile Customizations

Our mobile applications are customized by partnering cities at specific locations. Use this resource to query for the style changes.

    GET <%= root_version_url %>/mobile_customizations/:point

### Required Parameters

* `:point` - See <a href="/#geography">how to specify a geography</a> for syntax help.

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/mobile_customizations/New+Haven,+CT
</pre>

Returns the most appropriate mobile customization at the specified point.

<%= headers 200 %>

<%= 
  json(:mobile_customization) do |h| 
    { metadata: nil,
      result: h,
      errors: nil
    }
  end 
%>
