FROM mysql:8.0

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=Anubhav@9099!
ENV MYSQL_DATABASE=school_managemnet_system
ENV MYSQL_ROOT_HOST=%

# Copy initialization script
COPY init.sql /docker-entrypoint-initdb.d/

# Expose MySQL port
EXPOSE 3306