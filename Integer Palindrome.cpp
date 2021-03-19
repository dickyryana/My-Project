/* Integer Palindrome Menggunakan Bahasa C Programming */

#include <stdio.h>
int main()
{
    int n, a, reversedInteger = 0, remainder, jumlah=0, originalInteger;
    
    printf("masukan jumlah data : ");
    scanf("%d",&n);
    for(int i=1; i<=n; i++)
    {
            reversedInteger = 0;
            printf("Masukan angka : ");
            scanf("%d",&a);
            originalInteger = a;
            
            while (a!=0)
            {
                remainder = a%10;
                reversedInteger = reversedInteger*10 + remainder;
                a /= 10;
                if (originalInteger == reversedInteger)
                {
                    jumlah = jumlah + 1;
                }
            }
                    
    }
                    printf("\nBanyak angka polindrome : %d \n", jumlah);
    
}
