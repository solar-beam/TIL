# 합병정렬

## 구현하기

```c++
#include <iostream>
#define ARRAY_SIZE 8
using namespace std;

void mergeSort(int arr[], int lowIndex, int highIndex);
void merge(int arr[], int lowIndex, int midIndex, int high);

int main() {
	int arr[ARRAY_SIZE] = { 5,3,1,9,2,7,0,4 };
	//int arr[ARRAY_SIZE] = {5,5,3,1,9,2,7,7,7,0,4};
	mergeSort(arr, 0, ARRAY_SIZE-1);
	for (int i = 0; i < ARRAY_SIZE; i++) cout << arr[i] << " ";
	return 0;
}

//[low...high] 정렬
void mergeSort(int arr[], int lowIndex, int highIndex) {
	int midIndex = -1;
	if (lowIndex < highIndex) {
		midIndex = (lowIndex + highIndex) / 2;
		mergeSort(arr, lowIndex, midIndex);
		mergeSort(arr, midIndex + 1, highIndex);
		
		merge(arr, lowIndex, midIndex, highIndex);
	}
}

//[low...mid]과 [mid+1...high] 정렬된 배열을 병합
void merge(int arr[], int lowIndex, int midIndex, int highIndex) {
	int tempArray[ARRAY_SIZE];
	int posTemp = 0, posLow = lowIndex, posHigh = midIndex + 1;
	for (int i = 0; i < ARRAY_SIZE; i++) tempArray[i] = -1;

	while (posLow <= midIndex && posHigh <= highIndex) {
		tempArray[posTemp++] = (arr[posLow] <= arr[posHigh]) ? arr[posLow++] : arr[posHigh++];
	}

	if (posLow > midIndex) for (int i = posHigh; i <= highIndex; i++) tempArray[posTemp++] = arr[i];
	else for (int i = posLow; i <= midIndex; i++) tempArray[posTemp++] = arr[i];

	memcpy(arr + lowIndex, tempArray, sizeof(int) * (highIndex - lowIndex +1));
}
```

그런데 결과는?

```
COMPLETE!
뭐가 잘못됐냐하면
merge함수 인자로 전달받은 것 미만/이하로 정렬해야하는지 불명확
```

## TOO DEEP
NONE