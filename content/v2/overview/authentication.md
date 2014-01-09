---
title: API v2 - Overview - Authentication
---

# Authentication

SeeClickFix uses key based authentication. You can obtain or change your key in your personal preferences page. This key should remain secret and should only be used over SSL for security. Unless noted otherwise, read-only requests do not require a key. Write requests require a key.

### Getting a Key

To obtain a key you must have a SeeClickFix account. You may register for a free account here: https://seeclickfix.com/register

Once you have an account login and go to "My Account" > "Preferences". There is an "API Keys" section on the lefthand side of the page. Once you generate a key its ready to use. Please remember that use of the API falls under our Open Data Policy (http://seeclickfix.com/open_data) and Terms of Use (http://seeclickfix.com/terms_of_use).

### Basic Authentication

<pre class="terminal">
$ curl -u "username" <%= root_version_url %>
</pre>

### OAuth2 Token (sent in a header)

<pre class="terminal">
$ curl -H "Authorization: token OAUTH-TOKEN" <%= root_version_url %>
</pre>

### OAuth2 Token (sent as a parameter)

<pre class="terminal">
$ curl <%= root_version_url %>/?access_token=OAUTH-TOKEN
</pre>

Read [more about OAuth2](/v3/oauth/).  Note that OAuth2 tokens can be [acquired
programmatically](/v3/oauth/#create-a-new-authorization), for applications that
are not websites.
