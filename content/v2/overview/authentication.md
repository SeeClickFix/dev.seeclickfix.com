---
title: API v2 - Overview - Authentication
---

# Authentication

SeeClickFix currently supports the following authentication methods for access to API v2.

1. Token Authentication
1. OAauth2 Authentication

### Token Authentication
This method is appropriate for API access. It is a secret that is included as a request header.

Header Format:
<pre class="terminal">
Authorization: Bearer [token]
</pre>

To create and manage Bearer Tokens for Authentication, visit [Password & Security](https://account.civicplus.com/security) and go to the Personal Access Token section. Personal Access Tokens are Bearer Tokens.

<pre class="terminal">
$ curl -i https://seeclickfix.com/api/v2/profile -H "Authorization: Bearer test-08/12/2024-01/01/2025-xxxxxxxxxxxxxx"
</pre>


### OAuth2 Authentication

This method is appropriate when the client application is being used by multiple users
and the user's credentials should not be shared with the client directly.

SeeClickFix supports OAuth2's "authorization code flow" as documented in [RFC 6749](https://tools.ietf.org/html/rfc6749#section-4.1)

The [Doorkeeper documentation](https://github.com/doorkeeper-gem/doorkeeper/wiki/authorization-flow) provides some easier to read information regarding the sequence of API calls.


Before an application (API client) can use OAuth2 with SeeClickFix it must be registered
with our system. Register your app by sending the following information to
developer-support@seeclickfix.com:

1. Name of Application
1. Organization Name
1. Technical Contact Name, Email, Phone
1. Administrative Contact Name, Email, Phone
1. The callback URI to be used during the authentication phase and token phase

SeeClickFix will register the application and return an application id.
The name of the application will be presented to users on authorization and
deauthorization views and so should be selected such that users understand
which application is accessing SeeClickFix services on their behalf.

With the client id, authentication and API access can proceed as follows using an OAuth Implicit Flow:

1. Client Application initiates browser access to SCF authentication endpoint

<pre class="terminal">
https://seeclickfix.com/oauth/authorize?client_id=YOUR_CLIENT_ID&redirect_uri=YOUR_REDIRECT_URI&response_type=token
</pre>

2. SCF user enters SCF credentials and on success is redirected to Client Application Redirect URI which will include an access_token

3. Client Application can now make API requests on behalf of the user, by including user's access token. See [RFC 6750](http://tools.ietf.org/html/rfc6750#section-2.1) for options and detail for transmitting the access token to the API endpoints. One method is to send the access_token in the `Authentication` header:

<pre class="terminal">
Authentication: Bearer xxxxxxxxxxxxxxxxxxxx
</pre>

For more details see this [overview](https://auth0.com/docs/flows/concepts/implicit) of the implicit flow [RFC 6749, section 4.2](https://tools.ietf.org/html/rfc6749#section-4.2)

For additional security we recommend sending a state nonce with the orginal authorize request and verifying that you get it back in the callback. This ensures that the response hasn't been intercepted by other apps on your mobile device, for example.  See this [article](https://auth0.com/docs/protocols/oauth2/oauth-state) for more details.
