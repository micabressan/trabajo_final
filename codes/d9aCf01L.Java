	public static boolean binarySearch (int positionnachher, int[] cacti) {
		int left=0;
		int right=cacti.length-1;
		while (left<=right) {
			int middle=(left+right)/2;
			if (cacti[middle]==positionnachher) {
				return true;
			}
			else if (cacti[middle]>positionnachher) {
				right=middle-1;
			}
			else {
				left=middle+1;
			}
		}
		return false;
	}