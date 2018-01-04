public class Solution extends VersionControl {
    
   public int firstBadVersion(int n) {
		return helper(1, n);
	}

	public int helper(int from, int to) {

		if (to - from <= 1) {
			return isBadVersion(from) ? from : to;
		}
		else {

			int next = from + (to - from) / 2;

			if (isBadVersion(next)) {
				return helper(from, next);
			}
			else {
				return helper(next, to);
			}
		}
	}
}