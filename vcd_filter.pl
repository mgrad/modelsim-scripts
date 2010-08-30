#!/usr/bin/perl -w

sub usage() {
  warn "usage $0: sec_start sec_end  < file.vcd\n";
  die;
}



$sec_beg = shift or usage();
$sec_end = shift or usage();

$now = $old_now = 0;
$header = 1;
$section = 0;
while ($line = <>) {

  if ($line =~ /^#(\d+)/) {
    $old_now = $now;
    $now = $1;
    if ($now != 0) { $header = 0 };
  }

  if ($now >= $sec_beg) {
      if ($now <= $sec_end) { 
        $section = 1;
      } else { 
        print "\$vcdclose\n#$old_now\n\$end\n";
        exit;
      }
  }

  print $line if ($header or $section);
}

