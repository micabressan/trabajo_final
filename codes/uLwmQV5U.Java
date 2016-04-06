package com.ds.misc;

public class MinSwapping {

	public static void main(String[] args) {
		
		
		int[] pairs = new int[]{1,3,10, 11,2,7,12,6,13,4,14,8,5,9};
		
		int[] arr = new int[]{0,1,10, 2,9,3,14,7,8, 13 4,5,11, 12,6};		
		
		int[] pairIndex = new int[arr.length];
		
		int[] index = new int[arr.length];
		
		for(int i=1;i<arr.length;i++){
			index[arr[i]] = i;
		}
		
		for(int i=0;i<pairs.length;i=i+2){
			pairIndex[index[pairs[i]]] = index[pairs[i+1]];
			pairIndex[index[pairs[i+1]]] = index[pairs[i]];
		}
		
		int swaps = 0;
		
		for(int i=1;i<arr.length;i=i+2){
			if(pairIndex[index[arr[i]]] == index[arr[i+1]]){				
				continue;
			}else{
				int swapIndex = pairIndex[index[arr[i]]];
				
				index[arr[i+1]] = swapIndex;
				index[arr[swapIndex]] = i+1;
				swaps++;
				
				System.out.println(String.format("replace %d and %d", arr[i+1], arr[swapIndex]));
			}
		}
		
		System.out.println("swaps required:" + swaps);
	}
	
}