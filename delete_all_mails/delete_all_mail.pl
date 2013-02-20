#!/usr/bin/perl

use strict;
use Net::POP3;

my $host = '';
my $user = '';
my $pass = '';

    
my $pop = &connect_pop3($host, $user, $pass);
my $msgrefs = $pop->list();
my $count = keys %$msgrefs;
if( $count == 0 ){
   $pop->quit;
   print "all deleted\n";
   exit;
}
print "num: $count\n";

foreach ( sort {$a<=>$b} keys %$msgrefs ){
   $pop->delete($_);
   if( $_ % 1000 == 0 ) {
      print "Mail NO.$_ deleted\n";
   }
}
print "all deleted\n";
$pop->quit;

sub connect_pop3 {
   my ($host, $user, $pass) = @_;
   my $pop = Net::POP3->new($host);
   $pop->user($user);
   my $auth_check = $pop->pass($pass);
   if ( ! defined $auth_check ){
      die "failed to connect";
   }
   return $pop;
}
