#include<stdio.h>
#include<stdlib.h>

void fizzbuzz(int num){
	if(num % 3 == 0 && num % 5 == 0){
		printf("fizzbuzz");
	}else if(num % 3 == 0){
		printf("fizz");
	}else if(num % 5 == 0){
		printf("buzz");
	}else{
		printf("%d", num);
	}
}

int main(void){
	int num;
	printf("num = ");
	scanf("%d", &num);
	for(int i = 1; i<=num; i++){
		fizzbuzz(i);
		printf(", ");
	}
	printf("\n");
	return 0;
}