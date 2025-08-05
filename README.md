## Description

This API provides functionalities to manage HS Codes (Harmonized System Codes) and user favorites. It allows users to register, login, browse HS codes with pagination and search, and manage their favorite HS codes.

## Features

- **User Authentication:**
  - Register new users.
  - Login with existing credentials.
  - JWT (JSON Web Token) based authentication for secure access to protected endpoints.
- **HS Code Management:**
  - Retrieve a list of HS Codes with pagination and search.
  - Retrieve details of a specific HS Code.
- **User Favorites:**
  - Add HS codes to user's favorites.
  - Retrieve a list of user's favorite HS codes with pagination.
  - Check if a specific HS code is favorited by the user.
  - Remove HS codes from user's favorites.

## Setup

### Prerequisites

Make sure you have the following installed:

- Ruby (version specified in `.ruby-version`)
- Rails (version specified in `Gemfile.lock`)
- PostgreSQL

### Installation

1.  Clone the repository:

    ```bash
    git clone <repository_url>
    cd hs_code_api
    ```

2.  Install dependencies:

    ```bash
    bundle install
    ```

3.  Database configuration:

    - Configure the database connection in `config/database.yml`.

4.  Create and migrate the database:

    ```bash
    rails db:create
    rails db:migrate
    ```

5.  Seed the database (optional):

    ```bash
    rails db:seed
    ```

### Running the application

```bash
rails server
```

The API will be available at `http://localhost:3000`.

## API Endpoints

### Authentication

- `POST /api/v1/auth/register`: Register a new user.
- `POST /api/v1/auth/login`: Login an existing user.

### HS Codes

- `GET /api/v1/hs_codes`: Retrieve a list of HS codes with pagination and optional search.
  - Parameters:
    - `page` (optional): Page number for pagination.
    - `per_page` (optional): Number of items per page.
    - `search` (optional): Search term to filter HS codes.
- `GET /api/v1/hs_codes/{id}`: Retrieve a specific HS code by ID.

### Favorites

- `GET /api/v1/favourites`: Retrieve the list of the current user's favorite HS codes. Requires authentication.
  - Parameters:
    - `page` (optional): Page number for pagination.
    - `per_page` (optional): Number of items per page.
- `POST /api/v1/favourites`: Add an HS code to the current user's favorites. Requires authentication.
  - Request body:
    ```json
    {
      "hs_code_id": 123
    }
    ```
- `GET /api/v1/favourites/{hs_code_id}`: Check if an HS code is in the current user's favorites. Requires authentication.
- `DELETE /api/v1/favourites/{hs_code_id}`: Remove an HS code from the current user's favorites. Requires authentication.

### Authentication

To access protected endpoints (e.g., favorites), you need to provide a valid JWT in the `Authorization` header.

Example:

```
Authorization: Bearer <your_jwt_token>
```

## Testing

To run the test suite, execute:

```bash
bundle exec rspec
```

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/your-username/your-repo).

## License

The project is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
