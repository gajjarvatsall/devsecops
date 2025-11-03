const express = require("express");
const bodyParser = require("body-parser");
const { v4: uuidv4 } = require("uuid");

const app = express();
const PORT = process.env.PORT || 3001;

app.use(bodyParser.json());

// In-memory database
let users = [];

// Health check endpoint
app.get("/health", (req, res) => {
  res.json({ status: "UP", service: "user-service" });
});

// GET all users
app.get("/users", (req, res) => {
  res.json({
    total: users.length,
    users,
  });
});

// GET user by ID
app.get("/users/:id", (req, res) => {
  const { id } = req.params;
  const user = users.find((u) => u.id === id);

  if (!user) {
    return res.status(404).json({ error: "User not found" });
  }

  res.json(user);
});

// POST - Create a new user
app.post("/users", (req, res) => {
  const { name, email, age } = req.body;

  if (!name || !email) {
    return res.status(400).json({ error: "Name and email are required" });
  }

  const user = {
    id: uuidv4(),
    name,
    email,
    age: age || null,
    createdAt: new Date().toISOString(),
  };

  users.push(user);
  res.status(201).json({
    message: "User created successfully",
    user,
  });
});

app.listen(PORT, () => {
  console.log(`User Service running on port ${PORT}`);
});
