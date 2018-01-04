#include "punti.h"

struct pixel *read_pixels(FILE *f, size_t *n)
{
	short short_buffer = 0;
	unsigned char uchar_buffer = 0;

	for (*n = 0; fgetc(f) != EOF; ++*n);
	*n /= 7;
	rewind(f);
	struct pixel *ris = malloc(*n * sizeof(struct pixel));
	struct pixel *temp = ris;
	for (size_t c = 0; c < *n; ++c)
	{
		fread(&short_buffer, 1, 2, f);
		temp->x = short_buffer;
		fread(&short_buffer, 1, 2, f);
		temp->y = short_buffer;
		for (size_t g = 0; g < 3; ++g)
		{
			fread(&uchar_buffer, 1, 1, f);
			temp->rgb[g] = uchar_buffer;
		}
		temp += sizeof(struct pixel);
	}
	return ris;
}