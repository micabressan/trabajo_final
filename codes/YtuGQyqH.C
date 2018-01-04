 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 */

#define _XOPEN_SOURCE 700
#define _POSIX_C_SOURCE 200809L

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <stdint.h>
#include <string.h>
#include <getopt.h>
#include <pthread.h>
#include <limits.h>
#include <assert.h>
#include <stdarg.h> /* libtommath.c */
#if defined(_WIN32) || defined(__WIN32__)
# include <windows.h>
#endif

#include <sys/types.h>
#include <sys/time.h>
#if defined(__APPLE__) || defined(__FreeBSD__)
# include <sys/sysctl.h>
#endif

#include "config.h"
#include "pixiewps.h"
#include "crypto/crypto_internal-modexp.c"
#include "crypto/aes-cbc.c"
#include "crypto/hmac_sha256.c"
#include "utils.h"
#include "wps.h"
#include "version.h"