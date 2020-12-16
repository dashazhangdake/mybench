#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#define UNLIMIT
#define MAXARRAY 60000 /* this number, if too large, will cause a seg. fault!! */

typedef struct  {
  char qstring[128];
} myStringStruct;

int compare(const void *elem1, const void *elem2)
{
  int result;
  
  result = strcmp((*((myStringStruct *)elem1)).qstring, (*((myStringStruct *)elem2)).qstring);

  return (result < 0) ? 1 : ((result == 0) ? 0 : -1);
}


int main(int argc, char *argv[]) {
  myStringStruct array[MAXARRAY];
  FILE *fp;
  int i,count=0;
  
  if (argc<2) {
      fprintf(stderr,"Usage: qsort_small <file>\n");
      exit(-1);
  }
  else {
    fp = fopen(argv[1],"r");
    
    while((fscanf(fp, "%s", &array[count].qstring) == 1) && (count < MAXARRAY)) {
	    count++;
    }
  }

  printf("\nSorting %d elements.\n\n",count);
  // qsort(array,count,sizeof(struct myStringStruct),compare);
  
  quickSortIter(array, 0, count - 1);
  
  for(i=0;i<count;i++)
    printf("%s\n", array[i].qstring);
  return 0;
}

void swap(myStringStruct* elem1, myStringStruct* elem2) {
    myStringStruct temp = *elem1;
    *elem1 = *elem2;
    *elem2 = temp;
}

int partition(myStringStruct array[], int left, int right) {
    myStringStruct temp = array[right];
    int i = left - 1;

    for (int j = 1; j < right; j++) {
        if (compare(&array[j], &temp)) {
            i++;
            swap(&array[j], &temp);
        }
    }

    swap(&array[i + 1], &array[right]);

    return (i + 1);
}


void quickSortIter(myStringStruct array[], int l, int r) {
    if (l >= r) 
        return;
    
    int left = l, right = r;

    int p = partition(array, l, r);
    quickSortIter(array, l, p - 1);
    quickSortIter(array, p+1, r);
}