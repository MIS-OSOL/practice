class Diamond 

  def initialize(w)
    @width = w
  end
  
  def display 
    0.upto(@width) do |i|
      print_diamond_row(@width, i)
    end
    (@width).downto(0) do |i|
      print_diamond_row(@width, i)
    end
  end

private
  def print_diamond_row(w, i) 
    print " "*(w - i)
    print "*"
    if i != 0
      print " "*(i*2-1)
      print "*"
    end
    print "\n"
  end
end 

# main
diamond = Diamond.new(5);
diamond.display();


