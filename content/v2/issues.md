---
title: Issues | SeeClickFix API
---

# Issues

* TOC
{:toc}

## List issues

List multiple issues.

    GET <%= root_version_url %>/issues

### Defaults

* **within** - Not limited by geography.
* **status** - Open, Acknowledged, or Closed. Excludes Archived.
* **page** - 1
* **per_page** - 20
* **sort** - created_at
* **date** - No date limits.

### Required Parameters

None

### Optional Parameters

* **within**=`area` - Limit results to the specified area. Areas can be one of the following formats: 

    1. Bounding box `:sw_lat,:sw_lng|:ne_lat,:ne_lng` 
    2. Place `url_name` (see the Place resource for more information)
    3. Latitude, Longitude, Zoom `:latitude|:longitude|:zoom` 
    4. Address and Zoom `746 Chapel St. New Haven, CT|14`.

* **page**=`:page_number` - number of the page to return, default: 1

* **per_page**=`:per_page` - number of issues returned per page, default: 20

* **status**=`:status1,:status2` - one of 'Open', 'Acknowledged', 'Closed', 'Archived'. default: Open,Acknowledged,Closed

* **sort**=`:order` - one of `updated_at`, `created_at`, or `rating`.

* **sort_direction**=`:direction` - "asc" or "desc" default: `desc`.

* **after**=`:time` - :time can be either a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ OR an integer representing minutes since current time.

* **before**=`:time` - :time can be either a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ OR an integer representing minutes since current time.


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

### Required Parameters

None

## Create an issue

Issues can be created by any authenticated user.

    POST /issues

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

<%= headers 201,
    Location: 'https://api.github.com/repos/user/repo/issues/1' %>
<%= 
 json({ 
   metadata: [{moderated: false}],
   result: nil,
   errors: nil
 })
%>
