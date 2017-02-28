namespace :ticketing do
  task :setup_admin => :environment do     
    ["Super Admin"].each do |user|
        puts "-----------------------> #{user} <----------------------------------"
        email = ''
		username = ''
        STDOUT.puts "Enter email for #{user}:"
        email = STDIN.gets.chomp
        if email.match(/^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$/)	
  			  STDOUT.puts "Enter password (minimum 8 characters):"
  			  password = STDIN.gets.chomp
        else
          STDOUT.puts "Please enter a valid email for #{user}:"
          email = STDIN.gets.chomp
          STDOUT.puts "Enter password:"
          password = STDIN.gets.chomp
        end
        puts "Saving..........."
        if user == "Super Admin"
          fname ="Super"
          lname = "Admin"
        end
        us = User.create(:email => email,:password => password, :user_type => "admin", :admin => true)            
        puts "--  Successfully created account for #{user} ---"
    end
  end
end