CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  username VARCHAR(50),
  email VARCHAR(100) UNIQUE,
  password TEXT,
  role VARCHAR(10) DEFAULT 'user',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE ads (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  title VARCHAR(150),
  description TEXT,
  category VARCHAR(50),
  price DECIMAL,
  might INTEGER,
  castle_level INTEGER,
  vip_level INTEGER,
  images TEXT[],
  status VARCHAR(20) DEFAULT 'active',
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE reports (
  id SERIAL PRIMARY KEY,
  ad_id INTEGER REFERENCES ads(id),
  reason TEXT,
  created_at TIMESTAMP DEFAULT NOW()
);
