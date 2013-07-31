package fizzbuzz;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class FizzBazz {

	public static void main(String[] args) throws IOException  {
		BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));
		int num = 0;
		System.out.print("num = ");
		String str = buf.readLine();
		
		try {
			num = Integer.parseInt(str);
		} catch (NumberFormatException e) {
			System.out.println("入力できるのは数値のみです");
			System.exit(0);
		}
		
		for (int i = 1; i <= num; i++) {
			disp(i);
			System.out.print(",");
		}
		
	}
	
	private static void disp (int num) {
		if (num % 5 == 0 && num % 3 == 0) {
			System.out.print("fizzbuzz");
		} else if (num % 3 == 0) {
			System.out.print("fizz");
		} else if (num % 5 == 0) {
			System.out.print("buzz");
		} else {
			System.out.print(num);
		}
	}
}
