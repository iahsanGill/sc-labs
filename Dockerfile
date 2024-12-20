# Use a lightweight Alpine-based Python image
FROM python:3.10-alpine

# Install OpenJDK 11 (required for ANTLR) and other dependencies using Alpine package manager (apk)
RUN apk add --no-cache \
    openjdk11-jre \
    wget \
    bash \
    && rm -rf /var/cache/apk/*

# Install ANTLR
WORKDIR /usr/local/lib
RUN wget https://www.antlr.org/download/antlr-4.13.0-complete.jar && \
    ln -s /usr/local/lib/antlr-4.13.0-complete.jar /usr/local/bin/antlr.jar

# Add ANTLR to the PATH for easier execution
ENV CLASSPATH=".:/usr/local/lib/antlr-4.13.0-complete.jar:$CLASSPATH"
ENV PATH="/usr/local/bin:$PATH"

# Create a directory for ANTLR output
RUN mkdir -p /app/antlr_output

# Set up the project workspace
WORKDIR /app

# Copy Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Generate lexer/parser and move output to the specified directory
RUN java -jar /usr/local/lib/antlr-4.13.0-complete.jar -Dlanguage=Python3 -o /app/antlr_output /app/Expression.g4

# Default command for generating lexer/parser
CMD ["python", "main.py"]
