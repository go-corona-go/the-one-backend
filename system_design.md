# Backend System Design for WFTO Covid PPE App.

## Requirement Spec
TBD - Link to the requirement spec - put that also in this repo.

## High Level Design

1. Introduce a GraphQL Server on top of Hasura GraphQL Engine.
2. Seller logs into the system with google sign in using Auth0.
3. WFTO Admin logs into the admin portal using Auth0.
4. Buyer has anonymous Login.
5. All the CRUD operations are served by the Hasura Server Directly.
6. A custom server for sending emails, uploading images for reciept and seller suggestions on each buyer order.

## Database Design

TBD - ER Diagram for the system.

