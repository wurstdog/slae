#!/usr/bin/perl 
#
#
our $VERSION = '0.1.1';

use Binutils::Objdump qw(:ALL);
use strict;
my $file = shift @ARGV || 'a.out';
my $code = "unsigned char[]= \"";
my $shellcode = 'shellcode.c';
Binutils::Objdump::objdumpopt("-d");
Binutils::Objdump::objdump($file);
foreach (Binutils::Objdump::objdump_sec_disasm('.text')){
	(my $first,my $second,my $third)= split(/\t/,$_);
	#print($second."\n");				
	
	foreach my $item (split(/ /,$second)){
		$code .="\\x".$item;
	}
}
$code .="\"\;";
print("$code\n");

open(FILE,"<".$shellcode) || die "File not found: $!";
my @lines =<FILE>;
close(FILE);
my @newlines;
foreach(@lines){
	$_ =~ s/\#CODE/$code/g;
	push(@newlines,$_);
}
open(FILE,">".$shellcode) || die "File not found: $!";
print FILE @newlines;
close(FILE);

