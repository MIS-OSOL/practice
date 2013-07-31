<?
function print_diamond_row($w, $i) {
  print str_repeat(" ", $w - $i);
  print "*";
  if ($i != 0) {
    print str_repeat(" ", ($i*2-1));
    print "*";
  }
  print "\n";
}

$width = 5;
for ($i = 0; $i < $width; $i++) {
  print_diamond_row($width, $i);
}
$j = $i;
for ($i = $j; $i >= 0; $i--) {
  print_diamond_row($width, $i);
}
?>
