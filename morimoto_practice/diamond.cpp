#include<stdio.h>

void print_diamond(int center, int row, int column){
	//��ԍ��̎w��
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
		//center�̐܂�Ԃ��ʒu
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
	printf("�Ђ��`��\������v���O�����ł�\n");
	printf("�s����œ��͂��Ă��������i�����͎����I�ɑ������ɂȂ�܂��j\n");
	scanf("%d", &row);
	//printf("������œ��͂��Ă��������i�����͎����I�ɑ������ɂȂ�܂��j\n");
	//scanf("%d", &width);
	row = even_number(row);
	column = even_number(row);
	center = (row/2)+1;
	print_diamond(center, row, column);

	return(0);
}
	