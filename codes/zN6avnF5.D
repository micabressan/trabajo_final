/**
 * This test shows how to return more than 1 variable
 */

import std.stdio;
import std.string; 
 
auto foo() {
	return new class { 
		string a = "Hallo"; 
		string b = "Welt";	 
	};
}

void main() {
	auto var = foo();
	
	write(var.a);
}