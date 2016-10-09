# Script that obtains various git metrics from a basic git log file
require 'set'
require 'date'

# Given an array of git log lines, count the number of commits in the log
def num_commits(lines)
  count = 0
  lines.each do |line|
    if line.start_with?('commit')
      count += 1
    end
  end
  return count
end

# Given an array of git log lines, count the number of different authors
#   (Don't double-count!)
# You may assume that emails make a developer unique, that is, if a developer
# has two different emails they are counted as two different people.
def num_developers(lines)
  emails = Set.new
  lines.each do |line|
    if line.start_with?('Author')
      emails.add( line.scan(/<([^>]*)>/) )
    end
  end
  return emails.length
end


# Given an array of Git log lines, compute the number of days this was 
# in development. Note: you cannot assume any order of commits (e.g. you 
# cannot assume that the newest commit is first).
def days_of_development(lines)
  # start with dummy values of now. No way for a git log to have been
  # updated in the future
  start_date = Date.today
  # another dummy variable that will be out of range for the end date
  end_date = Date.parse('1900-01-01')
  lines.each do |line|
    if line.start_with?('Date')
      date_string = line.gsub('Date:  ','')
      date = Date.parse(date_string)
      if date < start_date
        start_date = date
      end
      if date > end_date
        end_date = date
      end
    end
  end
  return (end_date - start_date).to_i + 1
end

# This is a ruby idiom that allows us to use both unit testing and command line processing
# Does not get run when we use unit testing, e.g. ruby test_git_metrics.rb
# These commands will invoke this code with our test data: 
#    ruby git_metrics.rb < ruby-progressbar-short.txt
#    ruby git_metrics.rb < ruby-progressbar-full.txt
if __FILE__ == $PROGRAM_NAME
  lines = []
  $stdin.each { |line| lines << line }
  puts "Nunber of commits: #{num_commits lines}"
  puts "Number of developers: #{num_developers lines}"
  puts "Number of days in development: #{days_of_development lines}"
end
