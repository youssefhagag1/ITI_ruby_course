# Store

A simple e-commerce Rails application built by following the [Rails Getting Started Guide](https://guides.rubyonrails.org/getting_started.html), up to and including the **"Showing Links for Authenticated Users Only"** section.

## Features Implemented

- **Product CRUD** — list, show, create, edit, and delete products
- **Authentication** — built-in Rails authentication generator (`rails generate authentication`)
- **Authorization** — unauthenticated users can browse products; only logged-in users can create, edit, or delete
- **Conditional UI** — New Product / Edit / Delete links and the Log Out button are shown only to authenticated users

## Setup & Running

### Prerequisites

- Ruby 3.2+
- Rails 8.1+
- SQLite3

### Installation

```bash
# Install dependencies
bundle install

# Set up the database
bin/rails db:create db:migrate db:seed

# Start the server
bin/rails server
```

Then open http://localhost:3000 in your browser.

### Default Credentials (from seeds.rb)

| Email                 | Password |
|-----------------------|----------|
| admin@example.com     | password |

## Guide Sections Covered

1. Introduction & Rails Philosophy
2. Creating a New Rails App
3. Hello, Rails! (MVC basics)
4. Creating a Database Model (Product)
5. Database Migrations
6. Rails Console
7. Active Record Model Basics (CRUD, validations)
8. A Request's Journey Through Rails
9. Routes (`resources :products`, `resource :session`)
10. Controllers & Actions (index, show, new, create, edit, update, destroy)
11. Adding Authentication (`rails generate authentication`)
12. Adding Log Out
13. Allowing Unauthenticated Access (`allow_unauthenticated_access only: %i[ index show ]`)
14. **Showing Links for Authenticated Users Only** (`<% if authenticated? %>`)

## Key Files

| File | Description |
|------|-------------|
| `app/models/product.rb` | Product model with validations |
| `app/models/user.rb` | User model with `has_secure_password` |
| `app/models/session.rb` | Session model |
| `app/models/current.rb` | CurrentAttributes for thread-safe current user |
| `app/controllers/products_controller.rb` | Full CRUD for products |
| `app/controllers/sessions_controller.rb` | Login / logout |
| `app/controllers/concerns/authentication.rb` | Authentication concern |
| `app/views/layouts/application.html.erb` | Layout with conditional nav links |
| `app/views/products/` | All product views |
| `app/views/sessions/new.html.erb` | Login form |
| `config/routes.rb` | Routes: resources :products, resource :session |
| `db/migrate/` | Migrations for products, users, sessions |
| `db/seeds.rb` | Seeds admin user + sample products |
