# Blog App – Day 4 Lab Solution

A Ruby on Rails application covering all Day 4 requirements.

---

## Features

| User Story | Implementation |
|---|---|
| Login / Logout | `SessionsController` + `has_secure_password` |
| Register | `UsersController#create` |
| Write multiple articles | `ArticlesController#create`, `User has_many :articles` |
| Read any public article | `ArticlesController#index` & `#show` (no auth required) |
| Read/edit/delete own articles only | `before_action :require_owner` guard |
| Add image to article | `has_one_attached :image` (Active Storage) |
| Report others' articles | `POST /articles/:id/report` increments `reports_count` |
| Auto-archive at 3 reports | `after_update :archive_if_over_reported` callback |
| **BONUS** Rake task – delete at 6 reports | `bin/rails articles:remove_over_reported` |
| **BONUS** Whenever cron every 5 min | `config/schedule.rb` |

---

## Setup

```bash
# 1. Install dependencies
bundle install

# 2. Set up Active Storage (creates 3 tables)
bin/rails active_storage:install

# 3. Run all migrations
bin/rails db:migrate

# 4. Start the server
bin/rails server
```

## Running the Rake Task Manually

```bash
bin/rails articles:remove_over_reported
```

## Setting Up the Cron Job (Bonus – Whenever gem)

```bash
# Write crontab entries (run once)
whenever --update-crontab

# Verify
crontab -l
```

---

## Key Files

```
app/
  models/
    user.rb          # has_secure_password, validations
    article.rb       # scopes, after_update callback, has_one_attached :image
  controllers/
    application_controller.rb   # current_user, require_login helpers
    sessions_controller.rb      # login / logout
    users_controller.rb         # register
    articles_controller.rb      # CRUD + report action
  views/
    sessions/new.html.erb
    users/new.html.erb
    articles/                   # index, show, new, edit, _form
config/
  routes.rb
  schedule.rb        # Whenever cron config (BONUS)
lib/tasks/
  articles.rake      # remove_over_reported rake task (BONUS)
db/migrate/
  *_create_users.rb
  *_create_articles.rb
```
