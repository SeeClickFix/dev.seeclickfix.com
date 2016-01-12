---
title: API v2 - Overview - Authentication
---

# Authentication

SeeClickFix currently supports the following authentication methods for access to API v2.
1. HTTP Basic Authentication
1. OAauth2 Authentication

### HTTP Basic Authentication

This method is appropriate when the client has direct access to user credentials (username
and password).

<pre class="terminal">
$ curl -u "email@example.com:password" <%= root_version_url %>/profile
</pre>

### OAuth2 Authentication

This method is appropriate when the client application is being used by multiple users
and the user's credentials should not be shared with the client directly.

SeeClickFix supports OAuth2's "authorization code flow" as documented in [RFC 6749](https://tools.ietf.org/html/rfc6749#section-4.1)

The [Doorkeeper documentation](https://tools.ietf.org/html/rfc6749#section-4.1) provides some easier to read information regarding the sequence of API calls.


Before an application (API client) can use OAuth2 with SeeClickFix it must be registered
with our system. Register your app by sending the following information to
developer-support@seeclickfix.com:

1. Name of Application
1. Organization Name
1. Technical Contact Name, Email, Phone
1. Administrative Contact Name, Email, Phone
1. The callback URI to be used during the authentication phase and token phase

SeeClickFix will register the application and return an application id and secret.
The name of the application will be presented to users on authorization and
deauthorization views and so should be selected such that users understand
which application is accessing SeeClickFix services on their behalf.

With the id and secret, authentication and API access can proceed as follows:

1. application triggers browser access to SCF authentication endpoint
2. user enters credentials, browser is redirected to redirect URI with code
3. application uses code to directly request access token from SCF
4. SCF returns access token to application
5. application makes API requests using access token

See [RFC 6750]()http://tools.ietf.org/html/rfc6750#section-2.1) for details of how to transmit the access token to the API endpoints.
