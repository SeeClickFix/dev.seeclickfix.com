---
title: Organization Members | GitHub API
---

# Org Members API

* TOC
{:toc}

## Members list

List all users who are members of an organization. A member is a user
that belongs to at least 1 team in the organization. If the authenticated user is also a member of this organization then both concealed and public members will be returned. If the requester is not a member of the organization the query will be redirected to the [public members list](#public-members-list).

    GET /orgs/:org/members

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

### Response if requester is not an organization member

<%= headers 302, "Location" => "https://api.github.com/orgs/github/public_members" %>

## Check membership

Check if a user is, publicly or privately, a member of the organization.

    GET /orgs/:org/members/:user

### Response if requester is an organization member and user is a member

<%= headers 204 %>

### Response if requester is an organization member and user is not a member

<%= headers 404 %>

### Response if requester is not an organization member and is inquiring about themselves

<%= headers 404 %>

### Response if requester is not an organization member

<%= headers 302, :Location => "https://api.github.com/orgs/github/public_members/pezra" %>

## Add a member

To add someone as a member to an org, you must add them to a
[team](/v3/orgs/teams/#add-team-member).

## Remove a member

Removing a user from this list will remove them from all teams and
they will no longer have any access to the organization's repositories.

    DELETE /orgs/:org/members/:user

### Response

<%= headers 204 %>

## Public members list

Members of an organization can choose to have their membership
publicized or not.

    GET /orgs/:org/public_members

### Response

<%= headers 200 %>
<%= json(:user) { |h| [h] } %>

## Check public membership

    GET /orgs/:org/public_members/:user

### Response if user is a public member

<%= headers 204 %>

### Response if user is not a public member

<%= headers 404 %>

## Publicize a user's membership

    PUT /orgs/:org/public_members/:user

### Response

<%= headers 204 %>

## Conceal a user's membership

    DELETE /orgs/:org/public_members/:user

### Response

<%= headers 204 %>
