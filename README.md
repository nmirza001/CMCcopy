# Choose My College (CMC)

A Java application to help students find and compare colleges that match their preferences

## Overview

Choose My College (CMC) is a comprehensive Java application developed for CSCI 230: Software Development at the College of Saint Benedict / Saint John's University (Spring 2025). The application provides students with a powerful tool to search, compare, and manage university data to help them make informed college decisions.

CMC offers two interfaces:
- **Console-based interface** for quick, command-line usage
- **Web-based interface** for a more visual experience

## Features

### For Students

- **Search universities** by state, location type, control type, and student population
- **View detailed university profiles** including location, academics, admissions, and campus life metrics
- **Save favorite schools** for later comparison
- **Find similar schools** based on a sophisticated algorithm matching:
  - State
  - Location (urban/suburban/rural)
  - Control type (public/private)
  - Student body size (±25%)
  - SAT scores (±75 points)
  - Acceptance rate (±15%)
  - Academic quality (±1 point)

### For Administrators

- **Manage users:** Add, deactivate, reactivate, or remove user accounts
- **Manage universities:** Add, edit, or remove university profiles
- **Extended university data:** Maintain links to university websites and images

## Project Architecture

CMC follows an MVC-inspired architecture with clean separation of concerns:

```
CMC/
├── src/
│   └── main/
│       └── java/
│           └── cmc/
│               ├── backend/            # Model & Controller components
│               │   ├── controllers/    # Database interface and mock controllers
│               │   └── entities/       # Domain objects (University, User, etc.)
│               ├── frontend/           # View components
│               └── CMCException.java   # Custom exception handling
├── test/                 # Comprehensive test suite
│   ├── backend/          # Unit tests for backend components
│   ├── regression/       # Regression tests for bug fixes
│   └── userstory/        # Tests verifying user story implementation
└── webapp/               # Web interface components (JSP, CSS)
```

## Similarity Matching

One of CMC's most powerful features is its ability to find similar universities. A school is considered similar if it matches at least 3 out of 7 key criteria:

1. Same state
2. Similar location (urban/suburban/rural)
3. Same control type (public/private)
4. Similar student body size (within 25%)
5. Comparable SAT scores (within 75 points)
6. Similar acceptance rate (within 15 percentage points)
7. Comparable academic quality (within 1 point on a 5-point scale)

This algorithm helps students discover options they might not have considered but that match their preferences.

## Getting Started

### Prerequisites

- Java JDK 8+
- Apache Tomcat 9.0 (for web interface)
- MySQL database (optional, MockDatabaseController available for testing)

### Running the Console Application

```bash
# Compile the project
ant build

# Run the console application
java -cp "bin:lib/*" cmc.frontend.Driver

# Run tests
ant AllTests
```

### Setting Up the Web Interface

1. Deploy the WAR file to your Tomcat server
2. Access the application at `http://localhost:8080/cmc/`

## Development Team

- Nasir Mirza 
- Rick Masaana
- Alex Lopez
- Roman Lefler
- Timothy Flynn

## Testing Philosophy

CMC follows a comprehensive testing approach:
- Unit tests for all major components
- Regression tests to prevent bug reintroduction
- User story tests to validate feature implementation from a user perspective

The MockDatabaseController allows for testing without a live database connection.

---

*Created for CSCI 230: Software Development - Spring 2025*
