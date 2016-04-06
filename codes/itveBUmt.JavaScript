function mutation(arr)
{
	// turn the elements lower case to ignore case, and split into characters
	var str1 = arr[0].toLowerCase().split("");
	var str2 = arr[1].toLowerCase().split("");
	// loop through the second first since all letters there must be present in first
	for (var i=0; i<str2.length; i++)
	{
		// flagging a match
		var match=false;
		for (var j=0; j<str1.length; j++)
		{
			if(str1[j]==str2[i])
			{
				match=true;
			}
		}
		// if a match wasn't found, then this should return false (breaking the function loop)
		if (!match) return false;
	}
	return true;
}

mutation(["hello", "hey"])