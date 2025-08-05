# Swagger Documentation Guide

## Overview
This project uses **rswag** to provide interactive API documentation with Swagger UI.

## Accessing Swagger Documentation

### Development
- **Swagger UI**: http://localhost:3000/api-docs
- **API Documentation**: http://localhost:3000/api-docs/swagger.json

### Production
- **Swagger UI**: https://your-domain.com/api-docs
- **API Documentation**: https://your-domain.com/api-docs/swagger.json

## Features

### Interactive Documentation
- **Try it out**: Test API endpoints directly from the browser
- **Authentication**: JWT Bearer token support
- **Request/Response Examples**: See actual request and response formats
- **Parameter Validation**: Built-in parameter validation

### API Endpoints Documented

#### Authentication
- `POST /api/v1/auth/register` - Register new user
- `POST /api/v1/auth/login` - User login

#### HS Codes (Read-only)
- `GET /api/v1/hs_codes` - List HS codes with pagination and search
- `GET /api/v1/hs_codes/{id}` - Get specific HS code
- `GET /api/v1/hs_codes/export` - Export HS codes to CSV

#### Health Check
- `GET /api/v1/health` - API health status

## Using Swagger UI

### 1. Authentication
1. First, register a user or login using the authentication endpoints
2. Copy the JWT token from the response
3. Click the "Authorize" button at the top of the page
4. Enter your token in the format: `Bearer YOUR_TOKEN_HERE`
5. Click "Authorize"

### 2. Testing Endpoints
1. Find the endpoint you want to test
2. Click "Try it out"
3. Fill in any required parameters
4. Click "Execute"
5. View the response

### 3. Understanding Responses
- **200**: Success
- **201**: Created (for registration)
- **401**: Unauthorized (invalid or missing token)
- **404**: Not found
- **422**: Validation error

## Configuration

### Swagger Specification
The API documentation is defined in `swagger/swagger.json` and includes:

- **OpenAPI 3.0.0** specification
- **JWT Bearer authentication**
- **Request/Response schemas**
- **Parameter validation**
- **Error responses**

### Rswag Configuration
- **API Engine**: `config/initializers/rswag_api.rb`
- **UI Engine**: `config/initializers/rswag_ui.rb`
- **Routes**: Mounted at `/api-docs`

## Customization

### Adding New Endpoints
1. Update the API endpoint in the appropriate controller
2. Add the endpoint documentation to `swagger/swagger.json`
3. Include request/response schemas
4. Add authentication requirements if needed

### Modifying Schemas
Edit the `components/schemas` section in `swagger/swagger.json` to:
- Add new data models
- Update existing schemas
- Add validation rules

### Styling
Customize the Swagger UI appearance by modifying:
- `config/initializers/rswag_ui.rb`
- CSS overrides in `public/swagger-ui/`

## Development Workflow

### 1. Start the Application
```bash
docker-compose up -d
```

### 2. Access Documentation
```bash
open http://localhost:3000/api-docs
```

### 3. Test Endpoints
- Use the interactive interface to test API functionality
- Verify request/response formats
- Test authentication flows

### 4. Update Documentation
- Modify `swagger/swagger.json` as needed
- Restart the application to see changes

## Best Practices

### Documentation
- Keep endpoint descriptions clear and concise
- Include examples for complex parameters
- Document all possible response codes
- Use consistent naming conventions

### Security
- Always document authentication requirements
- Include security schemes in the specification
- Test authentication flows thoroughly

### Testing
- Use Swagger UI for manual testing during development
- Verify all endpoints work as documented
- Test error scenarios and edge cases

## Troubleshooting

### Common Issues

#### 1. Swagger UI Not Loading
- Check if the application is running
- Verify routes are properly mounted
- Check browser console for errors

#### 2. Authentication Not Working
- Ensure JWT token is valid
- Check token format (Bearer + space + token)
- Verify token hasn't expired

#### 3. Endpoints Not Found
- Check if the API is properly mounted
- Verify endpoint paths match documentation
- Check server logs for errors

### Debugging
- Check Rails logs: `docker-compose logs api`
- Check browser network tab for failed requests
- Verify swagger.json is accessible at `/api-docs/swagger.json`

## Resources

- [OpenAPI Specification](https://swagger.io/specification/)
- [Rswag Documentation](https://github.com/rswag/rswag)
- [Swagger UI](https://swagger.io/tools/swagger-ui/)
- [JWT Authentication](https://jwt.io/) 