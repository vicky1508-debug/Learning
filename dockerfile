
# 1. Start with a lightweight Linux base image that includes Python
FROM python:3.9-slim

# 2. Set a working directory inside the container
WORKDIR /app

# 3. Copy our local index.html into the container's /app directory
COPY index.html /app/index.html

# 4. Tell Docker which port the container will listen on
EXPOSE 8000

# 5. Define the command that runs when the container starts
CMD ["python", "-m", "http.server", "8000"]
