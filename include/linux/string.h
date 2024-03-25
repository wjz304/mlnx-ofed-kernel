#ifndef _COMPAT_LINUX_STRING_H
#define _COMPAT_LINUX_STRING_H

#include "../../compat/config.h"

#include_next <linux/string.h>

#ifndef unsafe_memcpy
#define unsafe_memcpy(dst, src, bytes, justification)		\
		memcpy(dst, src, bytes)
#endif

#ifndef HAVE_STRNICMP
#ifndef __HAVE_ARCH_STRNICMP
#define strnicmp strncasecmp
#endif
#endif /* HAVE_STRNICMP */

#ifndef HAVE_MEMDUP_USER_NUL
#define memdup_user_nul LINUX_BACKPORT(memdup_user_nul)
void *memdup_user_nul(const void __user *src, size_t len);
#endif

#ifndef HAVE_MEMCPY_AND_PAD
/**
 * memcpy_and_pad - Copy one buffer to another with padding
 * @dest: Where to copy to
 * @dest_len: The destination buffer size
 * @src: Where to copy from
 * @count: The number of bytes to copy
 * @pad: Character to use for padding if space is left in destination.
 */
#define memcpy_and_pad LINUX_BACKPORT(memcpy_and_pad)
static inline void memcpy_and_pad(void *dest, size_t dest_len,
				  const void *src, size_t count, int pad)
{
	if (dest_len > count) {
		memcpy(dest, src, count);
		memset(dest + count, pad,  dest_len - count);
	} else
		memcpy(dest, src, dest_len);
}
#endif

#ifndef memset_after
#define memset_after(obj, v, member)					\
({									\
	u8 *__ptr = (u8 *)(obj);					\
	typeof(v) __val = (v);						\
	memset(__ptr + offsetofend(typeof(*(obj)), member), __val,	\
	       sizeof(*(obj)) - offsetofend(typeof(*(obj)), member));	\
})
#endif

#ifndef HAVE_KSTRTOBOOL
int kstrtobool(const char *s, bool *res);
#endif

#endif /* _COMPAT_LINUX_STRING_H */
