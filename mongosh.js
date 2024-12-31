// Use the desired database, e.g., 'hackforums'
use hackforums;

// Create 'users' collection with advanced security fields
db.createCollection('users');

// Insert sample data into 'users' collection with secure password and role handling
db.users.insertMany([
  {
    username: "user1",
    email: "user1@example.com",
    password: "$2b$12$XzRlP.I3X6INLkgSHL44s.FlaXJX1Ejkc5HzlDAgxMzMNZcnVf4jm", // bcrypt-hashed password
    role: "user", // 'user' or 'admin'
    status: "active", // 'active' or 'inactive'
    last_login: new Date(),
    created_at: new Date(),
    updated_at: new Date(),
    failed_login_attempts: 0,
    lockout_until: null, // Lockout until date if there are too many failed attempts
    reset_token: null, // Store a token for password reset flow if needed
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

// Create 'admin_actions' collection to log admin actions
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

// Create 'sessions' collection to manage secure user sessions
db.createCollection('sessions');

// Insert sample session data (JWTs or session tokens can be used)
db.sessions.insertOne({
  session_id: "abc123xyz",
  username: "user1",
  logged_in_at: new Date(),
  expires_at: new Date(new Date().getTime() + 1000 * 60 * 60), // 1 hour session expiration
  ip_address: "192.168.1.1",
  user_agent: "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.93 Safari/537.36"
});

// Add collections for tracking failed login attempts and user lockouts
db.createCollection('failed_login_attempts');

// Store failed login attempts to prevent brute force
db.failed_login_attempts.insertMany([
  {
    username: "user1",
    ip_address: "192.168.1.1",
    attempts: 3,
    timestamp: new Date()
  }
]);
