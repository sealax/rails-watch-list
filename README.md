# Rails Watch List

A Rails app for building named movie watch lists. Movies are seeded from TMDb,
lists can have uploaded photos through Active Storage, and bookmarks connect
movies to lists with a short comment.

## Requirements

- Ruby 3.3.5
- Rails 8.1.3
- PostgreSQL
- A TMDb API read access token for `db:seed`

## Setup

Install dependencies:

```sh
bundle install
```

Create and prepare the database:

```sh
bin/rails db:prepare
```

To seed movies from TMDb, set `TMDB_API_READ_ACCESS_TOKEN` in your shell or in a
local `.env` file:

```sh
TMDB_API_READ_ACCESS_TOKEN=your_token_here
bin/rails db:seed
```

Start the app:

```sh
bin/rails server
```

The app is available at `http://localhost:3000`.

## Tests And Checks

Run the RSpec suite:

```sh
bundle exec rspec
```

Run the full project checks:

```sh
bin/ci
```
