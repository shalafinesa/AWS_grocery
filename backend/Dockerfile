# Use official Python image
FROM python:3.10-slim

# Set working directory
WORKDIR /app

# Copy requirements first (for better caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the backend app
COPY . .

# Expose the port your app runs on
EXPOSE 5000

# Run the app
CMD ["python", "run.py"]

