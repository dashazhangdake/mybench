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

void swap(myStringStruct *elem1, myStringStruct *elem2) {
    myStringStruct temp = *elem1;
    *elem1 = *elem2;
    *elem2 = temp;
}

void quickSortIter(myStringStruct array[MAXARRAY],int first,int last){
   int i, j, pivot, temp;

   if(first<last){
      pivot=first;
      i=first;
      j=last;

      while(i<j){
         while(i < last && compare(&array[i], &array[pivot]) <= 0)
            i++;
         while(j >= first && compare(&array[j], &array[pivot]) > 0)
            j--;
         if(i<j){
            swap(&array[i], &array[j]);
         }
      }

    swap(&array[pivot], &array[j]);
    quickSortIter(array,first,j-1);
    quickSortIter(array,j+1,last);

   }
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
  
    quickSortIter(array, 0, count - 1);
  
    for(i=0;i<count;i++)
        printf("%s\n", array[i].qstring);
    
    return 0;
}

