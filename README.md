# Simple Microservices Architecture

A Node.js microservices application with two services (User Service and Product Service), orchestrated with Docker Compose and accessed through an Nginx API Gateway.

## 📋 Architecture Overview

```
                    ┌─────────────────┐
                    │  Nginx Gateway  │
                    │   (Port 80)     │
                    └────────┬────────┘
                             │
                ┌────────────┴────────────┐
                │                         │
       ┌────────▼────────┐      ┌────────▼────────┐
       │  User Service   │      │ Product Service │
       │   (Port 3001)   │      │   (Port 3002)   │
       └─────────────────┘      └─────────────────┘
```

## 🚀 Services

### 1. User Service (Port 3001)

Manages user data with CRUD operations.

**Endpoints:**

- `POST /api/users` - Create a new user
- `GET /api/users/:id` - Get user by ID
- `PUT /api/users/:id` - Update user by ID
- `DELETE /api/users/:id` - Delete user by ID
- `GET /api/users` - Get all users

### 2. Product Service (Port 3002)

Manages product catalog with CRUD operations.

**Endpoints:**

- `POST /api/products` - Create a new product
- `GET /api/products` - Get all products (with optional filters)
- `GET /api/products/:id` - Get product by ID
- `PUT /api/products/:id` - Update product by ID
- `DELETE /api/products/:id` - Delete product by ID

### 3. Nginx API Gateway (Port 80)

Routes requests to appropriate microservices.

## 📦 Prerequisites

- Docker (version 20.x or higher)
- Docker Compose (version 2.x or higher)

## 🛠️ Installation & Setup

1. **Clone or navigate to the project directory:**

   ```bash
   cd /Users/vatsalgajjar/Downloads/simple-micro
   ```

2. **Build and start all services:**

   ```bash
   docker-compose up --build
   ```

3. **Run in detached mode (background):**

   ```bash
   docker-compose up -d --build
   ```

4. **Check service status:**

   ```bash
   docker-compose ps
   ```

5. **View logs:**

   ```bash
   # All services
   docker-compose logs -f

   # Specific service
   docker-compose logs -f user-service
   docker-compose logs -f product-service
   docker-compose logs -f nginx-gateway
   ```

6. **Stop all services:**
   ```bash
   docker-compose down
   ```

## 🧪 Testing the API

### Gateway Health Check

```bash
curl http://localhost/health
```

### User Service Examples

**1. Create a User**

```bash
curl -X POST http://localhost/api/users \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Doe",
    "email": "john@example.com",
    "age": 30
  }'
```

**2. Get All Users**

```bash
curl http://localhost/api/users
```

**3. Get User by ID**

```bash
# Replace {user-id} with actual ID from create response
curl http://localhost/api/users/{user-id}
```

**4. Update User**

```bash
curl -X PUT http://localhost/api/users/{user-id} \
  -H "Content-Type: application/json" \
  -d '{
    "name": "John Smith",
    "age": 31
  }'
```

**5. Delete User**

```bash
curl -X DELETE http://localhost/api/users/{user-id}
```

### Product Service Examples

**1. Create a Product**

```bash
curl -X POST http://localhost/api/products \
  -H "Content-Type: application/json" \
  -d '{
    "name": "Laptop",
    "description": "High-performance laptop",
    "price": 999.99,
    "stock": 50
  }'
```

**2. Get All Products**

```bash
curl http://localhost/api/products
```

**3. Get Products with Filters**

```bash
# Filter by price range
curl "http://localhost/api/products?minPrice=100&maxPrice=1000"

# Filter by in-stock items
curl "http://localhost/api/products?inStock=true"
```

**4. Get Product by ID**

```bash
# Replace {product-id} with actual ID from create response
curl http://localhost/api/products/{product-id}
```

**5. Update Product**

```bash
curl -X PUT http://localhost/api/products/{product-id} \
  -H "Content-Type: application/json" \
  -d '{
    "price": 899.99,
    "stock": 45
  }'
```

**6. Delete Product**

```bash
curl -X DELETE http://localhost/api/products/{product-id}
```

## 📁 Project Structure

```
simple-micro/
├── user-service/
│   ├── server.js           # User service application
│   ├── package.json        # Dependencies
│   ├── Dockerfile          # User service Docker image
│   └── .dockerignore
├── product-service/
│   ├── server.js           # Product service application
│   ├── package.json        # Dependencies
│   ├── Dockerfile          # Product service Docker image
│   └── .dockerignore
├── nginx/
│   ├── nginx.conf          # Nginx configuration
│   └── Dockerfile          # Nginx Docker image
├── docker-compose.yml      # Orchestration configuration
└── README.md               # This file
```

## 🔧 Configuration

### Environment Variables

**User Service:**

- `PORT` - Service port (default: 3001)
- `NODE_ENV` - Environment mode (production/development)

**Product Service:**

- `PORT` - Service port (default: 3002)
- `NODE_ENV` - Environment mode (production/development)

### Port Mapping

- Gateway (Nginx): `http://localhost:80`
- User Service (direct): `http://localhost:3001`
- Product Service (direct): `http://localhost:3002`

## 🌐 API Routes

All requests go through the Nginx gateway at `http://localhost`:

| Endpoint          | Service         | Description                  |
| ----------------- | --------------- | ---------------------------- |
| `/api/users/*`    | User Service    | User management endpoints    |
| `/api/products/*` | Product Service | Product management endpoints |
| `/health`         | Gateway         | Gateway health check         |

## 💡 Features

- ✅ RESTful API design
- ✅ In-memory data storage (simple implementation)
- ✅ Input validation
- ✅ Error handling
- ✅ Health check endpoints
- ✅ Docker containerization
- ✅ Nginx API Gateway
- ✅ Service orchestration with Docker Compose
- ✅ Network isolation

## 🐛 Troubleshooting

**Services not starting:**

```bash
# Check logs
docker-compose logs

# Rebuild from scratch
docker-compose down -v
docker-compose up --build
```

**Port already in use:**

```bash
# Find process using port 80
lsof -i :80

# Or modify ports in docker-compose.yml
```

**Cannot connect to services:**

```bash
# Verify all containers are running
docker-compose ps

# Check network connectivity
docker network ls
docker network inspect simple-micro_microservices-network
```

## 📝 Notes

- Data is stored in-memory and will be lost when containers restart
- For production use, integrate a database (MongoDB, PostgreSQL, etc.)
- Add authentication/authorization for production deployment
- Implement rate limiting and request logging
- Add API documentation with Swagger/OpenAPI

## 🎯 Next Steps

1. Add database persistence (MongoDB/PostgreSQL)
2. Implement authentication (JWT)
3. Add request logging and monitoring
4. Implement inter-service communication
5. Add unit and integration tests
6. Set up CI/CD pipeline
7. Add API documentation with Swagger

## 📄 License

MIT License - feel free to use this project for learning and development.
