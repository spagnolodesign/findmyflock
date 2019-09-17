# Find My Flock

A culture-centric tech job search engine SAS.

## Technology and Stack
- [PostgreSQL 10.4](https://www.postgresql.org/docs/current/static/release-10-4.html)
- [ruby 2.4.3](https://www.ruby-lang.org/en/news/2017/12/14/ruby-2-4-3-released/)
- [rails 5.2](http://guides.rubyonrails.org/v5.2/)
- [stripe](https://stripe.com/docs/api)
- [npm](https://www.npmjs.com/get-npm)
- [node](https://nodejs.org/) (see `.nvmrc` for version)
- [yarn](https://yarnpkg.com/en/docs/install)

## Setup
1. `bundle install` - Install ruby dependencies
1. `nvm use` - Verify you are using the correct version of Node.
1. `yarn` - Install javscript dependencies
1. Get the `master.key` file from another developer and add it to the config/ folder.
1. `bundle exec rails db:create db:migrate` - Create Postgres database and migrate.
1. `bundle exec rails db:seed` - Seed database.

Run the development server and test suite to verify successful deployment. [See wiki for QA walkthrough](https://github.com/findmyflock/www/wiki/Manual-Testing-QA-Checklist).

## Development server
- `bundle exec rails server`
- View site at `http://localhost:3000/`
- Use test accounts: `dev@example.com`, `recruiter@example.com`, and `admin@findmyflock.com` with password `password`

## Testing
- `bundle exec rails test`

## Development Process
- See [PROCESS](PROCESS.md)
- Follow this [style guide](https://github.com/bbatsov/ruby-style-guide)
