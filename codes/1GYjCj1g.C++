bool cerca_cam(nodo* r, int k, int y, int*C)
{
	if(!k && (!r->left && !r->right))
	{
		*C=-1;												
		return true;	
	}
	else
		return false;
	
	if(r->info == y)
		k-1;
	
	if(r->left && (cerca_cam(r->left, k, y, C+1)))
		{
			*C= 0;
			return true;
		}
	if(r->right && (cerca_cam(r->left, k, y, C+1)))
		{
			*C=1;
			return true;					
		}
}