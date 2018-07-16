# Find my Flock

## Technology and Stack
- [PostgreSQL 10.3](https://www.postgresql.org/docs/current/static/release-10-3.html)
- [ruby 2.4.3](https://www.ruby-lang.org/en/news/2017/12/14/ruby-2-4-3-released/)
- [rails 4.2.3](http://guides.rubyonrails.org/v5.2/)
- [stripe](https://stripe.com/docs/api)


## Setup
1. `bundle install` - Install dependencies
1. Get the `master.key` file from another developer and add it to the config/ folder.
1. `bundle exec rake db:create` - Create Postgres database.
1. `bundle exec rake db:setup` - Run the setup script (or `bundle exec ./bin/setup`).

Run the development server and test suite to verify successful deployment. See wiki for QA walkthrough.

## Development server
- `bundle exec rails server`
- View site at `http://localhost:3000/`

## Troubleshooting/OS variances

### Database Setup

#### OSX
  - if `createdb` is not found, you may need to add your Postgres installation to your `$PATH`

#### Linux
  Create the {PROJECT_NAME} user in Postgres

  - `sudo su - postgres`
  - `createuser {PROJECT_NAME}`
  - `createdb -O {PROJECT_NAME} {PROJECT_NAME}`

  Alter the user to have superuser permissions

  - `psql`
  - `ALTER USER {PROJECT_NAME} WITH SUPERUSER;`
  - `\q`
  - `exit`

  Setup postgres so you can authenticate with the account locally

  - In the file `/etc/postgresql/X.Y/main/hb_pga.conf`
    ```
      local  all      all                    trust # replace ident or peer with trust
    ```
  - `/etc/init.d/postgresql reload`

  Uncomment the `DATABASE_USER` key in the `{PROJECT_NAME}/settings.yml` file
