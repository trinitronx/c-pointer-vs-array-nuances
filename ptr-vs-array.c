#include <stdio.h>

int main(int argc, char **argv) {
    char str1[] = "Hello";
    char *str2 = "Goodbye";

    printf("%p %p %s\n", &str1, str1, str1);
    printf("%p %p %s\n", &str2, str2, str2);

    int arr1[1];

    printf("Enter a number: ");
    scanf("%d", arr1);

    printf("%p %p %d\n", &arr1, arr1, arr1[0]);
    return 0;
}