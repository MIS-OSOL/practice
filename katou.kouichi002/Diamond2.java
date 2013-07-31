import java.util.Arrays;

public class Diamond2{
	public static void main(String args[]){
		Diamond2 diamond2 = new Diamond2();
		diamond2.draw(9);
	}

	private void draw(int height){
		char[] cell = new char[height];
		for(int i = 0; i < height; i++){
			// init a line
			Arrays.fill(cell, ' ');
			// plot '*'
			int tmp = Math.abs((height - 1) /2 - i);
			cell[tmp] = '*';
			cell[height - tmp - 1] = '*';
			// print
			System.out.println(cell);
		}
	}
}
