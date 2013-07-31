<?
class Diamond {
  public $accessible_width = 0;
  private $width = 0;

  function __construct($w) {
    $this->width = $w;
  }

  public function display() {
    for ($i = 0; $i < $this->width; $i++) {
      $this->print_diamond_row($this->width, $i);
    }
    $j = $i;
    for ($i = $j; $i >= 0; $i--) {
      $this->print_diamond_row($this->width, $i);
    }
  }
  private function print_diamond_row($w, $i) {
    print str_repeat(" ", $w - $i);
    print "*";
    if ($i != 0) {
      print str_repeat(" ", ($i*2-1));
      print "*";
    }
    print "\n";
  }
} 

// main
$diamond = new Diamond(5);
$diamond->display();

?>
