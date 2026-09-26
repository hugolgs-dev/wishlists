## Wishlists

A simple app to manage the Christmas' wishlist of my family. Everyone keeps their own list, browses the others' lists, and show which items where bought to avoid duplicates, without the owner of the list ever seeing who bought what. 

## Stack

- **Flutter**: Android app and web app (installable as a PWA on iPhone)
- **Serverpod 4**: Dart backend, email sign-in, generated typed client
- **PostgreSQL**: embedded in development and tests, no Docker needed

| Folder | Contents |
|---|---|
| `wishlist_server/` | Serverpod server: models (`.spy.yaml`), endpoints, tests |
| `wishlist_client/` | Client generated from the server. Never edit by hand |
| `wishlist_flutter/` | Flutter app |

## Getting started

Requirements: Flutter (stable) and the Serverpod CLI:

```sh
dart pub global activate serverpod_cli 4.0.2
# make sure ~/.pub-cache/bin is on your PATH
```

`wishlist_server/config/passwords.yaml` is not committed. Create it with these
keys under `development:` and `test:` (random strings, except `familyEmails`):

```yaml
development:
  database: ...
  emailSecretHashPepper: ...
  jwtHmacSha512PrivateKey: ...
  jwtRefreshTokenHashPepper: ...
  # Only these emails can create an account (comma-separated)
  familyEmails: 'me@example.com,mum@example.com'
```

Then start everything (server, database, Flutter web app) with hot reload:

```sh
cd wishlist_server
serverpod start
```

In development, sign-up verification codes are printed in the server console
instead of being emailed.

## Tests

```sh
cd wishlist_server && dart test     # endpoints, visibility rules, claims
cd wishlist_flutter && flutter test # app logic

## License

All rights reserved. See [LICENSE](LICENSE)
