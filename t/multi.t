#!/local/bin/perl
# File: multout.t

use FileHandle::Multi;
use POSIX;
use strict;
print "1..3\n";

my($mh1) = new FileHandle::Multi;
my($tmp1) = POSIX::tmpnam();
$mh1->open(">$tmp1");
$mh1->open(">>$tmp1");
$mh1->open(">>$tmp1");
$mh1->print("File: $tmp1\n");
$mh1->printf("File: %s\n", $tmp1);

my($mh2) = new FileHandle::Multi;
my($tmp2) = POSIX::tmpnam();
$mh2->open(">-");
$mh2->open(">$tmp2");
$mh2->print("ok 1\n");

undef($mh2);

open(TMP, "$tmp2");
while (<TMP>) { }
if ($. == 1) { print "ok 2\n"}
else { print "not ok 2\n" }
close(TMP);

undef($mh1);

open(TMP, "$tmp1");
while (<TMP>) { }
if ($. == 6) { print "ok 3\n"}
else { print "not ok 3\n" }
close(TMP);

sub END {
    unlink($tmp1,$tmp2);
}
