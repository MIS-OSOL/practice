/**
 * Fizz Buzz���
 * 3�̔{���Ȃ��Fizz
 * 5�̔{���Ȃ��Buzz
 * 3,5�̔{���Ȃ��Fizz Buzz
 */
public class FizzBuzz {
	public static void main(String[] args) {
		int count;
		for (count = 1; count <= 30; count++){
			if (count % 15 == 0) {
				System.out.println("Fizz Buzz");
			} else if (count % 5 == 0) {
				System.out.println("Buzz");
			} else if (count % 3 == 0) {
				System.out.println("Fizz");
			} else {
				System.out.println(count);
			}
		}
	}
}
