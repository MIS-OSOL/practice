package diamond;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

public class diamond {

	public static void main(String[] args) throws IOException  {
		BufferedReader buf = new BufferedReader(new InputStreamReader(System.in));
		int num = 0;
		System.out.println("ひし形の幅を入力してください ");
		String str = buf.readLine();
		
		try {
			num = Integer.parseInt(str);
		} catch (NumberFormatException e) {
			System.out.println("入力できるのは数値のみです");
			System.exit(0);
		}
		
		diam(num);
	}
	
	private static void diam(int num) {
		int row = num;
		int column = num;
		if (num % 2 == 0) {
			row = num + 1;
			column = num + 1;
		}
		int center = (row / 2) + 1;
		int rowBigNum = center;
		int rowMinNum = center;
		boolean center_flag = true;
		
		for(int i = 1; i <= row; i++){
			for(int j = 1; j <= column; j++){
				if (j == rowBigNum || j == rowMinNum){
					System.out.print("*");
				} else {
					System.out.print(" ");
				}
			}

			if(i >= center){
				center_flag = false;
			}
			if(center_flag == true){
				rowBigNum ++;
				rowMinNum --;
			} else {
				rowBigNum --;
				rowMinNum ++;
			}
			System.out.println("");
		}
	}
}
