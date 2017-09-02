#!/usr/bin/perl -w
#

use strict;
use warnings;
my($progname)=@ARGV;
if(not defined $progname){
	die "Usage $1 <Nasm File>\n";
}
printf("[+] Assembling with Nasm.\n");
system("nasm","-f elf32","-o","$progname.o","$progname.nasm");
err_handler();
printf("[+] Linking.\n");
system("ld","-o","$progname","$progname.o");
err_handler();
printf("[+] Done!\n");

sub err_handler(){
	if($?!=0){
		printf("[-] Error: $!\n ");
	}
	else{
		printf("[+] Success command exited with: %d\n", $? >>8);
	}
}


