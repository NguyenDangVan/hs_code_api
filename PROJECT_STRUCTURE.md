# HS Code API - Project Structure

## Overview
This is a Rails API application for managing HS (Harmonized System) codes with authentication, read-only operations, search functionality, and export capability.

## Project Structure

### API Layer (`app/api/v1/`)
- **`base.rb`** - Main Grape API class with global error handling and endpoint mounting
- **`auth.rb`** - Authentication endpoints (register, login)
- **`hs_codes.rb`** - HS Code read operations and search functionality

### Models (`app/models/`)
- **`user.rb`** - User model with bcrypt authentication
- **`hs_code.rb`** - HS Code model with validations and scopes

### Services (`app/services/`)
- **`crawler_service.rb`** - Web scraping service for external HS code data

### Serializers (`app/serializers/`)
- **`user_serializer.rb`** - JSON serialization for User objects
- **`hs_code_serializer.rb`** - JSON serialization for HS Code objects

### Workers (`app/workers/`)
- **`export_hs_codes_worker.rb`** - Sidekiq worker for background CSV exports

### Library (`app/lib/`)
- **`jwt_service.rb`** - JWT token encoding/decoding service
- **`jwt_middleware.rb`** - Authentication middleware for API requests

## Key Features

### Authentication
- JWT-based authentication
- User registration and login
- Secure password handling with bcrypt

### HS Code Management
- Read-only operations for HS codes
- Search functionality with pagination
- Category-based filtering
- Export functionality via CSV

### Background Processing
- Sidekiq for asynchronous job processing
- Export operations run in background
- Redis for job queue management

### API Documentation
- Grape Swagger integration
- Interactive API documentation
- Parameter validation and error handling

## Configuration Files

### Application Configuration
- **`config/application.rb`** - Rails application configuration
- **`config/routes.rb`** - API route mounting
- **`config/sidekiq.yml`** - Sidekiq configuration

### Initializers
- **`config/initializers/grape.rb`** - Grape API configuration
- **`config/initializers/cors.rb`** - CORS configuration

## Dependencies

### Core Gems
- `rails` - Web framework
- `grape` - API framework
- `grape-swagger` - API documentation
- `jwt` - JSON Web Tokens
- `bcrypt` - Password hashing
- `sidekiq` - Background job processing
- `kaminari` - Pagination
- `smarter_csv` - CSV processing
- `jsonapi-serializer` - JSON serialization
- `rack-cors` - CORS support

### Development/Test Gems
- `rspec-rails` - Testing framework
- `factory_bot_rails` - Test data factories
- `faker` - Test data generation
- `brakeman` - Security analysis
- `rubocop-rails-omakase` - Code linting

## API Endpoints

### Authentication
- `POST /api/v1/auth/register` - User registration
- `POST /api/v1/auth/login` - User login

### HS Codes
- `GET /api/v1/hs_codes` - List HS codes with pagination and search
- `GET /api/v1/hs_codes/:id` - Get specific HS code
- `GET /api/v1/hs_codes/export` - Export HS codes to CSV

### Health Check
- `GET /api/v1/health` - API health status

## Getting Started

1. Install dependencies: `bundle install`
2. Setup database: `rails db:create db:migrate`
3. Start Redis server
4. Start Sidekiq: `bundle exec sidekiq`
5. Start Rails server: `rails server`
6. Access API documentation: `http://localhost:3000/api/v1/swagger_doc`

## Architecture Patterns

- **Service Layer Pattern** - Business logic separated into service classes
- **Worker Pattern** - Background processing with Sidekiq
- **Serializer Pattern** - JSON response formatting
- **Middleware Pattern** - Authentication and CORS handling
- **Repository Pattern** - Data access abstraction in models 