---
title: Issues | SeeClickFix API
---

# Issues

* TOC
{:toc}

## List issues

    GET <%= root_version_url %>/issues

### Optional Parameters

* one or more area geographies - Limit results to a specified area. See <a href="/#geography">how to specify a geography</a> for syntax help.

* **page**=`:page_number` - number of the page to return, default: 1

* **per_page**=`:per_page` - number of issues returned per page, default: 20, maximum: 100, requests with details are limited to 20.

* **status**=`:status1,:status2` - one of 'open', 'acknowledged', 'closed', 'archived'. default: open,acknowledged,closed

* **sort**=`:order` - one of 'updated_at', 'created_at', 'rating', 'distance'. default: created_at.

* **sort_direction**=`:sort_direction` = One of ASC or DESC. Default is DESC.

* **after**=`:time` - must be a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

* **before**=`:time` - must be a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

* **updated_at_after**=`:time` - must be a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

* **updated_at_before**=`:time` - must be a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ

* **search**=`:search` - limit results by search terms.

* **request_types**=`:request_type_id0,:request_type_id1` - comma delimited [Request Type](/v2/issues/reporting/#details-about-a-request-type) ids.

* **assigned_to_me**=`true` - issues assigned to the current_user. **NOTE** the request **must** be authenticated or this will be ignored.

* **assigned**=`:user_id0,:user_id1` - comma delimited user ids,

* **assigned**=`:user_id0,unassigned` - use the string "unassigned" to select unassigned issues

* **details**=`true` - defaults to `false`. Pass `true` to get an extended issue object including comments, user information, and questions and answers.

----

#### Filter by `created_at`

To filter issues by their creation time (`created_at`) use:

* `after`: only include issues where `created_at` >= `after`
* `before`: only include issues where `created_at` < `before`

#### Filter by `updated_at`

To filter issues by their update time (`updated_at`) use:

* `updated_at_after`: only include issues where `updated_at` >= `updated_at_after`
* `updated_at_before`: only include issues where `updated_at` < `updated_at_before`

### Examples

<pre class="terminal">
$ curl -i <%= root_version_url %>/issues?page=1&per_page=5
</pre>

Returns the last five issues.

<%= headers 200 %>
<%=
  json(:issue) do |h|
    { errors: nil,
      metadata: SeeClickFix::Resources::PAGINATION_METADATA,
      issues: [h]
    }
  end
%>

## Get a single issue

    GET /issues/:id

Returns a single issue by id.

### Example

<pre class="terminal">
$ curl -i <%= root_version_url %>/issues/1?details=true
</pre>

### Response

<%= headers 200 %>
<%= json(:issue_details) %>

## Create an Issue

See the <a href="/v2/issues/reporting/">reporting an issue</a>.
