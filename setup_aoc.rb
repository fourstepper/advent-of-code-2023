#!/usr/bin/env ruby
require "logger"

logger = Logger.new(STDOUT)
log_level = ENV.fetch('LOG_LEVEL', 'WARN')
logger.level = log_level

# which language we will use this year to solve AoC
aoc_file_extension = ENV["AOC_FILE_EXTENSION"]

if aoc_file_extension.to_s.length == 0
  logger.fatal('The "AOC_FILE_EXTENSION" environment variable cannot be empty. Exiting...')
  exit(1)
end

1.upto(24) do |i|
  day = "day#{i}"
  begin
    Dir.mkdir day
  rescue Errno::EEXIST
    logger.info("#{day} directory already exists, skipping creation.")
  end

  files_to_create = ["input.txt", "solve.#{aoc_file_extension}"]

  files_to_create.each do |file_name|
    begin
      path = "#{day}/#{file_name}"
      file = File.new(path, "wx")
      file.close
    rescue Errno::EEXIST
      logger.info("#{path} already exists, skipping creation")
    end
  end
end
