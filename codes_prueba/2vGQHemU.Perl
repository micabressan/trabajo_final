#!/usr/bin/env perl

use warnings;
use strict;
my @shoppingList = (1,2,5);

sub addItem{
   print("Enter what you would like to add to your shopping list: ");
   my $item = <STDIN>;
   push(@shoppingList,$item);
   print ("Here is the array after adding an item: @shoppingList\n");
}

sub removeItem{
   print("Enter what you would like to delete from your shopping list: ");
   my $delete = <STDIN>;
   foreach my $item(@shoppingList){
      if ($shoppingList[$item] =~ /$delete/);
         pop(@shoppingList);
   }
   print ("Here is the array after deleting an item: @shoppingList\n");
           

}




print ("Here is the array(1): @shoppingList\n");

addItem();


1;