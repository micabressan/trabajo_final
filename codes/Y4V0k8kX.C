#include <stdint.h>

uint8_t ComputeChecksum(uint8_t* data, uint8_t length)
{
  uint8_t n;
  uint8_t result;

  result = 0;
  for (n = 0; n < length; n++)
  {
    result += *(data + n);
  }

  return result;
}