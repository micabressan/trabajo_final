require 'nexpose'
include Nexpose

nsc = Connection.new('192.168.1.101', 'user1', 'password1')

begin
    nsc.login
rescue
end

if nsc.session_id
    puts "[OK] Auth"

    begin
        nsc.backup(false,false)
    rescue
        puts "[FAIL] Backup failed"
    else
        puts "[OK] Backup started"
    ensure
        puts "[INFO] Backups list:"
        backups.each do |backup|
            puts "Name: #{backup.name}"
            puts "Date: #{backup.date}"
            puts "Size: #{backup.size}"
        end
    end

    nsc.logout
else
    puts "[FAIL] Auth"
end