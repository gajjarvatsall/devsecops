const express = require('express');
const bodyParser = require('body-parser');
const { v4: uuidv4 } = require('uuid');

const app = express();
const PORT = process.env.PORT || 3002;

app.use(bodyParser.json());

// In-memory database
let products = [];

// Health check endpoint
app.get('/health', (req, res) => {
  res.json({ status: 'UP', service: 'product-service' });
});

// GET all products
app.get('/products', (req, res) => {
  res.json({
    total: products.length,
    products
  });
});

// GET product by ID
app.get('/products/:id', (req, res) => {
  const { id } = req.params;
  const product = products.find(p => p.id === id);

  if (!product) {
    return res.status(404).json({ error: 'Product not found' });
  }

  res.json(product);
});

// POST - Create a new product
app.post('/products', (req, res) => {
  const { name, description, price, stock } = req.body;
  
  if (!name || !price) {
    return res.status(400).json({ error: 'Name and price are required' });
  }

  const product = {
    id: uuidv4(),
    name,
    description: description || '',
    price: parseFloat(price),
    stock: stock || 0,
    createdAt: new Date().toISOString()
  };

  products.push(product);
  res.status(201).json({
    message: 'Product created successfully',
    product
  });
});

app.listen(PORT, () => {
  console.log(`Product Service running on port ${PORT}`);
});
