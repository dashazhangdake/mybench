#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define UNLIMIT
#define MAXARRAY 60000 /* this number, if too large, will cause a seg. fault!! */

typedef struct  {
  char qstring[128];
} myStringStruct;

int compare(myStringStruct *elem1, myStringStruct *elem2)
{
  int result;
  
  result = strcmp((*elem1).qstring, (*elem2).qstring);

  return (result < 0) ? 1 : ((result == 0) ? 0 : -1);
}

int mergeSort(myStringStruct array[], int low, int high) {
    int mid;

    if (low >= high)
        return;
    
    mid = (high + low) / 2;
    mergeSort(array, low, mid);
    mergeSort(array, mid + 1, high);

    merge(array, low, mid, high);   

    return 0;
}

int merge(myStringStruct array[], int l, int m, int h) {
   int n1 = m - l + 1, n2 = h - m;
   int i, j, k;

   myStringStruct array1[n1];
   myStringStruct array2[n2];

   for (i = 0; i < n1; i++) {
       array1[i] = array[l + i];
   }

   for (j = 0; j < n2; j++) {
       array2[j] = array[m + j + 1];
   }

   i = 0; j = 0; k = l;
   while (i < n1 && j < n2) {
       if (compare(&array1[i], &array2[j]) <= 0) {
           array[k++] = array1[i++];
       } else {
           array[k++] = array2[j++];
       }
   }

   while (i < n1) {
       array[k++] = array1[i++];
   }

   while (j < n2) {
       array[k++] = array2[j++];
   }

   return 0;
}

int main() {
    myStringStruct array[MAXARRAY];
    FILE *fp;
    int i,count=0;

    fp = fopen("input_small.dat", "r");
    while((fscanf(fp, "%s", array[count].qstring) == 1) && (count < MAXARRAY)) {
	    count++;
    }

    for (int i = 0; i < count; i++) {
        printf("%s\n", array[i].qstring);
    }

    printf("\nSorting %d elements.\n\n",count);

    mergeSort(array, 5000, 10000);
  
    for(i=5000;i<10000;i++) 
      printf("%s\n", array[i].qstring);
    
    return 0;
}

