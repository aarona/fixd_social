namespace :github_events do
  desc "Import GitHub Events for a particular user"
  task import: :environment do |task, args|
    ARGV.each { |a| task a.to_sym do; end }
    ARGV.shift

    if ARGV.empty?
      puts "You must supply a github username to import events for"
      exit
    end

    ARGV.each do |username|
      user = User.find_by_github_username(username)
      
      if user.nil?
        puts "No User with github username #{username} exists"
        next
      end

      puts "Importing GitHub events for #{user.github_username} (#{user.name} - #{user.email})..."
      request = RequestGithubEvents.new(user)

      puts "  GET #{request.api_url}"
      
      request.import { |count| puts "  Events found: #{count}" }

      puts "  Imported #{request.imported} event(s), skipped #{request.skipped} event(s), #{request.errors} error(s)"
    end
  end
end
