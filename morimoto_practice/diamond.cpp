#include<stdio.h>

void print_diamond(int center, int row, int column){
	//列番号の指定
	int big_number = center;
	int min_number = center;
	bool center_flag = true;
	for(int i = 1; i <= row; i++){
		for(int j = 1; j <= column; j++){
			if (j == big_number || j == min_number){
				printf("*");
			} else {
				printf(" ");
			}
		}
		//centerの折り返し位置
		if(i >= center){
			center_flag = false;
		}
		if(center_flag == true){
			big_number ++;
			min_number --;
		} else {
			big_number --;
			min_number ++;
		}
		printf("\n");
	}
}

int even_number(int number){
	int num = number;
	if(number % 2 == 0){
		num++;
		return num;
	} else {
		return num;
	}
}



int main(void){
	int row, column, center, width;
	printf("ひし形を表示するプログラムです\n");
	printf("行を奇数で入力してください（偶数は自動的に足され奇数になります）\n");
	scanf("%d", &row);
	//printf("幅を奇数で入力してください（偶数は自動的に足され奇数になります）\n");
	//scanf("%d", &width);
	row = even_number(row);
	column = even_number(row);
	center = (row/2)+1;
	print_diamond(center, row, column);

	return(0);
}
	