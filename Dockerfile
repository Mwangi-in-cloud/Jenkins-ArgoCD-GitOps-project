## this is the base image
FROM python:3.11-slim

## lets create the working directory
WORKDIR /app

## we need run commands to expose this 
COPY requirements.txt .

## installing depenndencies
RUN pip install --no-cache-dir -r requirements.txt

## now copying the files to be built
COPY app.py .

## now expose the port
EXPOSE 3000

## When starting the app 
CMD ["python","app.py"]