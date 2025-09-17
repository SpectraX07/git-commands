# 👥 Team Git Workflows - Collaborative Development

This exercise simulates real team collaboration scenarios and teaches you how to work effectively with Git in team environments.

## 🎯 Learning Objectives

- Master collaborative Git workflows
- Handle team coordination and conflicts
- Understand different branching strategies
- Practice code review processes
- Learn release management

## 📋 Prerequisites

- Completed [Merge Conflicts](merge-conflicts.md) exercise
- Understanding of branches and merging
- Basic knowledge of remote repositories

## 🏗️ Team Setup Simulation

We'll simulate a team of 4 developers working on a web application:
- **Alice** (Team Lead) - Backend & DevOps
- **Bob** (Frontend Developer) - UI/UX
- **Charlie** (Backend Developer) - API & Database  
- **Diana** (QA Engineer) - Testing & Documentation

## 🚀 Exercise Setup

```bash
mkdir team-project
cd team-project
git init
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

# Create initial project structure
mkdir -p src/{frontend,backend,tests} docs

echo "# Team Project
A collaborative web application

## Team Members
- Alice (Team Lead)
- Bob (Frontend)  
- Charlie (Backend)
- Diana (QA)

## Project Structure
- src/frontend/ - React frontend
- src/backend/ - Node.js API
- src/tests/ - Test suites
- docs/ - Documentation" > README.md

echo "node_modules/
.env
*.log
dist/
build/" > .gitignore

git add .
git commit -m "feat: initial project setup with team structure"
```

## 🌿 Workflow 1: Feature Branch Workflow

### Scenario: Bob works on Frontend Feature

**Step 1: Alice creates development branch**
```bash
git checkout -b develop
git push origin develop  # (simulated)
echo "Development branch created" > develop.md
git add develop.md
git commit -m "chore: create development branch"
```

**Step 2: Bob starts frontend feature**
```bash
# Simulate Bob's work
git config user.name "Bob Frontend"
git config user.email "bob@company.com"

git checkout -b feature/user-interface
echo "import React from 'react';

function App() {
  return (
    <div className=\"App\">
      <header className=\"App-header\">
        <h1>Welcome to Our App</h1>
        <nav>
          <ul>
            <li><a href=\"/home\">Home</a></li>
            <li><a href=\"/about\">About</a></li>
            <li><a href=\"/contact\">Contact</a></li>
          </ul>
        </nav>
      </header>
    </div>
  );
}

export default App;" > src/frontend/App.js

git add src/frontend/App.js
git commit -m "feat(frontend): add main app component with navigation"
```

**Step 3: Bob adds styling**
```bash
echo ".App {
  text-align: center;
}

.App-header {
  background-color: #282c34;
  padding: 20px;
  color: white;
}

nav ul {
  list-style-type: none;
  padding: 0;
}

nav li {
  display: inline;
  margin: 0 10px;
}

nav a {
  color: white;
  text-decoration: none;
}" > src/frontend/App.css

git add src/frontend/App.css
git commit -m "style(frontend): add CSS styling for main app"
```

**Step 4: Bob prepares for merge**
```bash
# Update from develop before merging
git checkout develop
git pull origin develop  # (simulated)

# Merge feature branch
git merge feature/user-interface --no-ff -m "Merge feature/user-interface into develop"

# Clean up feature branch
git branch -d feature/user-interface
```

### Scenario: Charlie works on Backend API

**Step 5: Charlie starts backend work**
```bash
# Simulate Charlie's work
git config user.name "Charlie Backend"
git config user.email "charlie@company.com"

git checkout -b feature/user-api
echo "const express = require('express');
const app = express();
const port = 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/api/users', (req, res) => {
  res.json({
    users: [
      { id: 1, name: 'Alice', role: 'Team Lead' },
      { id: 2, name: 'Bob', role: 'Frontend' },
      { id: 3, name: 'Charlie', role: 'Backend' },
      { id: 4, name: 'Diana', role: 'QA' }
    ]
  });
});

app.post('/api/users', (req, res) => {
  const { name, role } = req.body;
  const newUser = { 
    id: Date.now(), 
    name, 
    role 
  };
  res.status(201).json(newUser);
});

app.listen(port, () => {
  console.log(\`Server running at http://localhost:\${port}\`);
});" > src/backend/server.js

git add src/backend/server.js
git commit -m "feat(backend): add user API endpoints"
```

**Step 6: Charlie adds database configuration**
```bash
echo "const config = {
  development: {
    host: 'localhost',
    port: 5432,
    database: 'team_project_dev',
    username: 'dev_user',
    password: 'dev_password'
  },
  test: {
    host: 'localhost',
    port: 5432,
    database: 'team_project_test',
    username: 'test_user',
    password: 'test_password'
  },
  production: {
    host: process.env.DB_HOST,
    port: process.env.DB_PORT,
    database: process.env.DB_NAME,
    username: process.env.DB_USER,
    password: process.env.DB_PASSWORD
  }
};

module.exports = config;" > src/backend/config.js

git add src/backend/config.js
git commit -m "feat(backend): add database configuration"
```

**Step 7: Merge conflict simulation**
```bash
# Charlie merges his work
git checkout develop
git merge feature/user-api --no-ff -m "Merge feature/user-api into develop"
git branch -d feature/user-api
```

## 🔄 Workflow 2: GitFlow Workflow

### Release Preparation

**Step 1: Alice prepares release**
```bash
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

# Create release branch
git checkout -b release/v1.0.0

# Update version information
echo "# Team Project v1.0.0
A collaborative web application

## Version 1.0.0 Features
- User interface with navigation
- User API endpoints
- Database configuration
- Initial team setup

## Team Members
- Alice (Team Lead)
- Bob (Frontend)  
- Charlie (Backend)
- Diana (QA)

## Project Structure
- src/frontend/ - React frontend
- src/backend/ - Node.js API
- src/tests/ - Test suites
- docs/ - Documentation" > README.md

git add README.md
git commit -m "chore(release): update README for v1.0.0"
```

**Step 2: Diana adds tests**
```bash
git config user.name "Diana QA"
git config user.email "diana@company.com"

echo "const request = require('supertest');
const app = require('../backend/server');

describe('User API', () => {
  test('GET /api/users should return user list', async () => {
    const response = await request(app)
      .get('/api/users')
      .expect(200);
    
    expect(response.body.users).toHaveLength(4);
    expect(response.body.users[0]).toHaveProperty('name', 'Alice');
  });

  test('POST /api/users should create new user', async () => {
    const newUser = {
      name: 'Eve',
      role: 'Designer'
    };

    const response = await request(app)
      .post('/api/users')
      .send(newUser)
      .expect(201);
    
    expect(response.body).toHaveProperty('name', 'Eve');
    expect(response.body).toHaveProperty('role', 'Designer');
    expect(response.body).toHaveProperty('id');
  });
});" > src/tests/api.test.js

git add src/tests/api.test.js
git commit -m "test: add API endpoint tests"
```

**Step 3: Release finalization**
```bash
# Alice finalizes release
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

# Merge release to main
git checkout main
git merge release/v1.0.0 --no-ff -m "Release v1.0.0"

# Tag the release
git tag -a v1.0.0 -m "Release version 1.0.0

Features:
- User interface with navigation
- User API endpoints  
- Database configuration
- API tests"

# Merge back to develop
git checkout develop
git merge release/v1.0.0 --no-ff -m "Merge release v1.0.0 back to develop"

# Clean up release branch
git branch -d release/v1.0.0
```

## 🚨 Workflow 3: Hotfix Workflow

### Emergency Production Fix

**Step 1: Critical bug discovered**
```bash
# Simulate production issue
git checkout main

# Alice creates hotfix
git checkout -b hotfix/security-fix

echo "const express = require('express');
const helmet = require('helmet'); // Security middleware
const app = express();
const port = 3000;

// Security middleware
app.use(helmet());

// Middleware
app.use(express.json({ limit: '10mb' })); // Prevent large payloads
app.use(express.urlencoded({ extended: true, limit: '10mb' }));

// Input validation middleware
const validateUser = (req, res, next) => {
  const { name, role } = req.body;
  if (!name || !role) {
    return res.status(400).json({ error: 'Name and role are required' });
  }
  if (name.length > 100 || role.length > 50) {
    return res.status(400).json({ error: 'Input too long' });
  }
  next();
};

// Routes
app.get('/api/users', (req, res) => {
  res.json({
    users: [
      { id: 1, name: 'Alice', role: 'Team Lead' },
      { id: 2, name: 'Bob', role: 'Frontend' },
      { id: 3, name: 'Charlie', role: 'Backend' },
      { id: 4, name: 'Diana', role: 'QA' }
    ]
  });
});

app.post('/api/users', validateUser, (req, res) => {
  const { name, role } = req.body;
  const newUser = { 
    id: Date.now(), 
    name: name.trim(), // Sanitize input
    role: role.trim()
  };
  res.status(201).json(newUser);
});

app.listen(port, () => {
  console.log(\`Server running at http://localhost:\${port}\`);
});" > src/backend/server.js

git add src/backend/server.js
git commit -m "fix: add security middleware and input validation"
```

**Step 2: Deploy hotfix**
```bash
# Merge to main
git checkout main
git merge hotfix/security-fix --no-ff -m "Hotfix: Security improvements"

# Tag hotfix
git tag -a v1.0.1 -m "Hotfix v1.0.1 - Security improvements"

# Merge to develop
git checkout develop
git merge hotfix/security-fix --no-ff -m "Merge security hotfix to develop"

# Clean up
git branch -d hotfix/security-fix
```

## 🔍 Workflow 4: Code Review Process

### Pull Request Simulation

**Step 1: Bob creates new feature**
```bash
git config user.name "Bob Frontend"
git config user.email "bob@company.com"

git checkout develop
git checkout -b feature/user-profile

echo "import React, { useState, useEffect } from 'react';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(\`/api/users/\${userId}\`)
      .then(response => response.json())
      .then(data => {
        setUser(data);
        setLoading(false);
      })
      .catch(error => {
        console.error('Error fetching user:', error);
        setLoading(false);
      });
  }, [userId]);

  if (loading) {
    return <div>Loading...</div>;
  }

  if (!user) {
    return <div>User not found</div>;
  }

  return (
    <div className=\"user-profile\">
      <h2>{user.name}</h2>
      <p>Role: {user.role}</p>
      <p>ID: {user.id}</p>
    </div>
  );
}

export default UserProfile;" > src/frontend/UserProfile.js

git add src/frontend/UserProfile.js
git commit -m "feat(frontend): add user profile component"
```

**Step 2: Alice reviews code (simulated)**
```bash
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

# Alice suggests improvements
echo "import React, { useState, useEffect } from 'react';
import PropTypes from 'prop-types';

function UserProfile({ userId }) {
  const [user, setUser] = useState(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    const fetchUser = async () => {
      try {
        setLoading(true);
        setError(null);
        const response = await fetch(\`/api/users/\${userId}\`);
        
        if (!response.ok) {
          throw new Error(\`HTTP error! status: \${response.status}\`);
        }
        
        const data = await response.json();
        setUser(data);
      } catch (err) {
        setError(err.message);
        console.error('Error fetching user:', err);
      } finally {
        setLoading(false);
      }
    };

    if (userId) {
      fetchUser();
    }
  }, [userId]);

  if (loading) {
    return <div className=\"loading\">Loading user profile...</div>;
  }

  if (error) {
    return <div className=\"error\">Error: {error}</div>;
  }

  if (!user) {
    return <div className=\"not-found\">User not found</div>;
  }

  return (
    <div className=\"user-profile\">
      <h2>{user.name}</h2>
      <p><strong>Role:</strong> {user.role}</p>
      <p><strong>ID:</strong> {user.id}</p>
    </div>
  );
}

UserProfile.propTypes = {
  userId: PropTypes.oneOfType([
    PropTypes.string,
    PropTypes.number
  ]).isRequired
};

export default UserProfile;" > src/frontend/UserProfile.js

# Bob applies review feedback
git config user.name "Bob Frontend"
git config user.email "bob@company.com"

git add src/frontend/UserProfile.js
git commit -m "refactor(frontend): improve error handling and add PropTypes

- Add proper error handling with try/catch
- Add loading and error states
- Add PropTypes for type checking
- Improve user experience with better messages"
```

**Step 3: Merge approved feature**
```bash
git checkout develop
git merge feature/user-profile --no-ff -m "Merge feature/user-profile

Reviewed-by: Alice <alice@company.com>
- Improved error handling
- Added PropTypes
- Better user experience"

git branch -d feature/user-profile
```

## 📊 Workflow 5: Continuous Integration Simulation

### Automated Testing Workflow

**Step 1: Diana sets up CI configuration**
```bash
git config user.name "Diana QA"
git config user.email "diana@company.com"

mkdir -p .github/workflows

echo "name: CI/CD Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    strategy:
      matrix:
        node-version: [14.x, 16.x, 18.x]
    
    steps:
    - uses: actions/checkout@v3
    
    - name: Use Node.js \${{ matrix.node-version }}
      uses: actions/setup-node@v3
      with:
        node-version: \${{ matrix.node-version }}
        cache: 'npm'
    
    - name: Install dependencies
      run: npm ci
    
    - name: Run linter
      run: npm run lint
    
    - name: Run tests
      run: npm test
    
    - name: Run build
      run: npm run build

  security:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Run security audit
      run: npm audit --audit-level moderate" > .github/workflows/ci.yml

git add .github/workflows/ci.yml
git commit -m "ci: add GitHub Actions CI/CD pipeline"
```

**Step 2: Add package.json for CI**
```bash
echo "{
  \"name\": \"team-project\",
  \"version\": \"1.0.1\",
  \"description\": \"A collaborative web application\",
  \"main\": \"src/backend/server.js\",
  \"scripts\": {
    \"start\": \"node src/backend/server.js\",
    \"dev\": \"nodemon src/backend/server.js\",
    \"test\": \"jest src/tests/\",
    \"lint\": \"eslint src/\",
    \"build\": \"webpack --mode production\",
    \"build:dev\": \"webpack --mode development\"
  },
  \"dependencies\": {
    \"express\": \"^4.18.0\",
    \"helmet\": \"^6.0.0\",
    \"react\": \"^18.2.0\",
    \"react-dom\": \"^18.2.0\"
  },
  \"devDependencies\": {
    \"jest\": \"^29.0.0\",
    \"supertest\": \"^6.3.0\",
    \"eslint\": \"^8.25.0\",
    \"webpack\": \"^5.74.0\",
    \"nodemon\": \"^2.0.20\"
  },
  \"repository\": {
    \"type\": \"git\",
    \"url\": \"https://github.com/team/project.git\"
  },
  \"author\": \"Team Project Contributors\",
  \"license\": \"MIT\"
}" > package.json

git add package.json
git commit -m "chore: add package.json with CI scripts"
```

## 🎯 Team Coordination Strategies

### Strategy 1: Daily Sync Workflow

**Morning Sync Simulation**
```bash
# Each team member syncs with develop
git checkout develop
git pull origin develop

# Check what others have been working on
git log --oneline --since="1 day ago" --author-date-order

# Create daily feature branch
git checkout -b feature/daily-$(date +%Y%m%d)-improvements
```

### Strategy 2: Conflict Prevention

**Setup: Parallel Development**
```bash
# Alice works on documentation
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

git checkout develop
git checkout -b feature/documentation

echo "# API Documentation

## User Endpoints

### GET /api/users
Returns list of all users.

**Response:**
\`\`\`json
{
  \"users\": [
    {
      \"id\": 1,
      \"name\": \"Alice\",
      \"role\": \"Team Lead\"
    }
  ]
}
\`\`\`

### POST /api/users
Creates a new user.

**Request Body:**
\`\`\`json
{
  \"name\": \"string\",
  \"role\": \"string\"
}
\`\`\`

**Response:**
\`\`\`json
{
  \"id\": 123,
  \"name\": \"string\",
  \"role\": \"string\"
}
\`\`\`" > docs/api.md

git add docs/api.md
git commit -m "docs: add API documentation"

# Bob works on frontend at the same time
git config user.name "Bob Frontend"
git config user.email "bob@company.com"

git checkout develop
git checkout -b feature/frontend-improvements

echo ".user-profile {
  max-width: 400px;
  margin: 20px auto;
  padding: 20px;
  border: 1px solid #ddd;
  border-radius: 8px;
  box-shadow: 0 2px 4px rgba(0,0,0,0.1);
}

.user-profile h2 {
  color: #333;
  margin-bottom: 15px;
}

.user-profile p {
  margin: 10px 0;
  color: #666;
}

.loading, .error, .not-found {
  text-align: center;
  padding: 20px;
  margin: 20px;
}

.error {
  color: #d32f2f;
  background-color: #ffebee;
  border: 1px solid #ffcdd2;
  border-radius: 4px;
}

.loading {
  color: #1976d2;
}

.not-found {
  color: #f57c00;
}" > src/frontend/UserProfile.css

git add src/frontend/UserProfile.css
git commit -m "style: add UserProfile component styling"

# Both merge without conflicts (different files)
git checkout develop
git merge feature/documentation --no-ff -m "Merge documentation updates"
git merge feature/frontend-improvements --no-ff -m "Merge frontend styling"

# Clean up
git branch -d feature/documentation feature/frontend-improvements
```

## 📈 Advanced Team Scenarios

### Scenario: Large Feature Coordination

**Step 1: Feature Planning**
```bash
# Alice creates feature epic branch
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

git checkout develop
git checkout -b epic/user-management

echo "# User Management Epic

## Overview
Complete user management system with authentication, profiles, and permissions.

## Sub-features
- [ ] User authentication (Charlie)
- [ ] User profiles (Bob)  
- [ ] Permission system (Alice)
- [ ] User tests (Diana)

## Timeline
- Week 1: Authentication foundation
- Week 2: Profile system
- Week 3: Permissions
- Week 4: Testing & integration" > docs/user-management-epic.md

git add docs/user-management-epic.md
git commit -m "feat: create user management epic plan"
```

**Step 2: Parallel Sub-feature Development**
```bash
# Charlie works on authentication
git config user.name "Charlie Backend"
git config user.email "charlie@company.com"

git checkout epic/user-management
git checkout -b feature/authentication

echo "const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');

class AuthService {
  constructor() {
    this.secretKey = process.env.JWT_SECRET || 'default-secret';
  }

  async hashPassword(password) {
    return await bcrypt.hash(password, 10);
  }

  async comparePassword(password, hash) {
    return await bcrypt.compare(password, hash);
  }

  generateToken(user) {
    return jwt.sign(
      { 
        id: user.id, 
        name: user.name, 
        role: user.role 
      },
      this.secretKey,
      { expiresIn: '24h' }
    );
  }

  verifyToken(token) {
    try {
      return jwt.verify(token, this.secretKey);
    } catch (error) {
      throw new Error('Invalid token');
    }
  }
}

module.exports = AuthService;" > src/backend/auth.js

git add src/backend/auth.js
git commit -m "feat(auth): add authentication service with JWT"

# Merge back to epic branch
git checkout epic/user-management
git merge feature/authentication --no-ff -m "Merge authentication service"
git branch -d feature/authentication
```

### Scenario: Integration and Testing

**Step 3: Integration Testing**
```bash
# Diana adds integration tests
git config user.name "Diana QA"
git config user.email "diana@company.com"

git checkout epic/user-management
git checkout -b feature/integration-tests

echo "const request = require('supertest');
const app = require('../backend/server');
const AuthService = require('../backend/auth');

describe('User Management Integration', () => {
  let authService;
  let userToken;

  beforeAll(() => {
    authService = new AuthService();
  });

  describe('Authentication Flow', () => {
    test('should register new user', async () => {
      const userData = {
        name: 'Test User',
        email: 'test@example.com',
        password: 'password123',
        role: 'User'
      };

      const response = await request(app)
        .post('/api/auth/register')
        .send(userData)
        .expect(201);

      expect(response.body).toHaveProperty('token');
      expect(response.body.user).toHaveProperty('name', 'Test User');
      userToken = response.body.token;
    });

    test('should login existing user', async () => {
      const loginData = {
        email: 'test@example.com',
        password: 'password123'
      };

      const response = await request(app)
        .post('/api/auth/login')
        .send(loginData)
        .expect(200);

      expect(response.body).toHaveProperty('token');
    });

    test('should access protected route with token', async () => {
      const response = await request(app)
        .get('/api/users/profile')
        .set('Authorization', \`Bearer \${userToken}\`)
        .expect(200);

      expect(response.body).toHaveProperty('name', 'Test User');
    });
  });
});" > src/tests/integration.test.js

git add src/tests/integration.test.js
git commit -m "test: add user management integration tests"

# Merge back to epic
git checkout epic/user-management
git merge feature/integration-tests --no-ff -m "Merge integration tests"
git branch -d feature/integration-tests
```

**Step 4: Epic Completion**
```bash
# Alice finalizes epic
git config user.name "Team Lead Alice"
git config user.email "alice@company.com"

# Update epic documentation
echo "# User Management Epic - COMPLETED ✅

## Overview
Complete user management system with authentication, profiles, and permissions.

## Completed Features
- [x] User authentication (Charlie) - JWT-based auth service
- [x] User profiles (Bob) - Profile component with styling
- [x] Permission system (Alice) - Role-based access
- [x] User tests (Diana) - Integration test suite

## Timeline - COMPLETED ON SCHEDULE
- Week 1: Authentication foundation ✅
- Week 2: Profile system ✅
- Week 3: Permissions ✅  
- Week 4: Testing & integration ✅

## Metrics
- 15 commits across 4 developers
- 100% test coverage on new features
- 0 critical security issues
- Ready for production deployment" > docs/user-management-epic.md

git add docs/user-management-epic.md
git commit -m "docs: mark user management epic as completed"

# Merge epic to develop
git checkout develop
git merge epic/user-management --no-ff -m "Epic: Complete user management system

- JWT authentication service
- User profile components  
- Integration test suite
- Comprehensive documentation

Closes #123 #124 #125 #126"

git branch -d epic/user-management
```

## 📊 Team Workflow Metrics

### Measuring Team Effectiveness

```bash
# Generate team statistics
echo "# Team Workflow Analysis

## Commit Statistics
$(git shortlog -sn)

## Branch Activity
$(git for-each-ref --format='%(refname:short) %(committerdate)' refs/heads/ | sort -k2)

## Recent Team Activity
$(git log --oneline --since='1 week ago' --pretty=format:'%h %an %s')

## Code Review Metrics
- Average time to merge: 2 days
- Review participation: 100%
- Merge conflicts: 5% of merges
- Hotfixes this month: 1

## Quality Metrics  
- Test coverage: 85%
- CI/CD success rate: 98%
- Security issues: 0 critical
- Documentation coverage: 90%" > docs/team-metrics.md

git add docs/team-metrics.md
git commit -m "docs: add team workflow metrics and analysis"
```

## 🎯 Best Practices Summary

### **Communication**
- **Daily standups** with Git status updates
- **Clear commit messages** following conventions
- **Code review** for all changes
- **Documentation** for major features

### **Branch Management**
- **Short-lived branches** (< 1 week)
- **Descriptive branch names** with prefixes
- **Regular merging** to avoid conflicts
- **Clean up** merged branches

### **Conflict Prevention**
- **Frequent pulls** from develop/main
- **Small, focused commits**
- **Coordinate** on shared files
- **Use .gitattributes** for merge strategies

### **Quality Assurance**
- **Automated testing** in CI/CD
- **Code review** requirements
- **Security scanning**
- **Performance monitoring**

## 🚀 Next Steps

1. Practice these workflows with a real team
2. Set up actual CI/CD pipelines
3. Explore [Advanced Git Operations](../advanced/)
4. Learn about [Git Hooks](../../templates/hooks/) for automation

---

**Remember**: Successful team Git workflows require clear communication, consistent practices, and the right balance of automation and human oversight.

**Next Exercise**: [Advanced Git Operations →](../advanced/)
