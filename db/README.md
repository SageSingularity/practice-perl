# Database Version Control

This directory contains the database migration scripts for the Oracle database.

## Structure

- `migrations/` - Contains numbered migration scripts
  - `V1__initial_schema.sql` - Initial database schema
  - `V2__add_roles.sql` - Adds roles functionality
  - (Add more migrations as needed)

## Migration Guidelines

1. Each migration script should be:
   - Numbered sequentially (V1, V2, etc.)
   - Idempotent (can be run multiple times safely)
   - Include rollback instructions when possible
   - Well-documented with comments

2. Naming Convention:
   - Format: `V{number}__{description}.sql`
   - Example: `V1__initial_schema.sql`

3. Best Practices:
   - Always include table comments
   - Use appropriate constraints
   - Include indexes for performance
   - Document all changes in the migration script header

## Running Migrations

1. Ensure you have the correct Oracle client installed
2. Connect to your Oracle database
3. Run migrations in order:
   ```sql
   @migrations/V1__initial_schema.sql
   @migrations/V2__add_roles.sql
   ```

## Rollback Procedures

Each migration should include rollback instructions in comments. To rollback:

1. Review the migration script for rollback instructions
2. Execute the rollback SQL statements in reverse order
3. Verify the rollback was successful

## Database Configuration

Store database configuration in a separate configuration file (not in version control):
- Connection strings
- Credentials
- Environment-specific settings 