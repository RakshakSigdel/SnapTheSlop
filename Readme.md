# SnapTheSlop

One-line tag: A Java web application for reporting, tracking and managing municipal issues.

## Description

SnapTheSlop is a simple municipal issue-reporting web application built with Java Servlets and JSP. Citizens can report issues (with optional file uploads), comment and upvote reports, and receive notifications. Municipal staff and admins can manage issues, wards, municipalities and citizen accounts via an admin dashboard.

## Features

- User registration and authentication
- Report an issue with details and file uploads (images)
- Browse and search issues by municipality/ward/status
- Issue detail pages with comments and upvotes
- Notification center for users
- Admin dashboard: citizen & municipality management, issue moderation
- Simple analytics and activity logs (where available)

## Tech Stack

- Language: Java
- Build: Maven
- Web: Java Servlets, JSP, JSTL
- Servlet Container: Apache Tomcat (recommended) or any Servlet 3.0+ compatible container
- Database: MySQL / MariaDB / PostgreSQL (SQL schema provided in `src/query.sql`)

## Prerequisites

- Java 11 or newer
- Maven 3.6+
- A Servlet container (Apache Tomcat 9+ recommended) or use a Maven plugin for embedded servers
- A relational database (MySQL/MariaDB/Postgres)

## Quick Start — Build & Deploy

1. Configure your database and create schema using the provided SQL:

```sql
-- run the SQL in `src/query.sql` against your database
```

2. Update database connection settings in the application's configuration (example: environment variables or `web.xml`/config class depending on how your project is wired).

3. Build the project with Maven:

```bash
mvn clean package
```

After build, a WAR will be created under `target/SnapTheSlop-1.0-SNAPSHOT/` (or `target/*.war`).

4. Deploy the WAR to Tomcat `webapps/` folder or use your preferred container.

Alternative: run with an embedded server (if configured) or a Maven plugin. Example (if Jetty plugin is present):

```bash
mvn jetty:run
```

## Configuration

- Database URL/credentials: set as environment variables or update the datasource config in the project.
- File upload directory: configure the uploads path (default `/uploads/issues/` in target output) and ensure the servlet process has write permissions.
- SMTP for email/OTP: configure SMTP host, port, username and app-specific password. Example env names:

```text
DB_URL=jdbc:mysql://localhost:3306/snaptheslop
DB_USER=root
DB_PASSWORD=yourpassword
UPLOAD_DIR=/path/to/uploads
SMTP_HOST=smtp.gmail.com
SMTP_USER=you@example.com
SMTP_PASSWORD=your-app-password
```

Notes: For Gmail App Passwords use an app password (16 characters) and avoid accidentally including surrounding quotes.

## Database

The repository includes `src/query.sql` — run this against your chosen database to create required tables and sample data.

## Development Tips

- Use an IDE (IntelliJ IDEA, Eclipse) to import the Maven project and run/debug servlets with a local Tomcat integration.
- Keep uploaded files and sensitive config out of version control. Use `.gitignore` for `target/` and any local config.

## Testing

There are no automated tests included by default. Add unit/integration tests and include them under `src/test/java` then run `mvn test`.

## Deployment

- Build a production WAR with `mvn clean package -Pprod` (if profiles exist) and deploy to your server.
- Ensure proper environment variable configuration and that the server user has access to the uploads directory and database network access.

## Contributing

- Fork the repository, create a feature branch, and open a pull request with a clear description of changes.
- Add tests for new features and update this README when adding new configuration options.

## Troubleshooting & Notes

- If email verification fails, make sure SMTP credentials are correct and app passwords are properly formatted.
- If deployment returns errors related to database connections, check the JDBC URL and network access to the DB host.

