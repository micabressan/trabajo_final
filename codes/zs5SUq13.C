#include "punti.h"

struct pixel *read_pixels(FILE *f, size_t *n)
{
	short short_buffer = 0;
	unsigned char uchar_buffer = 0;

	fseek(f, 0, SEEK_END);
	*n = ftell(f);
	*n /= 7;
	rewind(f);

	struct pixel *ris = malloc(*n * sizeof(struct pixel));
	for (size_t c = 0; c < *n; ++c)
	{
		fread(&short_buffer, 2, 1, f);
		ris[c].x = short_buffer;
		fread(&short_buffer, 2, 1, f);
		ris[c].y = short_buffer;
		for (size_t g = 0; g < 3; ++g)
		{
			fread(&uchar_buffer, 1, 1, f);
			ris[c].rgb[g] = uchar_buffer;
		}
	}
	return ris;
}