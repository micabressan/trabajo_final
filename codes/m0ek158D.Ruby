#!/usr/bin/ruby


puts "Ruby Application Config Helper"


def kill(pid)
%x[kill #{pid}]
end

def killAll
puts "Do you want to kill all SSH processes before starting? (y/n)"
while (1 == 1)
name = gets
if name.casecmp("y")
  puts "Killing..."
  puts %x[ps aux | grep [s]sh]
  %x[ps aux | grep [s]sh].strip.each_line do |line|
    $l = nil
    $l = line
    kill(%x[echo "#{$l.strip}"| awk '{print $2}'].strip)
  end
  break
elsif(name.casecmp("n"))
    puts "Not killing any process"
    break
  end

end
end

killAll

class C_Process
  attr_accessor :proc_PID, :proc_Name
  def initialize(pid, name)
  @proc_PID = pid
  @proc_Name = name
  end
end

class C_Process_List
  attr_accessor :processList
  def initialize()
  @processList = Array.new
  end
end


def updateProcList(arr)
 puts "Updating Global Process List"
 #arr = C_Process_List.new()
  %x[ps aux | grep [s]sh].each_line do |line|
    $l = nil
    $l = line
    sshProcess = C_Process.new((%x[echo "#{$l.strip}"| awk '{print $2}'].strip),(%x[echo #{$l.strip}| awk '{print $11}'].strip))
    if($procList.processList.any?{|n| n.proc_PID == sshProcess.proc_PID})
      puts "PID: #{sshProcess.proc_PID} already exists"
    else
      puts "Pushing PID: #{sshProcess.proc_PID}"
    arr.processList.push(sshProcess)
    end
  end
end

def getProcessByPID(pid)
return %x[ps -p #{pid} -o comm=]
end


def validateSSH
  $validProcess = [$procList.processList.find{|s| s.proc_Name.include? "ssh-agent"} , $procList.processList.find{|s| s.proc_Name == "ssh"}]
  if ($validProcess[0] == nil and $validProcess[1] == nil)
    puts "SSH Tunnel and Agent Processes are not validated and are not currently running"
    return 0
  elsif ($validProcess[0] == nil)
    puts "SSH Agent is not running"
    if($validProcess[1] != nil)
          return -3
    else
          return -1
    end
  elsif ($validProcess[1] == nil)
    puts "SSH Tunnel is not running?"
    sleep(4)
    return -2
  else
    puts "SSH Tunnel and Agent Processes are validated to be currently running"
    return 1
  end
end

$procList = C_Process_List.new()
$lisPort = "30215"


updateProcList($procList)


while 1 == 1
 puts "=========================== DEBUG  =========================== "
  listeningPortStatus = %x[netstat -an | grep -i #{$lisPort}]

  puts "Checking if the Application is listening on the correct port:"
  listeningPortStatus = listeningPortStatus.strip

  if (listeningPortStatus.empty? or listeningPortStatus.length == 0)
    puts "Application is NOT listening on: #{$lisPort}"
    puts "Waiting ..."
    killAll
    break
    #sleep(5)

  else
    puts "Application IS listening on: #{$lisPort}"

    if($procList.processList.length < %x[ps aux | grep [s]sh | wc -l].strip.to_i)
      puts "Updating Proc List"
      updateProcList($procList)
    elsif ($procList.processList.length > %x[ps aux | grep [s]sh | wc -l].strip.to_i)
      puts "Updating Proc List"
      $procList = C_Process_List.new()
      updateProcList($procList)
    else
      puts "Not Updating Proc List"
    end
    puts "Checking SSH Processes"

    sshProc = %x[ps aux | grep [s]sh].strip
    $sshProcCount = %x[ps aux | grep [s]sh | wc -l].strip


    puts "There are #{$sshProcCount} SSH related processes currently running"
    puts "There are #{$procList.processList.length} SSH related processes currently within the process list"

    puts $procList.inspect
    result = validateSSH
    puts "Result: #{result}"

    if(result == 0 or result == -1)
      puts "Starting SSH Process"
      puts "Waiting..."
      puts "Please enter your SSH Paraphrase"
      #Adds your SSH Paraphrase to the currently running SSH Agent
      %x[ssh-add ~/.ssh/id_rsa]
      sleep(2)
    elsif(result == -2)
      puts "Starting SSH Tunnel"
      Thread.new {$sshTunnel = %x[ssh -fNT -i ~/.ssh/id_rsa -R 30215:0.0.0.0:30215 -p 22 mxxx__MacbookPro_MAC@tunnel}
    elsif(result == -3)
      puts "SSH Tunnel is already started"
      sleep(8)
    elsif(result == 1)
      puts "Waiting..."
      sleep(5)
    end

    #puts getProcessByPID($procList.processList[0].proc_PID)
  end

 puts "=========================== DEBUG  =========================== "
 %x[clear]
end # while loop end