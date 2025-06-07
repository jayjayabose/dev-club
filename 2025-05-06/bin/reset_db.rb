#!/usr/bin/env ruby
# frozen_string_literal: true

# Script to reset the SQLite database by deleting and recreating it

require 'fileutils'

# Define paths
DB_DIR = './db'
DB_FILE = File.join(DB_DIR, 'tasks.db')
CREATE_SCRIPT = './bin/create_db.rb'

# Print status messages
def log(message)
  puts "=> #{message}"
end

# Main reset process
begin
  # Check if database exists and delete it
  if File.exist?(DB_FILE)
    log "Deleting existing database..."
    File.delete(DB_FILE)
  else
    log "No existing database found."
  end

  # Ensure db directory exists
  FileUtils.mkdir_p(DB_DIR)

  # Create new database
  log "Creating new database..."
  load CREATE_SCRIPT  # Using load instead of system to ensure proper error handling

  log "Database reset complete!"
rescue => e
  puts "Error: #{e.message}"
  puts e.backtrace
  exit 1
end