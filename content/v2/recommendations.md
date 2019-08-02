# API Recommendations

This page describes the differences
between the various APIs offered by SeeClickFix
and provides some guidance
regarding which API to use for different situtations.
In addition to the
two public APIS, partner organizations have access to a private
organizational API also. The three APIs discussed here are:

* Open311
* SeeClickFix APIv2
* SeeClickFix APIv2 for Organizations


## Open311

The Open311 API is a standards-compliant API that provides access
to public issues on the SeeClickFix platform as well as the ability
to report issues without needing to establish a SeeClickFix user
account.
The Open311 API is documented [here](https://wiki.open311.org/GeoReport_v2/).

Some additional SeeClickFix specific details can be found [here](https://seeclickfix.com/open311/v2).

Each organization has its own Open311 endpoint
[(https://seeclickfix.com/open311/v2/:organization_id)](https://seeclickfix.com/open311/v2/:organization_id)
and an aggregate endpoint for all public issues on the SeeClickFix platform is available at
[https://seeclickfix.com/open311/v2](https://seeclickfix.com/open311/v2)
with extensions for locating issues by location.

## SeeClickFix APIv2

SeeClickFix APIv2 also provides access to public issues as well as
features designed to be used by interactive issue reporting
applications. It is geo-spatially organized rather than organized
around individual organizations.

[https://seeclickfix.com/api/v2](https://seeclickfix.com/api/v2) is the base URL for this API.
See [https://dev.seeclickfix.com](https://dev.seeclickfix.com) for documentation.

Issues are viewable via this API without authorization but content
creation and updates requires valid authentication.

## SeeClickFix APIv2 for Organizations

This API is a variation of SeeClickFix APIv2 with
endpoints scoped to individual organizations:

    https://seeclickfix.com/api/v2/organizations/:organization_id

This API is the only one that provides access to private issues and
other non-public content.  Access to this API must be authenticated
and is only available to properly authorized members of the respective
organizations.

# Choosing an API

The following section reviews suggested uses for the APIs:

* viewing public content
* accessing API as a public user
* viewing public and private content
* accessing API as an organization user

The difference between the three APIs are summarized in this table:

<style>
table.withborder { border:1px solid black; }
table.withborder { border-collapse: collapse; }
table.withborder, table.withborder th, table.withborder td { border: 1px solid black; }
table.withborder th, table.withborder td { border: 1px solid black; padding: 4px }
table.withborder th { background-color: #eeeeee }
</style>
| API | Public Only | Geo Scoped | Org Scoped | Private Content | Authentication |
|---|
| Open311 | yes | yes | yes | no | not required |
| APIv2 | yes | yes | no | no | required for creating/updating
| APIv2 for Organizations | no | no | yes | yes | always required, organization members only |
|---|
{:.withborder}


## Viewing Public Content

All of the APIs can be used to view public issues.

We recommend using the Open311 API where possible or SeeClickFix
APIv2 if additional content such as public comments is of interest.
These APIs are intentionally limited to public issues and public
details.

The Open311 API does not require any user authentication. See
[https://seeclickfix.com/open311/v2](https://seeclickfix.com/open311/v2)
for documentation.

SeeClickFix APIv2 does not require user authentication for viewing but
does require authentication for creating or updating content. It
can be used for accessing public issues, but it is scoped by geography
and so can be more difficult to use than the Open311 API if the
goal is to access issues associated with a particular organization.
See [https://dev.seeclickfix.com](https://dev.seeclickfix.com) for
documentation.

The organizational API is not recommended if the data is to be used
for public display as this API includes access to private issues
and extra attention must be paid to handling the private content.

## Accessing API as a Public User

The Open311 API and SeeClickFix APIv2 can be used to report a new
issue as a public user. Open311 does not require authentication
while APIv2 does. APIv2 for Organizations is restricted to members
of an organization and is should not be used to report an issue
as a public user.

## Viewing Public and Private Content

The only API that allows access to private content is APIv2 for
Organizations.

In order to access the organizational API, the API client must be
authenticated as a member of the organization. We recommend that
API clients be associated with their own user rather than re-using
a real person's user id. This "API user" must be added as a member
of the organization in order to utilize the organizational API and
will be counted towards any user license limits.

The documentation at `dev.seeclickfix.com` should be used for
accessing the organizational API but with the understanding that
the organizational endpoint is of the form
[https://seeclickfix.com/api/v2/organizations/:organization_id](https://seeclickfix.com/api/v2/organizations/:organization_id)
where `:organization_id` is the account id for the partner.

The membership role associated with an API user controls what content
can be accessed, created, or updated by the API user via the
organizational API. We recommend that the user be given the limited
role of an “internal user” and not “owner” or “manager” when
the API user isn't creating or updating content.

### 3rd Party Access Considerations

Some partner organizations may want to allow a 3rd party tool to
have access to their data via the SeeClickFix APIs. Partners should
review the following considerations in these circumstances.

Partners are always responsible for adding users to their membership
roster when needed for API access. SeeClickFix employees are not
authorized to create members or provide access to credentials
(passwords) for API access.

If API access is granted to a 3rd party (by adding an API user as
a member of an organization), the partner is responsible for the actions
of the 3rd party API client including ensuring that any information
is used according to all applicable privacy policies and terms of
use. We strongly recommend using the Open311 API or SeeClickFix
APIv2 to access content wherever possible to avoid the complications
associated with private content (private issues, internal comments,
PII information etc.).

## Accessing APIs as an Organization User

Open311 can not be used as an organizational member as
no user authentication is supported.

APIv2 can be used as a member of an organization but access as a
member only provides access to a few additional capabilities. Those
capabilities include access to internal request categories and questions
as well as transitioning an issue to and from the Acknowledged state.

APIv2 for Organizations can only be used by authenticated organization
members according to their membership role. It is designed to to be
used by the organization for automation or integration purposes.

### APIv2 for Organizations Details

When creating content via APIv2 for Organizations, the new content
(service requests, comments, etc.) will be associated with the
authentiated as with basic APIv2. In addition, during issue reporting,
it is possible for an authenticated API client to create an issue on
behalf of another user. For example, an API client can authenticate
as an autmated "API user" but create issues with staff members as
the reporter of record.

#### Choosing an Authentication Method

Choosing an authentication method is important to ensure that
appropriate authorization controls are in place and that created
content is associated with intended user.

#### Single User Access: Basic Authentication

If the API client is always going to interact with the API as the
same user, such as with an automated system, then Basic Authentication
can be used to gain authenticated access to the organizational API.
The user should be configured with an appropriate membership role for
its purpose ("internal only", "manager", etc.).

For the special case of creating an issue, it is possible to use
the organizational API to create an issue on behalf of a different
member of the organization. In this case the API client is recorded
as creating the issue but the other user is recorded as being the
reporter for the issue, which allows the other user to interact
with the issue as if they had created it. This can be particularly
useful for private issues. TODO

#### Multi-User Access: OAuth Authentication

If the API client is going to create or update content on behalf
of multiple organizational users (for example integrating SCF
reporting into another application) where the actual user is available
to login as needed, then OAuth authentication should be used. Details
on establishing an OAuth application ID can be found at
dev.seeclickfix.com. This method is appropriate when the API client
needs to present itself as different users to the API and is more
common when the API client is a website or native app that is being
used by multiple users as opposed to an API client that is being used
by an automated system.

