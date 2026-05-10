# Pi-hole API Testing Framework

Automated API testing framework for Pi-hole using Robot Framework and Python.

This project focuses on validating Pi-hole API functionality, system health, DNS blocking behavior, and service reliability through reusable and scalable automated tests.

---

# Features

* API testing with Robot Framework
* Reusable keywords and centralized configuration
* Environment variable support with `.env`
* Health and system metrics validation
* DNS blocking validation
* Session-based authentication
* Structured and maintainable test suites
* HTML reports generated automatically

---

# Tech Stack

* Python
* Robot Framework
* RequestsLibrary
* Pi-hole API
* Poetry

---

# Project Structure

```text
.
├── config/
│   └── variables.py
├── resources/
│   └── common.resource
├── tests/
│   ├── health.robot
│   ├── metrics.robot
│   ├── blocking.robot
│   └── discovery.robot
├── .env.example
├── pyproject.toml
├── poetry.lock
└── README.md
```

---

# Installation

## Clone the repository

```bash
git clone git@github.com:RafailPsar/Pi-hole-Testing.git
cd Pi-hole-Testing
```

## Install dependencies

```bash
poetry install
```

## Activate the virtual environment

```bash
poetry shell
```

---

# Environment Variables

Create a `.env` file in the project root.

Example:

```env
PIHOLE_URL=http://localhost/admin/api.php
PIHOLE_PASSWORD=your_password
```

The `.env` file is intentionally excluded from version control.

---

# Running Tests

Run all test suites:

```bash
robot tests/
```

---

# Reports

Robot Framework automatically generates:

* `report.html`
* `log.html`
* `output.xml`

These files are excluded from Git tracking.

---

# Example Test Coverage

Current test coverage includes:

* API availability checks
* Authentication validation
* DNS blocking behavior
* System metrics validation
* Service health monitoring
* Endpoint discovery

---

# Why Robot Framework?

Robot Framework provides:

* Readable and maintainable test syntax
* Strong API testing ecosystem
* Reusable keyword-driven architecture
* Easy CI/CD integration
* Clear HTML reporting

---

# Versioning

This project follows Semantic Versioning.

Current release:

```text
v0.1.0
```

---

# License

MIT License

---

# Disclaimer

This project is intended for educational, testing, and automation purposes.

Pi-hole is a trademark of its respective owners.
