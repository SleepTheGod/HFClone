// Connect to MongoDB and switch to 'hackforums' database
use hackforums;

// Create 'users' collection
db.createCollection('users');

// Insert users with secure bcrypt-hashed passwords
db.users.insertMany([
  {
    username: "user1",
    email: "user1@example.com",
    password: "$2b$12$XzRlP.I3X6INLkgSHL44s.FlaXJX1Ejkc5HzlDAgxMzMNZcnVf4jm", // bcrypt-hashed password
    role: "user",
    status: "active",
    last_login: new Date(),
    created_at: new Date(),
    updated_at: new Date(),
    failed_login_attempts: 0,
    lockout_until: null,
    reset_token: null,
    reset_token_expiry: null
  },
  {
    username: "user2",
    email: "user2@example.com",
    password: "$2b$12$XzRlP.I3X6INLkgSHL44s.FlaXJX1Ejkc5HzlDAgxMzMNZcnVf4jm", // bcrypt-hashed password
    role: "user",
    status: "inactive",
    last_login: null,
    created_at: new Date(),
    updated_at: new Date(),
    failed_login_attempts: 0,
    lockout_until: null,
    reset_token: null,
    reset_token_expiry: null
  }
]);

// Create 'admin_actions' collection
db.createCollection('admin_actions');

// Insert sample admin actions
db.admin_actions.insertMany([
  {
    action: "Deactivate User",
    target_username: "user2",
    performed_by: "admin1",
    timestamp: new Date(),
    description: "Deactivated user due to inactivity"
  },
  {
    action: "Activate User",
    target_username: "user1",
    performed_by: "admin1",
    timestamp: new Date(),
    description: "Activated user"
  }
]);

// Create 'sessions' collection
db.createCollection('sessions');

// Insert sample session data
db.sessions.insertOne({
  session_id: "abc123xyz",
  username: "user1",
  logged_in_at: new Date(),
  expires_at: new Date(new Date().getTime() + 1000 * 60 * 60), // 1 hour session expiration
  ip_address: "192.168.1.1",
  user_agent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
});

// Create 'failed_login_attempts' collection
db.createCollection('failed_login_attempts');

// Insert sample failed login attempts
db.failed_login_attempts.insertMany([
  {
    username: "user1",
    ip_address: "192.168.1.1",
    attempts: 3,
    timestamp: new Date()
  }
]);

// Logging and monitoring functions
function logAction(action, details) {
  const log = {
    action,
    details,
    timestamp: new Date()
  };
  db.logs.insertOne(log);
}

// Example: Log a failed login attempt
logAction("Failed Login", { username: "user1", ip_address: "192.168.1.1" });
