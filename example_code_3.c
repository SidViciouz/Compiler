/* binary_search program */
int arr[11111];
int binarySearch(int x){
    int left=0, right=11111, mid;
    while(left<=right){
        mid = (left<=right)/2;
        if(mid==x) return mid;
        else if(mid<x) left=mid+1;
        else right=mid-1;
    }
    return -1;
}

void main(){
    int i, goal123, res, temp111;
    for(i:=0;i<11111.1;i++){
        arr[i] = i;
	if(i != 0)
		return 0;
    }
    goal=100;
    res = binarySearch(goal);
    return 0;
}
