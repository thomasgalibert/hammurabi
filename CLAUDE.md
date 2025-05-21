# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Hammurabi is an open-source law firm management system developed primarily in French. It helps lawyers manage cases, client information, invoices, documents, and scheduling.

Key features:
- Case management
- Client information management
- Document handling and sharing
- Invoice generation and payment tracking
- Event scheduling
- Document collection from clients
- Mobile-friendly interface
- GDPR compliance (one-click data anonymization)
- Secure case sharing with colleagues

## Technology Stack

- **Framework**: Ruby on Rails 7.1.2
- **Ruby Version**: 3.3.0
- **Database**: PostgreSQL
- **Frontend**:
  - TailwindCSS
  - Hotwire (Turbo/Stimulus)
- **Authentication**: Custom using `has_secure_password`
- **Other key gems**:
  - money-rails (financial calculations)
  - prawn (PDF generation)
  - view_component (UI components)
  - aasm (state machines)
  - pagy (pagination)
  - simple_calendar (calendar views)
  - icalendar (calendar export)

## Common Commands

### Setup and Running

```bash
# Install dependencies
bundle install

# Setup database
bin/rails db:setup

# Run development server with hot reloading
bin/dev
```

The `bin/dev` command (using Procfile.dev) runs both the Rails server and TailwindCSS compiler.

### Testing

```bash
# Run all tests
bin/rails test

# Run specific test file
bin/rails test test/models/dossier_test.rb

# Run system tests
bin/rails test:system
```

Tests use MiniTest with FactoryBot for test data generation.

### Database Operations

```bash
# Run migrations
bin/rails db:migrate

# Reset database
bin/rails db:reset

# Create seed data
bin/rails db:seed
```

### Console

```bash
# Start Rails console
bin/rails console
```

### Docker

The application includes Docker support for deployment:

```bash
# Build Docker image
docker build -t hammurabi .

# Run container
docker run -p 3000:3000 hammurabi
```

## Architecture

### Core Models

- **User**: Authentication and firm information
- **Dossier**: Main case entity that tracks legal cases
- **Contact**: Client and other party information
- **Facture**: Invoice management with state tracking
- **Document**: Document management and sharing
- **Event**: Case-related events and scheduling
- **Todo**: Task management
- **Convention**: Billing agreements
- **Conclusion**: Legal conclusions

### Key File Locations

- Routes: Split across multiple files in `config/routes/*.rb` for better organization
- Models: Standard Rails patterns with concerns for shared functionality
- Controllers: Organized by feature area with namespaces (dashboard/, sharing/)
- Views: Follow standard Rails patterns with components
- Components: View components in `app/components/`
- Localization: French-first in `config/locales/`

### Authorization

Authentication is handled through a custom concern in `app/controllers/concerns/authentication.rb`. The system uses Rails' built-in `has_secure_password` with BCrypt.

### PDF Generation

Invoice PDFs and other documents are generated using Prawn. PDF generation logic is in the `app/pdfs/` directory.

## Development Notes

- The application is primarily in French, including most models, views, and localization files
- Routes are organized into separate files (in `config/routes/`) by feature area
- View components are used extensively for UI elements