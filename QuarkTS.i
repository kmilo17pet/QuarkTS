# 1 "QuarkTS.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkTS.c"
# 27 "QuarkTS.c"
# 1 "/usr/include/ctype.h" 1 3 4



# 1 "/usr/include/_ansi.h" 1 3 4
# 15 "/usr/include/_ansi.h" 3 4
# 1 "/usr/include/newlib.h" 1 3 4
# 16 "/usr/include/_ansi.h" 2 3 4
# 1 "/usr/include/sys/config.h" 1 3 4



# 1 "/usr/include/machine/ieeefp.h" 1 3 4
# 5 "/usr/include/sys/config.h" 2 3 4
# 1 "/usr/include/sys/features.h" 1 3 4
# 6 "/usr/include/sys/config.h" 2 3 4
# 234 "/usr/include/sys/config.h" 3 4
# 1 "/usr/include/cygwin/config.h" 1 3 4
# 235 "/usr/include/sys/config.h" 2 3 4
# 17 "/usr/include/_ansi.h" 2 3 4
# 5 "/usr/include/ctype.h" 2 3 4



int __attribute__((__cdecl__)) isalnum (int __c);
int __attribute__((__cdecl__)) isalpha (int __c);
int __attribute__((__cdecl__)) iscntrl (int __c);
int __attribute__((__cdecl__)) isdigit (int __c);
int __attribute__((__cdecl__)) isgraph (int __c);
int __attribute__((__cdecl__)) islower (int __c);
int __attribute__((__cdecl__)) isprint (int __c);
int __attribute__((__cdecl__)) ispunct (int __c);
int __attribute__((__cdecl__)) isspace (int __c);
int __attribute__((__cdecl__)) isupper (int __c);
int __attribute__((__cdecl__)) isxdigit (int __c);
int __attribute__((__cdecl__)) tolower (int __c);
int __attribute__((__cdecl__)) toupper (int __c);
# 45 "/usr/include/ctype.h" 3 4
extern __attribute__((dllimport)) char *__ctype_ptr__;
# 109 "/usr/include/ctype.h" 3 4
extern __attribute__((dllimport)) const char _ctype_[];


# 28 "QuarkTS.c" 2

# 1 "QuarkTS.h" 1
# 33 "QuarkTS.h"
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 1 3 4
# 9 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 3 4
# 1 "/usr/include/stdint.h" 1 3 4
# 12 "/usr/include/stdint.h" 3 4
# 1 "/usr/include/machine/_default_types.h" 1 3 4
# 27 "/usr/include/machine/_default_types.h" 3 4
typedef signed char __int8_t;

typedef unsigned char __uint8_t;
# 41 "/usr/include/machine/_default_types.h" 3 4
typedef short int __int16_t;

typedef short unsigned int __uint16_t;
# 63 "/usr/include/machine/_default_types.h" 3 4
typedef int __int32_t;

typedef unsigned int __uint32_t;
# 89 "/usr/include/machine/_default_types.h" 3 4
typedef long int __int64_t;

typedef long unsigned int __uint64_t;
# 120 "/usr/include/machine/_default_types.h" 3 4
typedef signed char __int_least8_t;

typedef unsigned char __uint_least8_t;
# 146 "/usr/include/machine/_default_types.h" 3 4
typedef short int __int_least16_t;

typedef short unsigned int __uint_least16_t;
# 168 "/usr/include/machine/_default_types.h" 3 4
typedef int __int_least32_t;

typedef unsigned int __uint_least32_t;
# 186 "/usr/include/machine/_default_types.h" 3 4
typedef long int __int_least64_t;

typedef long unsigned int __uint_least64_t;
# 200 "/usr/include/machine/_default_types.h" 3 4
typedef long int __intptr_t;

typedef long unsigned int __uintptr_t;
# 13 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/sys/_intsup.h" 1 3 4
# 39 "/usr/include/sys/_intsup.h" 3 4
       
       
       
# 67 "/usr/include/sys/_intsup.h" 3 4
       
       
       
# 14 "/usr/include/stdint.h" 2 3 4
# 1 "/usr/include/sys/_stdint.h" 1 3 4
# 19 "/usr/include/sys/_stdint.h" 3 4
typedef __int8_t int8_t ;
typedef __uint8_t uint8_t ;




typedef __int16_t int16_t ;
typedef __uint16_t uint16_t ;




typedef __int32_t int32_t ;
typedef __uint32_t uint32_t ;




typedef __int64_t int64_t ;
typedef __uint64_t uint64_t ;



typedef __intptr_t intptr_t;
typedef __uintptr_t uintptr_t;
# 15 "/usr/include/stdint.h" 2 3 4






typedef __int_least8_t int_least8_t;
typedef __uint_least8_t uint_least8_t;




typedef __int_least16_t int_least16_t;
typedef __uint_least16_t uint_least16_t;




typedef __int_least32_t int_least32_t;
typedef __uint_least32_t uint_least32_t;




typedef __int_least64_t int_least64_t;
typedef __uint_least64_t uint_least64_t;
# 51 "/usr/include/stdint.h" 3 4
  typedef signed char int_fast8_t;
  typedef unsigned char uint_fast8_t;
# 61 "/usr/include/stdint.h" 3 4
  typedef long int int_fast16_t;
  typedef long unsigned int uint_fast16_t;
# 71 "/usr/include/stdint.h" 3 4
  typedef long int int_fast32_t;
  typedef long unsigned int uint_fast32_t;
# 81 "/usr/include/stdint.h" 3 4
  typedef long int int_fast64_t;
  typedef long unsigned int uint_fast64_t;
# 130 "/usr/include/stdint.h" 3 4
  typedef long int intmax_t;
# 139 "/usr/include/stdint.h" 3 4
  typedef long unsigned int uintmax_t;
# 10 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdint.h" 2 3 4
# 34 "QuarkTS.h" 2
# 1 "/usr/include/string.h" 1 3 4
# 11 "/usr/include/string.h" 3 4
# 1 "/usr/include/sys/reent.h" 1 3 4
# 13 "/usr/include/sys/reent.h" 3 4
# 1 "/usr/include/_ansi.h" 1 3 4
# 14 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 147 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 212 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 324 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef short unsigned int wchar_t;
# 15 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/include/sys/_types.h" 1 3 4
# 12 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/include/machine/_types.h" 1 3 4
# 13 "/usr/include/sys/_types.h" 2 3 4
# 1 "/usr/include/sys/lock.h" 1 3 4
# 14 "/usr/include/sys/lock.h" 3 4
typedef void *_LOCK_T;
# 44 "/usr/include/sys/lock.h" 3 4
void __cygwin_lock_init(_LOCK_T *);
void __cygwin_lock_init_recursive(_LOCK_T *);
void __cygwin_lock_fini(_LOCK_T *);
void __cygwin_lock_lock(_LOCK_T *);
int __cygwin_lock_trylock(_LOCK_T *);
void __cygwin_lock_unlock(_LOCK_T *);
# 14 "/usr/include/sys/_types.h" 2 3 4


typedef long _off_t;



typedef short __dev_t;



typedef unsigned short __uid_t;


typedef unsigned short __gid_t;



__extension__ typedef long long _off64_t;







typedef long _fpos_t;





typedef _off64_t _fpos64_t;
# 55 "/usr/include/sys/_types.h" 3 4
typedef long signed int _ssize_t;
# 67 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 353 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef unsigned int wint_t;
# 68 "/usr/include/sys/_types.h" 2 3 4



typedef struct
{
  int __count;
  union
  {
    wint_t __wch;
    unsigned char __wchb[4];
  } __value;
} _mbstate_t;



typedef _LOCK_T _flock_t;




typedef void *_iconv_t;
# 16 "/usr/include/sys/reent.h" 2 3 4
# 25 "/usr/include/sys/reent.h" 3 4
typedef unsigned int __ULong;
# 38 "/usr/include/sys/reent.h" 3 4
struct _reent;






struct _Bigint
{
  struct _Bigint *_next;
  int _k, _maxwds, _sign, _wds;
  __ULong _x[1];
};


struct __tm
{
  int __tm_sec;
  int __tm_min;
  int __tm_hour;
  int __tm_mday;
  int __tm_mon;
  int __tm_year;
  int __tm_wday;
  int __tm_yday;
  int __tm_isdst;
};







struct _on_exit_args {
 void * _fnargs[32];
 void * _dso_handle[32];

 __ULong _fntypes;


 __ULong _is_cxa;
};
# 91 "/usr/include/sys/reent.h" 3 4
struct _atexit {
 struct _atexit *_next;
 int _ind;

 void (*_fns[32])(void);
        struct _on_exit_args _on_exit_args;
};
# 115 "/usr/include/sys/reent.h" 3 4
struct __sbuf {
 unsigned char *_base;
 int _size;
};
# 179 "/usr/include/sys/reent.h" 3 4
struct __sFILE {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;






  void * _cookie;

  _ssize_t (__attribute__((__cdecl__)) * _read) (struct _reent *, void *, char *, size_t)
                                          ;
  _ssize_t (__attribute__((__cdecl__)) * _write) (struct _reent *, void *, const char *, size_t)

                                   ;
  _fpos_t (__attribute__((__cdecl__)) * _seek) (struct _reent *, void *, _fpos_t, int);
  int (__attribute__((__cdecl__)) * _close) (struct _reent *, void *);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  _off_t _offset;


  struct _reent *_data;



  _flock_t _lock;

  _mbstate_t _mbstate;
  int _flags2;
};
# 237 "/usr/include/sys/reent.h" 3 4
struct __sFILE64 {
  unsigned char *_p;
  int _r;
  int _w;
  short _flags;
  short _file;
  struct __sbuf _bf;
  int _lbfsize;

  struct _reent *_data;


  void * _cookie;

  _ssize_t (__attribute__((__cdecl__)) * _read) (struct _reent *, void *, char *, size_t)
                                          ;
  _ssize_t (__attribute__((__cdecl__)) * _write) (struct _reent *, void *, const char *, size_t)

                                   ;
  _fpos_t (__attribute__((__cdecl__)) * _seek) (struct _reent *, void *, _fpos_t, int);
  int (__attribute__((__cdecl__)) * _close) (struct _reent *, void *);


  struct __sbuf _ub;
  unsigned char *_up;
  int _ur;


  unsigned char _ubuf[3];
  unsigned char _nbuf[1];


  struct __sbuf _lb;


  int _blksize;
  int _flags2;

  _off64_t _offset;
  _fpos64_t (__attribute__((__cdecl__)) * _seek64) (struct _reent *, void *, _fpos64_t, int);


  _flock_t _lock;

  _mbstate_t _mbstate;
};
typedef struct __sFILE64 __FILE;





struct _glue
{
  struct _glue *_next;
  int _niobs;
  __FILE *_iobs;
};
# 317 "/usr/include/sys/reent.h" 3 4
struct _rand48 {
  unsigned short _seed[3];
  unsigned short _mult[3];
  unsigned short _add;




};
# 569 "/usr/include/sys/reent.h" 3 4
struct _reent
{
  int _errno;




  __FILE *_stdin, *_stdout, *_stderr;

  int _inc;
  char _emergency[25];

  int _current_category;
  const char *_current_locale;

  int __sdidinit;

  void (__attribute__((__cdecl__)) * __cleanup) (struct _reent *);


  struct _Bigint *_result;
  int _result_k;
  struct _Bigint *_p5s;
  struct _Bigint **_freelist;


  int _cvtlen;
  char *_cvtbuf;

  union
    {
      struct
        {
          unsigned int _unused_rand;
          char * _strtok_last;
          char _asctime_buf[26];
          struct __tm _localtime_buf;
          int _gamma_signgam;
          __extension__ unsigned long long _rand_next;
          struct _rand48 _r48;
          _mbstate_t _mblen_state;
          _mbstate_t _mbtowc_state;
          _mbstate_t _wctomb_state;
          char _l64a_buf[8];
          char _signal_buf[24];
          int _getdate_err;
          _mbstate_t _mbrlen_state;
          _mbstate_t _mbrtowc_state;
          _mbstate_t _mbsrtowcs_state;
          _mbstate_t _wcrtomb_state;
          _mbstate_t _wcsrtombs_state;
   int _h_errno;
        } _reent;



      struct
        {

          unsigned char * _nextf[30];
          unsigned int _nmalloc[30];
        } _unused;
    } _new;



  struct _atexit *_atexit;
  struct _atexit _atexit0;



  void (**(_sig_func))(int);




  struct _glue __sglue;
  __FILE __sf[3];
};
# 762 "/usr/include/sys/reent.h" 3 4
extern struct _reent *_impure_ptr ;
extern struct _reent *const _global_impure_ptr ;

void _reclaim_reent (struct _reent *);





  struct _reent * __attribute__((__cdecl__)) __getreent (void);
# 12 "/usr/include/string.h" 2 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 45 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 46 "/usr/include/sys/cdefs.h" 2 3 4
# 13 "/usr/include/string.h" 2 3 4




# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 18 "/usr/include/string.h" 2 3 4



void * __attribute__((__cdecl__)) memchr (const void *, int, size_t);
int __attribute__((__cdecl__)) memcmp (const void *, const void *, size_t);
void * __attribute__((__cdecl__)) memcpy (void * , const void * , size_t);
void * __attribute__((__cdecl__)) memmove (void *, const void *, size_t);
void * __attribute__((__cdecl__)) memset (void *, int, size_t);
char *__attribute__((__cdecl__)) strcat (char *, const char *);
char *__attribute__((__cdecl__)) strchr (const char *, int);
int __attribute__((__cdecl__)) strcmp (const char *, const char *);
int __attribute__((__cdecl__)) strcoll (const char *, const char *);
char *__attribute__((__cdecl__)) strcpy (char *, const char *);
size_t __attribute__((__cdecl__)) strcspn (const char *, const char *);
char *__attribute__((__cdecl__)) strerror (int);
size_t __attribute__((__cdecl__)) strlen (const char *);
char *__attribute__((__cdecl__)) strncat (char *, const char *, size_t);
int __attribute__((__cdecl__)) strncmp (const char *, const char *, size_t);
char *__attribute__((__cdecl__)) strncpy (char *, const char *, size_t);
char *__attribute__((__cdecl__)) strpbrk (const char *, const char *);
char *__attribute__((__cdecl__)) strrchr (const char *, int);
size_t __attribute__((__cdecl__)) strspn (const char *, const char *);
char *__attribute__((__cdecl__)) strstr (const char *, const char *);

char *__attribute__((__cdecl__)) strtok (char *, const char *);

size_t __attribute__((__cdecl__)) strxfrm (char *, const char *, size_t);


char *__attribute__((__cdecl__)) strtok_r (char *, const char *, char **);


int __attribute__((__cdecl__)) bcmp (const void *, const void *, size_t);
void __attribute__((__cdecl__)) bcopy (const void *, void *, size_t);
void __attribute__((__cdecl__)) bzero (void *, size_t);
int __attribute__((__cdecl__)) ffs (int);
char *__attribute__((__cdecl__)) index (const char *, int);


void * __attribute__((__cdecl__)) memccpy (void * , const void * , int, size_t);





void * __attribute__((__cdecl__)) memrchr (const void *, int, size_t);




char *__attribute__((__cdecl__)) rindex (const char *, int);

char *__attribute__((__cdecl__)) stpcpy (char *, const char *);
char *__attribute__((__cdecl__)) stpncpy (char *, const char *, size_t);

int __attribute__((__cdecl__)) strcasecmp (const char *, const char *);






char *__attribute__((__cdecl__)) strdup (const char *);





char *__attribute__((__cdecl__)) strndup (const char *, size_t);
# 106 "/usr/include/string.h" 3 4
int __attribute__((__cdecl__)) strerror_r (int, char *, size_t)

             __asm__ ("" "__xpg_strerror_r")

  ;







char * __attribute__((__cdecl__)) _strerror_r (struct _reent *, int, int, int *);


size_t __attribute__((__cdecl__)) strlcat (char *, const char *, size_t);
size_t __attribute__((__cdecl__)) strlcpy (char *, const char *, size_t);


int __attribute__((__cdecl__)) strncasecmp (const char *, const char *, size_t);



size_t __attribute__((__cdecl__)) strnlen (const char *, size_t);


char *__attribute__((__cdecl__)) strsep (char **, const char *);
# 145 "/usr/include/string.h" 3 4
char *__attribute__((__cdecl__)) strsignal (int __signo);



int __attribute__((__cdecl__)) strtosigno (const char *__name);
# 182 "/usr/include/string.h" 3 4
# 1 "/usr/include/sys/string.h" 1 3 4
# 183 "/usr/include/string.h" 2 3 4


# 35 "QuarkTS.h" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 36 "/usr/include/stdio.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 37 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 40 "/usr/include/stdio.h" 2 3 4
# 48 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/sys/types.h" 1 3 4
# 71 "/usr/include/sys/types.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 72 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/machine/types.h" 1 3 4
# 19 "/usr/include/machine/types.h" 3 4
typedef long int __off_t;
typedef int __pid_t;

__extension__ typedef long long int __loff_t;





typedef long __suseconds_t;
# 73 "/usr/include/sys/types.h" 2 3 4
# 95 "/usr/include/sys/types.h" 3 4
typedef unsigned char u_char;



typedef unsigned short u_short;



typedef unsigned int u_int;



typedef unsigned long u_long;





typedef unsigned short ushort;
typedef unsigned int uint;
typedef unsigned long ulong;



typedef unsigned long clock_t;




typedef long time_t;




typedef long daddr_t;



typedef char * caddr_t;
# 180 "/usr/include/sys/types.h" 3 4
typedef int pid_t;
# 190 "/usr/include/sys/types.h" 3 4
typedef _ssize_t ssize_t;
# 209 "/usr/include/sys/types.h" 3 4
typedef unsigned short nlink_t;
# 231 "/usr/include/sys/types.h" 3 4
typedef long fd_mask;







typedef struct _types_fd_set {
 fd_mask fds_bits[(((64)+(((sizeof (fd_mask) * 8))-1))/((sizeof (fd_mask) * 8)))];
} _types_fd_set;
# 262 "/usr/include/sys/types.h" 3 4
typedef unsigned long clockid_t;




typedef unsigned long timer_t;



typedef unsigned long useconds_t;


typedef __suseconds_t suseconds_t;



typedef __int64_t sbintime_t;
# 474 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/cygwin/types.h" 1 3 4
# 21 "/usr/include/cygwin/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 15 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 16 "/usr/include/endian.h" 2 3 4
# 32 "/usr/include/endian.h" 3 4
# 1 "/usr/include/byteswap.h" 1 3 4
# 18 "/usr/include/byteswap.h" 3 4
static __inline unsigned short
bswap_16 (unsigned short __x)
{
  return (__x >> 8) | (__x << 8);
}

static __inline unsigned int
bswap_32 (unsigned int __x)
{
  return (bswap_16 (__x & 0xffff) << 16) | (bswap_16 (__x >> 16));
}

static __inline unsigned long long
bswap_64 (unsigned long long __x)
{
  return (((unsigned long long) bswap_32 (__x & 0xffffffffull)) << 32) | (bswap_32 (__x >> 32));
}
# 33 "/usr/include/endian.h" 2 3 4
# 22 "/usr/include/cygwin/types.h" 2 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/cygwin/types.h" 2 3 4
# 1 "/usr/include/sys/_timespec.h" 1 3 4
# 44 "/usr/include/sys/_timespec.h" 3 4
struct timespec {
 time_t tv_sec;
 long tv_nsec;
};
# 24 "/usr/include/cygwin/types.h" 2 3 4



typedef struct timespec timespec_t;




typedef struct timespec timestruc_t;






typedef _off_t off_t;





typedef __loff_t loff_t;



typedef __int16_t __dev16_t;
typedef __uint32_t dev_t;




typedef __int32_t blksize_t;




typedef __int32_t __blkcnt32_t;
typedef __int64_t blkcnt_t;





typedef unsigned long fsblkcnt_t;





typedef unsigned long fsfilcnt_t;




typedef unsigned short __uid16_t;
typedef __uint32_t uid_t;




typedef unsigned short __gid16_t;
typedef __uint32_t gid_t;







typedef __uint64_t ino_t;





typedef __uint32_t id_t;
# 113 "/usr/include/cygwin/types.h" 3 4
struct flock {
 short l_type;
 short l_whence;
 off_t l_start;
 off_t l_len;
 pid_t l_pid;
};



typedef long long key_t;







typedef unsigned long vm_offset_t;




typedef unsigned long vm_size_t;




typedef void *vm_object_t;




typedef unsigned char u_int8_t;



typedef __uint16_t u_int16_t;



typedef __uint32_t u_int32_t;



typedef __uint64_t u_int64_t;




typedef __int32_t register_t;




typedef char *addr_t;




typedef unsigned mode_t;





typedef struct __pthread_t {char __dummy;} *pthread_t;
typedef struct __pthread_mutex_t {char __dummy;} *pthread_mutex_t;

typedef struct __pthread_key_t {char __dummy;} *pthread_key_t;
typedef struct __pthread_attr_t {char __dummy;} *pthread_attr_t;
typedef struct __pthread_mutexattr_t {char __dummy;} *pthread_mutexattr_t;
typedef struct __pthread_condattr_t {char __dummy;} *pthread_condattr_t;
typedef struct __pthread_cond_t {char __dummy;} *pthread_cond_t;


typedef struct
{
  pthread_mutex_t mutex;
  int state;
}
pthread_once_t;
typedef struct __pthread_spinlock_t {char __dummy;} *pthread_spinlock_t;
typedef struct __pthread_rwlock_t {char __dummy;} *pthread_rwlock_t;
typedef struct __pthread_rwlockattr_t {char __dummy;} *pthread_rwlockattr_t;
# 220 "/usr/include/cygwin/types.h" 3 4
# 1 "/usr/include/sys/sysmacros.h" 1 3 4
# 14 "/usr/include/sys/sysmacros.h" 3 4
# 1 "/usr/include/sys/types.h" 1 3 4
# 15 "/usr/include/sys/sysmacros.h" 2 3 4

extern __inline__ __attribute__ ((__always_inline__)) int gnu_dev_major(dev_t);
extern __inline__ __attribute__ ((__always_inline__)) int gnu_dev_minor(dev_t);
extern __inline__ __attribute__ ((__always_inline__)) dev_t gnu_dev_makedev(int, int);

extern __inline__ __attribute__ ((__always_inline__)) int
gnu_dev_major(dev_t dev)
{
 return (int)(((dev) >> 16) & 0xffff);
}

extern __inline__ __attribute__ ((__always_inline__)) int
gnu_dev_minor(dev_t dev)
{
 return (int)((dev) & 0xffff);
}

extern __inline__ __attribute__ ((__always_inline__)) dev_t
gnu_dev_makedev(int maj, int min)
{
 return (((maj) << 16) | ((min) & 0xffff));
}
# 221 "/usr/include/cygwin/types.h" 2 3 4
# 475 "/usr/include/sys/types.h" 2 3 4
# 49 "/usr/include/stdio.h" 2 3 4




typedef __FILE FILE;




typedef _fpos64_t fpos_t;







# 1 "/usr/include/sys/stdio.h" 1 3 4
# 35 "/usr/include/sys/stdio.h" 3 4


ssize_t __attribute__((__cdecl__)) getline (char **, size_t *, FILE *);
ssize_t __attribute__((__cdecl__)) getdelim (char **, size_t *, int, FILE *);


# 67 "/usr/include/stdio.h" 2 3 4
# 167 "/usr/include/stdio.h" 3 4
FILE * __attribute__((__cdecl__)) tmpfile (void);
char * __attribute__((__cdecl__)) tmpnam (char *);

char * __attribute__((__cdecl__)) tempnam (const char *, const char *);

int __attribute__((__cdecl__)) fclose (FILE *);
int __attribute__((__cdecl__)) fflush (FILE *);
FILE * __attribute__((__cdecl__)) freopen (const char *, const char *, FILE *);
void __attribute__((__cdecl__)) setbuf (FILE *, char *);
int __attribute__((__cdecl__)) setvbuf (FILE *, char *, int, size_t);
int __attribute__((__cdecl__)) fprintf (FILE *, const char *, ...) __attribute__ ((__format__ (__printf__, 2, 3)))
                                                            ;
int __attribute__((__cdecl__)) fscanf (FILE *, const char *, ...) __attribute__ ((__format__ (__scanf__, 2, 3)))
                                                           ;
int __attribute__((__cdecl__)) printf (const char *, ...) __attribute__ ((__format__ (__printf__, 1, 2)))
                                                            ;
int __attribute__((__cdecl__)) scanf (const char *, ...) __attribute__ ((__format__ (__scanf__, 1, 2)))
                                                           ;
int __attribute__((__cdecl__)) sscanf (const char *, const char *, ...) __attribute__ ((__format__ (__scanf__, 2, 3)))
                                                           ;
int __attribute__((__cdecl__)) vfprintf (FILE *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 2, 0)))
                                                            ;
int __attribute__((__cdecl__)) vprintf (const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 1, 0)))
                                                            ;
int __attribute__((__cdecl__)) vsprintf (char *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 2, 0)))
                                                            ;
int __attribute__((__cdecl__)) fgetc (FILE *);
char * __attribute__((__cdecl__)) fgets (char *, int, FILE *);
int __attribute__((__cdecl__)) fputc (int, FILE *);
int __attribute__((__cdecl__)) fputs (const char *, FILE *);
int __attribute__((__cdecl__)) getc (FILE *);
int __attribute__((__cdecl__)) getchar (void);
char * __attribute__((__cdecl__)) gets (char *);
int __attribute__((__cdecl__)) putc (int, FILE *);
int __attribute__((__cdecl__)) putchar (int);
int __attribute__((__cdecl__)) puts (const char *);
int __attribute__((__cdecl__)) ungetc (int, FILE *);
size_t __attribute__((__cdecl__)) fread (void * , size_t _size, size_t _n, FILE *);
size_t __attribute__((__cdecl__)) fwrite (const void * , size_t _size, size_t _n, FILE *);



int __attribute__((__cdecl__)) fgetpos (FILE *, fpos_t *);

int __attribute__((__cdecl__)) fseek (FILE *, long, int);



int __attribute__((__cdecl__)) fsetpos (FILE *, const fpos_t *);

long __attribute__((__cdecl__)) ftell ( FILE *);
void __attribute__((__cdecl__)) rewind (FILE *);
void __attribute__((__cdecl__)) clearerr (FILE *);
int __attribute__((__cdecl__)) feof (FILE *);
int __attribute__((__cdecl__)) ferror (FILE *);
void __attribute__((__cdecl__)) perror (const char *);

FILE * __attribute__((__cdecl__)) fopen (const char * _name, const char * _type);
int __attribute__((__cdecl__)) sprintf (char *, const char *, ...) __attribute__ ((__format__ (__printf__, 2, 3)))
                                                            ;
int __attribute__((__cdecl__)) remove (const char *);
int __attribute__((__cdecl__)) rename (const char *, const char *);
# 360 "/usr/include/stdio.h" 3 4
int __attribute__((__cdecl__)) _asiprintf_r (struct _reent *, char **, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
char * __attribute__((__cdecl__)) _asniprintf_r (struct _reent *, char *, size_t *, const char *, ...) __attribute__ ((__format__ (__printf__, 4, 5)))
                                                            ;
char * __attribute__((__cdecl__)) _asnprintf_r (struct _reent *, char *, size_t *, const char *, ...) __attribute__ ((__format__ (__printf__, 4, 5)))
                                                            ;
int __attribute__((__cdecl__)) _asprintf_r (struct _reent *, char **, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _diprintf_r (struct _reent *, int, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _dprintf_r (struct _reent *, int, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _fclose_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _fcloseall_r (struct _reent *);
FILE * __attribute__((__cdecl__)) _fdopen_r (struct _reent *, int, const char *);
int __attribute__((__cdecl__)) _fflush_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _fgetc_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _fgetc_unlocked_r (struct _reent *, FILE *);
char * __attribute__((__cdecl__)) _fgets_r (struct _reent *, char *, int, FILE *);
char * __attribute__((__cdecl__)) _fgets_unlocked_r (struct _reent *, char *, int, FILE *);




int __attribute__((__cdecl__)) _fgetpos_r (struct _reent *, FILE *, fpos_t *);
int __attribute__((__cdecl__)) _fsetpos_r (struct _reent *, FILE *, const fpos_t *);

int __attribute__((__cdecl__)) _fiprintf_r (struct _reent *, FILE *, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _fiscanf_r (struct _reent *, FILE *, const char *, ...) __attribute__ ((__format__ (__scanf__, 3, 4)))
                                                           ;
FILE * __attribute__((__cdecl__)) _fmemopen_r (struct _reent *, void *, size_t, const char *);
FILE * __attribute__((__cdecl__)) _fopen_r (struct _reent *, const char *, const char *);
FILE * __attribute__((__cdecl__)) _freopen_r (struct _reent *, const char *, const char *, FILE *);
int __attribute__((__cdecl__)) _fprintf_r (struct _reent *, FILE *, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _fpurge_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _fputc_r (struct _reent *, int, FILE *);
int __attribute__((__cdecl__)) _fputc_unlocked_r (struct _reent *, int, FILE *);
int __attribute__((__cdecl__)) _fputs_r (struct _reent *, const char *, FILE *);
int __attribute__((__cdecl__)) _fputs_unlocked_r (struct _reent *, const char *, FILE *);
size_t __attribute__((__cdecl__)) _fread_r (struct _reent *, void * , size_t _size, size_t _n, FILE *);
size_t __attribute__((__cdecl__)) _fread_unlocked_r (struct _reent *, void * , size_t _size, size_t _n, FILE *);
int __attribute__((__cdecl__)) _fscanf_r (struct _reent *, FILE *, const char *, ...) __attribute__ ((__format__ (__scanf__, 3, 4)))
                                                           ;
int __attribute__((__cdecl__)) _fseek_r (struct _reent *, FILE *, long, int);
int __attribute__((__cdecl__)) _fseeko_r (struct _reent *, FILE *, _off_t, int);
long __attribute__((__cdecl__)) _ftell_r (struct _reent *, FILE *);
_off_t __attribute__((__cdecl__)) _ftello_r (struct _reent *, FILE *);
void __attribute__((__cdecl__)) _rewind_r (struct _reent *, FILE *);
size_t __attribute__((__cdecl__)) _fwrite_r (struct _reent *, const void * , size_t _size, size_t _n, FILE *);
size_t __attribute__((__cdecl__)) _fwrite_unlocked_r (struct _reent *, const void * , size_t _size, size_t _n, FILE *);
int __attribute__((__cdecl__)) _getc_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _getc_unlocked_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) _getchar_r (struct _reent *);
int __attribute__((__cdecl__)) _getchar_unlocked_r (struct _reent *);
char * __attribute__((__cdecl__)) _gets_r (struct _reent *, char *);
int __attribute__((__cdecl__)) _iprintf_r (struct _reent *, const char *, ...) __attribute__ ((__format__ (__printf__, 2, 3)))
                                                            ;
int __attribute__((__cdecl__)) _iscanf_r (struct _reent *, const char *, ...) __attribute__ ((__format__ (__scanf__, 2, 3)))
                                                           ;
FILE * __attribute__((__cdecl__)) _open_memstream_r (struct _reent *, char **, size_t *);
void __attribute__((__cdecl__)) _perror_r (struct _reent *, const char *);
int __attribute__((__cdecl__)) _printf_r (struct _reent *, const char *, ...) __attribute__ ((__format__ (__printf__, 2, 3)))
                                                            ;
int __attribute__((__cdecl__)) _putc_r (struct _reent *, int, FILE *);
int __attribute__((__cdecl__)) _putc_unlocked_r (struct _reent *, int, FILE *);
int __attribute__((__cdecl__)) _putchar_unlocked_r (struct _reent *, int);
int __attribute__((__cdecl__)) _putchar_r (struct _reent *, int);
int __attribute__((__cdecl__)) _puts_r (struct _reent *, const char *);
int __attribute__((__cdecl__)) _remove_r (struct _reent *, const char *);
int __attribute__((__cdecl__)) _rename_r (struct _reent *, const char *_old, const char *_new)
                                          ;
int __attribute__((__cdecl__)) _scanf_r (struct _reent *, const char *, ...) __attribute__ ((__format__ (__scanf__, 2, 3)))
                                                           ;
int __attribute__((__cdecl__)) _siprintf_r (struct _reent *, char *, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _siscanf_r (struct _reent *, const char *, const char *, ...) __attribute__ ((__format__ (__scanf__, 3, 4)))
                                                           ;
int __attribute__((__cdecl__)) _sniprintf_r (struct _reent *, char *, size_t, const char *, ...) __attribute__ ((__format__ (__printf__, 4, 5)))
                                                            ;
int __attribute__((__cdecl__)) _snprintf_r (struct _reent *, char *, size_t, const char *, ...) __attribute__ ((__format__ (__printf__, 4, 5)))
                                                            ;
int __attribute__((__cdecl__)) _sprintf_r (struct _reent *, char *, const char *, ...) __attribute__ ((__format__ (__printf__, 3, 4)))
                                                            ;
int __attribute__((__cdecl__)) _sscanf_r (struct _reent *, const char *, const char *, ...) __attribute__ ((__format__ (__scanf__, 3, 4)))
                                                           ;
char * __attribute__((__cdecl__)) _tempnam_r (struct _reent *, const char *, const char *);
FILE * __attribute__((__cdecl__)) _tmpfile_r (struct _reent *);
char * __attribute__((__cdecl__)) _tmpnam_r (struct _reent *, char *);
int __attribute__((__cdecl__)) _ungetc_r (struct _reent *, int, FILE *);
int __attribute__((__cdecl__)) _vasiprintf_r (struct _reent *, char **, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
char * __attribute__((__cdecl__)) _vasniprintf_r (struct _reent*, char *, size_t *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 4, 0)))
                                                            ;
char * __attribute__((__cdecl__)) _vasnprintf_r (struct _reent*, char *, size_t *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 4, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vasprintf_r (struct _reent *, char **, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vdiprintf_r (struct _reent *, int, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vdprintf_r (struct _reent *, int, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vfiprintf_r (struct _reent *, FILE *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vfiscanf_r (struct _reent *, FILE *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 3, 0)))
                                                           ;
int __attribute__((__cdecl__)) _vfprintf_r (struct _reent *, FILE *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vfscanf_r (struct _reent *, FILE *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 3, 0)))
                                                           ;
int __attribute__((__cdecl__)) _viprintf_r (struct _reent *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 2, 0)))
                                                            ;
int __attribute__((__cdecl__)) _viscanf_r (struct _reent *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 2, 0)))
                                                           ;
int __attribute__((__cdecl__)) _vprintf_r (struct _reent *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 2, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vscanf_r (struct _reent *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 2, 0)))
                                                           ;
int __attribute__((__cdecl__)) _vsiprintf_r (struct _reent *, char *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vsiscanf_r (struct _reent *, const char *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 3, 0)))
                                                           ;
int __attribute__((__cdecl__)) _vsniprintf_r (struct _reent *, char *, size_t, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 4, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vsnprintf_r (struct _reent *, char *, size_t, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 4, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vsprintf_r (struct _reent *, char *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__printf__, 3, 0)))
                                                            ;
int __attribute__((__cdecl__)) _vsscanf_r (struct _reent *, const char *, const char *, __gnuc_va_list) __attribute__ ((__format__ (__scanf__, 3, 0)))
                                                           ;



int __attribute__((__cdecl__)) fpurge (FILE *);
ssize_t __attribute__((__cdecl__)) __getdelim (char **, size_t *, int, FILE *);
ssize_t __attribute__((__cdecl__)) __getline (char **, size_t *, FILE *);


void __attribute__((__cdecl__)) clearerr_unlocked (FILE *);
int __attribute__((__cdecl__)) feof_unlocked (FILE *);
int __attribute__((__cdecl__)) ferror_unlocked (FILE *);
int __attribute__((__cdecl__)) fileno_unlocked (FILE *);
int __attribute__((__cdecl__)) fflush_unlocked (FILE *);
int __attribute__((__cdecl__)) fgetc_unlocked (FILE *);
int __attribute__((__cdecl__)) fputc_unlocked (int, FILE *);
size_t __attribute__((__cdecl__)) fread_unlocked (void * , size_t _size, size_t _n, FILE *);
size_t __attribute__((__cdecl__)) fwrite_unlocked (const void * , size_t _size, size_t _n, FILE *);
# 541 "/usr/include/stdio.h" 3 4
int __attribute__((__cdecl__)) __srget_r (struct _reent *, FILE *);
int __attribute__((__cdecl__)) __swbuf_r (struct _reent *, int, FILE *);
# 629 "/usr/include/stdio.h" 3 4
extern __inline__ __attribute__ ((__always_inline__)) int __sgetc_r(struct _reent *__ptr, FILE *__p);

extern __inline__ __attribute__ ((__always_inline__)) int __sgetc_r(struct _reent *__ptr, FILE *__p)
  {
    int __c = (--(__p)->_r < 0 ? __srget_r(__ptr, __p) : (int)(*(__p)->_p++));
    if ((__p->_flags & 0x4000) && (__c == '\r'))
      {
      int __c2 = (--(__p)->_r < 0 ? __srget_r(__ptr, __p) : (int)(*(__p)->_p++));
      if (__c2 == '\n')
        __c = __c2;
      else
        ungetc(__c2, __p);
      }
    return __c;
  }
# 728 "/usr/include/stdio.h" 3 4

# 36 "QuarkTS.h" 2
# 1 "/usr/include/stdlib.h" 1 3 4
# 10 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/machine/ieeefp.h" 1 3 4
# 11 "/usr/include/stdlib.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 17 "/usr/include/stdlib.h" 2 3 4



# 1 "/usr/include/machine/stdlib.h" 1 3 4
# 17 "/usr/include/machine/stdlib.h" 3 4
char *mkdtemp (char *);
# 21 "/usr/include/stdlib.h" 2 3 4





# 1 "/usr/include/cygwin/stdlib.h" 1 3 4
# 15 "/usr/include/cygwin/stdlib.h" 3 4
# 1 "/usr/include/cygwin/wait.h" 1 3 4
# 16 "/usr/include/cygwin/stdlib.h" 2 3 4






__uint32_t arc4random(void);
void arc4random_addrandom(unsigned char *, int);
void arc4random_buf(void *, size_t);
void arc4random_stir(void);
__uint32_t arc4random_uniform(__uint32_t);

const char *getprogname (void);
void setprogname (const char *);






char *initstate (unsigned seed, char *state, size_t size);
long random (void);
char *setstate (const char *state);
void srandom (unsigned);
# 49 "/usr/include/cygwin/stdlib.h" 3 4
int posix_openpt (int);
int posix_memalign (void **, size_t, size_t);






extern void * memalign (size_t, size_t);
extern void * valloc (size_t);
# 27 "/usr/include/stdlib.h" 2 3 4




typedef struct
{
  int quot;
  int rem;
} div_t;

typedef struct
{
  long quot;
  long rem;
} ldiv_t;
# 55 "/usr/include/stdlib.h" 3 4
typedef int (*__compar_fn_t) (const void *, const void *);







int __attribute__((__cdecl__)) __locale_mb_cur_max (void);



void __attribute__((__cdecl__)) abort (void) __attribute__ ((__noreturn__));
int __attribute__((__cdecl__)) abs (int);
int __attribute__((__cdecl__)) atexit (void (*__func)(void));
double __attribute__((__cdecl__)) atof (const char *__nptr);



int __attribute__((__cdecl__)) atoi (const char *__nptr);
int __attribute__((__cdecl__)) _atoi_r (struct _reent *, const char *__nptr);
long __attribute__((__cdecl__)) atol (const char *__nptr);
long __attribute__((__cdecl__)) _atol_r (struct _reent *, const char *__nptr);
void * __attribute__((__cdecl__)) bsearch (const void * __key, const void * __base, size_t __nmemb, size_t __size, __compar_fn_t _compar)



                                ;
void * __attribute__((__cdecl__)) calloc (size_t __nmemb, size_t __size) ;
div_t __attribute__((__cdecl__)) div (int __numer, int __denom);
void __attribute__((__cdecl__)) exit (int __status) __attribute__ ((__noreturn__));
void __attribute__((__cdecl__)) free (void *) ;
char * __attribute__((__cdecl__)) getenv (const char *__string);
char * __attribute__((__cdecl__)) _getenv_r (struct _reent *, const char *__string);
char * __attribute__((__cdecl__)) _findenv (const char *, int *);
char * __attribute__((__cdecl__)) _findenv_r (struct _reent *, const char *, int *);




long __attribute__((__cdecl__)) labs (long);
ldiv_t __attribute__((__cdecl__)) ldiv (long __numer, long __denom);
void * __attribute__((__cdecl__)) malloc (size_t __size) ;
int __attribute__((__cdecl__)) mblen (const char *, size_t);
int __attribute__((__cdecl__)) _mblen_r (struct _reent *, const char *, size_t, _mbstate_t *);
int __attribute__((__cdecl__)) mbtowc (wchar_t *, const char *, size_t);
int __attribute__((__cdecl__)) _mbtowc_r (struct _reent *, wchar_t *, const char *, size_t, _mbstate_t *);
int __attribute__((__cdecl__)) wctomb (char *, wchar_t);
int __attribute__((__cdecl__)) _wctomb_r (struct _reent *, char *, wchar_t, _mbstate_t *);
size_t __attribute__((__cdecl__)) mbstowcs (wchar_t *, const char *, size_t);
size_t __attribute__((__cdecl__)) _mbstowcs_r (struct _reent *, wchar_t *, const char *, size_t, _mbstate_t *);
size_t __attribute__((__cdecl__)) wcstombs (char *, const wchar_t *, size_t);
size_t __attribute__((__cdecl__)) _wcstombs_r (struct _reent *, char *, const wchar_t *, size_t, _mbstate_t *);
# 124 "/usr/include/stdlib.h" 3 4
void __attribute__((__cdecl__)) qsort (void * __base, size_t __nmemb, size_t __size, __compar_fn_t _compar);
int __attribute__((__cdecl__)) rand (void);
void * __attribute__((__cdecl__)) realloc (void * __r, size_t __size) ;




void __attribute__((__cdecl__)) srand (unsigned __seed);
double __attribute__((__cdecl__)) strtod (const char * __n, char ** __end_PTR);
double __attribute__((__cdecl__)) _strtod_r (struct _reent *,const char * __n, char ** __end_PTR);
# 145 "/usr/include/stdlib.h" 3 4
long __attribute__((__cdecl__)) strtol (const char * __n, char ** __end_PTR, int __base);
long __attribute__((__cdecl__)) _strtol_r (struct _reent *,const char * __n, char ** __end_PTR, int __base);
unsigned long __attribute__((__cdecl__)) strtoul (const char * __n, char ** __end_PTR, int __base);
unsigned long __attribute__((__cdecl__)) _strtoul_r (struct _reent *,const char * __n, char ** __end_PTR, int __base);

int __attribute__((__cdecl__)) system (const char *__string);
# 180 "/usr/include/stdlib.h" 3 4
char * __attribute__((__cdecl__)) __itoa (int, char *, int);
char * __attribute__((__cdecl__)) __utoa (unsigned, char *, int);
# 246 "/usr/include/stdlib.h" 3 4
char * __attribute__((__cdecl__)) _dtoa_r (struct _reent *, double, int, int, int *, int*, char**);







int __attribute__((__cdecl__)) _system_r (struct _reent *, const char *);

void __attribute__((__cdecl__)) __eprintf (const char *, const char *, unsigned int, const char *);
# 283 "/usr/include/stdlib.h" 3 4

# 37 "QuarkTS.h" 2
# 76 "QuarkTS.h"
        typedef int32_t _qTaskPC_t;
# 95 "QuarkTS.h"
    typedef enum {qTriggerNULL, byTimeElapsed, byQueueExtraction, byAsyncEvent, byRBufferPop, byRBufferFull, byRBufferCount, byRBufferEmpty, bySchedulingRelease, byNoReadyTasks} qTrigger_t;
    typedef float qTime_t;
    typedef uint32_t qClock_t;
    typedef uint8_t qPriority_t;
    typedef int16_t qIteration_t;
    typedef uint8_t qState_t;
    typedef uint8_t qBool_t;
    typedef uint16_t qSize_t;
# 135 "QuarkTS.h"
    typedef struct{
# 168 "QuarkTS.h"
        qTrigger_t Trigger;



        void *TaskData;





        void *EventData;




        qBool_t FirstCall;






        qBool_t FirstIteration;






        qBool_t LastIteration;
    }_qEvent_t_, *qEvent_t;
    typedef void (*qTaskFcn_t)(qEvent_t);

    typedef union{
        struct{
            volatile uint8_t InitFlag, AsyncRun, Enabled, RBAutoPop, RBFull, RBCount, RBEmpty;
        };
        volatile uint8_t FlagatIndex[7];
    }qTaskFlags_t;
# 215 "QuarkTS.h"
    typedef uint8_t qTaskState_t;





    typedef struct{
        volatile uint8_t *data;
        volatile qSize_t ElementSize;
        volatile qSize_t Elementcount;
        volatile qSize_t head;
        volatile qSize_t tail;
    }qRBuffer_t;

    typedef enum {qSM_EXIT_SUCCESS = -32768, qSM_EXIT_FAILURE = -32767} qSM_Status_t;


    struct _qSM_t{



        qSM_Status_t (*NextState)(volatile struct _qSM_t*);



        qSM_Status_t (*PreviousState)(volatile struct _qSM_t*);



        qSM_Status_t PreviousReturnStatus;



        qBool_t StateFirstEntry;





        void *Data;

        struct {
            void (*__Failure)(volatile struct _qSM_t*);
            void (*__Success)(volatile struct _qSM_t*);
            void (*__Unexpected)(volatile struct _qSM_t*);
            void (*__BeforeAnyState)(volatile struct _qSM_t*);
            qSM_Status_t (*Prev)(volatile struct _qSM_t*);
        }_;
    };


    typedef enum{
        qSM_RESTART,
        qSM_CLEAR_STATE_FIRST_ENTRY_FLAG,
        qSM_FAILURE_STATE,
        qSM_SUCCESS_STATE,
        qSM_UNEXPECTED_STATE,
        qSM_BEFORE_ANY_STATE,
    }qFSM_Attribute_t;

    typedef qSM_Status_t (*qSM_State_t)(volatile struct _qSM_t*);
    typedef void (*qSM_ExState_t)(volatile struct _qSM_t*);

    struct _qTask_t{
        volatile struct _qTask_t *Next;
        void *TaskData,*AsyncData;
        volatile qClock_t Interval, ClockStart;
        qIteration_t Iterations;
        uint32_t Cycles;
        qPriority_t Priority;
        qTaskFcn_t Callback;
        volatile qTaskFlags_t Flag;
        qRBuffer_t *RingBuff;
        volatile struct _qSM_t *StateMachine;
        qTaskState_t State;
        qTrigger_t Trigger;
    };

    typedef volatile struct _qTask_t** qHeadPointer_t;
    typedef struct{
        volatile struct _qTask_t *Task;
        void *QueueData;
    }qQueueStack_t;

    typedef struct{
     uint8_t Init, FCallIdle, ReleaseSched, FCallReleased;
        uint32_t IntFlags;
    }qTaskCoreFlags_t;

    typedef struct{
        qTaskFcn_t IDLECallback;
        qTaskFcn_t ReleaseSchedCallback;
        _qEvent_t_ EventInfo;
        qTime_t Tick;
        volatile struct _qTask_t *Head;
        uint32_t (*I_Disable)(void);
        void (*I_Restorer)(uint32_t);
        volatile qTaskCoreFlags_t Flag;
        volatile qQueueStack_t *QueueStack;
        uint8_t QueueSize;
        int16_t QueueIndex;
        volatile struct _qTask_t *CurrentRunningTask;
        void *QueueData;
    }QuarkTSCoreData_t;
    void qSchedulerSysTick(void);
    volatile struct _qTask_t* qTaskSelf(void);
    qBool_t qTaskIsEnabled(volatile struct _qTask_t *Task);
    void qSchedulerSetIdleTask(qTaskFcn_t Callback);
    void qSchedulerRelease(void);
    void qSchedulerSetReleaseCallback(qTaskFcn_t Callback);

    void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack);
    void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void));
    qBool_t qSchedulerAddxTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg);
    qBool_t qSchedulerAddeTask(volatile struct _qTask_t *Task, qTaskFcn_t Callback, qPriority_t Priority, void* arg);
    qBool_t qSchedulerAddSMTask(volatile struct _qTask_t *Task, qPriority_t Priority, qTime_t Time,
                                volatile struct _qSM_t *StateMachine, qSM_State_t InitState, qSM_ExState_t BeforeAnyState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState,
                                qState_t InitialTaskState, void *arg);
    qBool_t qSchedulerRemoveTask(volatile struct _qTask_t *TasktoRemove);
    void qSchedulerRun(void);
    qBool_t qTaskQueueEvent(volatile struct _qTask_t *Task, void* eventdata);
    void qTaskSendEvent(volatile struct _qTask_t *Task, void* eventdata);



    typedef enum{qRB_AUTOPOP=3, qRB_FULL=4, qRB_COUNT=5, qRB_EMPTY=6}qRBLinkMode_t;





    qBool_t qTaskLinkRBuffer(volatile struct _qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg);

    void qTaskSetTime(volatile struct _qTask_t *Task, qTime_t Value);
    void qTaskSetIterations(volatile struct _qTask_t *Task, qIteration_t Value);
    void qTaskSetPriority(volatile struct _qTask_t *Task, qPriority_t Value);
    void qTaskSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn);
    void qTaskSetState(volatile struct _qTask_t *Task, qState_t State);
    void qTaskSetData(volatile struct _qTask_t *Task, void* arg);
    void qTaskClearTimeElapsed(volatile struct _qTask_t *Task);
    uint32_t qTaskGetCycles(volatile struct _qTask_t *Task);
# 397 "QuarkTS.h"
    qBool_t qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState, qSM_ExState_t BeforeAnyState);
    void qStateMachine_Run(volatile struct _qSM_t *obj, void *Data);
    void qStateMachine_Attribute(volatile struct _qSM_t *obj, qFSM_Attribute_t Flag ,void *val);
# 450 "QuarkTS.h"
        typedef struct{
            qBool_t SR;
            qClock_t Start, TV;
        }qSTimer_t;
        qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time);
        qBool_t qSTimerExpired(qSTimer_t *obj);
        qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time);
        qClock_t qSTimerElapsed(qSTimer_t *obj);
        qClock_t qSTimerRemaining(qSTimer_t *obj);
        void qSTimerDisarm(qSTimer_t *obj);






typedef struct {
    qSize_t BlockSize;
    uint8_t NumberofBlocks;
    uint8_t *BlockDescriptors;
    uint8_t *Blocks;
}qMemoryPool_t;

typedef enum {
    qMB_4B = 4, qMB_8B = 8, qMB_16B = 16, qMB_32B = 32, qMB_64B = 64, qMB_128B = 128,
    qMB_256B = 256, qMB_512B = 512, qMB_1024B = 1024, qMB_2048B = 2048, qMB_4096B = 4096, qMB_8192B = 8192
}qMEM_size_t;
# 503 "QuarkTS.h"
    void* qMemoryAlloc(qMemoryPool_t *obj, qSize_t size);
    void qMemoryFree(qMemoryPool_t *obj, void* pmem);





void qRBufferInit(qRBuffer_t *obj, void* DataBlock, qSize_t ElementSize, qSize_t ElementCount);
qBool_t qRBufferEmpty(qRBuffer_t *obj);
void* qRBufferGetFront(qRBuffer_t *obj);
qBool_t qRBufferPopFront(qRBuffer_t *obj, void *dest);
qBool_t qRBufferPush(qRBuffer_t *obj, void *data);


typedef volatile char qISR_Byte_t;
typedef volatile struct{
    qISR_Byte_t *pdata;
    volatile uint16_t index;
    volatile qBool_t ReadyFlag;
    qBool_t (*AcceptCheck)(const char);
    char (*PreChar)(const char);
    char EndByte;
    uint16_t MaxIndex;
}qISR_ByteBuffer_t;


void qSchedulePrintChain(void);


typedef struct{
    volatile uint16_t head;
    volatile uint16_t tail;
    volatile uint8_t *buffer;
    qSize_t length;
}qBSBuffer_t;

typedef void (*qPutChar_t)(void*, const char);
void qSwapBytes(void *data, qSize_t n);
void qPrintString(qPutChar_t fcn, void* storagep, const char *s);
void qPrintRaw(qPutChar_t fcn, void* storagep, void *data, qSize_t n);


size_t qBSBuffer_Count(qBSBuffer_t const* obj);
qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj);
qBool_t qBSBuffer_Empty(qBSBuffer_t const *obj);
uint8_t qBSBuffer_Peek(qBSBuffer_t const *obj);
qBool_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest);
qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, qSize_t n);
qBool_t qBSBuffer_Put(qBSBuffer_t *obj, uint8_t data);
qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, qSize_t n);
void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, qSize_t length);

qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char));
qBool_t qISR_ByteBufferFill(qISR_ByteBuffer_t *obj, const char newChar);
qBool_t qISR_ByteBufferGet(qISR_ByteBuffer_t *obj, void *dest);
# 30 "QuarkTS.c" 2
# 45 "QuarkTS.c"
static volatile QuarkTSCoreData_t QUARKTS;
static volatile qClock_t _qSysTick_Epochs_ = 0ul;

static qTaskState_t _qScheduler_Dispatch(volatile struct _qTask_t *Task, qTrigger_t Event);
static volatile struct _qTask_t* _qScheduler_GetNodeFromChain(void);
static void _qScheduler_RearrangeChain(volatile struct _qTask_t **head);
static void _qScheduler_PriorizedInsert(volatile struct _qTask_t **head, volatile struct _qTask_t *Task);
static qBool_t _qScheduler_ReadyTasksAvailable(void);
static volatile struct _qTask_t* _qScheduler_PriorityQueueGet(void);
static void _qTriggerReleaseSchedEvent(void);
static qSize_t _qRBufferValidPowerOfTwo(qSize_t k);
static qSize_t _qRBufferCount(qRBuffer_t *obj);
static qBool_t _qRBufferFull(qRBuffer_t *obj);
static qTrigger_t _qCheckRBufferEvents(volatile struct _qTask_t *Task);
# 85 "QuarkTS.c"
volatile struct _qTask_t* qTaskSelf(void){
    return QUARKTS.CurrentRunningTask;
}
# 102 "QuarkTS.c"
qBool_t qTaskIsEnabled(volatile struct _qTask_t *Task){
    if(Task==((void *)0)) return 0x00u;
    return (qBool_t)Task->Flag.Enabled;
}
# 116 "QuarkTS.c"
void qSchedulerSetIdleTask(qTaskFcn_t Callback){
    QUARKTS.IDLECallback = Callback;
}






void qSchedulerRelease(void){
    QUARKTS.Flag.ReleaseSched = 0x01u;
}
# 137 "QuarkTS.c"
void qSchedulerSetReleaseCallback(qTaskFcn_t Callback){
    QUARKTS.ReleaseSchedCallback = Callback;
}
# 153 "QuarkTS.c"
uint32_t qTaskGetCycles(volatile struct _qTask_t *Task){
    if (Task==((void *)0)) return 0ul;
    return Task->Cycles;
}
# 172 "QuarkTS.c"
void qTaskSendEvent(volatile struct _qTask_t *Task, void* eventdata){
    if(Task==((void *)0)) return;
    Task->Flag.AsyncRun = 0x01u;
    Task->AsyncData = eventdata;
}
# 189 "QuarkTS.c"
void qTaskSetTime(volatile struct _qTask_t *Task, qTime_t Value){
    if(Task==((void *)0)) return;
    Task->Interval = (qClock_t)(Value/QUARKTS.Tick);
}
# 209 "QuarkTS.c"
void qTaskSetIterations(volatile struct _qTask_t *Task, qIteration_t Value){
    if(Task==((void *)0)) return;
    Task->Iterations = (Value==((qIteration_t)(-32768)))? ((qIteration_t)(-32768)) : -Value;
}
# 224 "QuarkTS.c"
void qTaskSetPriority(volatile struct _qTask_t *Task, qPriority_t Value){
    if(Task==((void *)0)) return;
    QUARKTS.Flag.Init = 0x00u;
    Task->Priority = Value;
}
# 241 "QuarkTS.c"
void qTaskSetCallback(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn){
    if(Task==((void *)0)) return;
    Task->Callback = CallbackFcn;
}
# 255 "QuarkTS.c"
void qTaskSetState(volatile struct _qTask_t *Task, qState_t State){
    if(Task==((void *)0)) return;
    if(State && Task->Flag.Enabled) return;
    Task->Flag.Enabled = State;
    Task->ClockStart = _qSysTick_Epochs_;
}
# 274 "QuarkTS.c"
void qTaskSetData(volatile struct _qTask_t *Task, void* arg){
    if(Task==((void *)0)) return;
    Task->TaskData = arg;
}
# 287 "QuarkTS.c"
void qTaskClearTimeElapsed(volatile struct _qTask_t *Task){
    if(Task==((void *)0)) return;
    Task->ClockStart = _qSysTick_Epochs_;
}
# 311 "QuarkTS.c"
qBool_t qTaskQueueEvent(volatile struct _qTask_t *Task, void* eventdata){
    if((Task==((void *)0)) || (QUARKTS.QueueIndex>=QUARKTS.QueueSize-1) ) return 0x00u;
    qQueueStack_t qtmp;
    qtmp.Task = Task,
    qtmp.QueueData = eventdata;
    QUARKTS.QueueStack[++QUARKTS.QueueIndex] = qtmp;
    return 0x01u;
}
# 332 "QuarkTS.c"
void qSchedulerSetInterruptsED(void (*Restorer)(uint32_t), uint32_t (*Disabler)(void)){
    QUARKTS.I_Restorer = Restorer;
    QUARKTS.I_Disable = Disabler;
}

static volatile struct _qTask_t* _qScheduler_PriorityQueueGet(void){
    volatile struct _qTask_t *Task = ((void *)0);
    uint8_t i;
    uint8_t IndexTaskToExtract = 0;
    if(QUARKTS.QueueIndex < 0) return ((void *)0);
    if(QUARKTS.I_Disable != ((void *)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    qPriority_t MaxpValue = QUARKTS.QueueStack[0].Task->Priority;
    for(i=1;i<QUARKTS.QueueSize;i++){
        if(QUARKTS.QueueStack[i].Task == ((void *)0)) break;
        if(QUARKTS.QueueStack[i].Task->Priority > MaxpValue){
            MaxpValue = QUARKTS.QueueStack[i].Task->Priority;
            IndexTaskToExtract = i;
        }
    }
    QUARKTS.QueueData = QUARKTS.QueueStack[IndexTaskToExtract].QueueData;
    Task = QUARKTS.QueueStack[IndexTaskToExtract].Task;
    Task->State = 1u;
    QUARKTS.QueueStack[IndexTaskToExtract].Task = ((void *)0);
    for(i=IndexTaskToExtract; i<QUARKTS.QueueIndex; i++) QUARKTS.QueueStack[i] = QUARKTS.QueueStack[i+1];
    QUARKTS.QueueIndex--;
    if(QUARKTS.I_Restorer != ((void *)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
    return Task;
}

void _qInitScheduler(qTime_t ISRTick, qTaskFcn_t IdleCallback, volatile qQueueStack_t *Q_Stack, uint8_t Size_Q_Stack){
    uint8_t i;
    QUARKTS.Head = ((void *)0);
    QUARKTS.Tick = ISRTick;
    QUARKTS.IDLECallback = IdleCallback;
    QUARKTS.ReleaseSchedCallback = ((void *)0);
    QUARKTS.QueueStack = Q_Stack;
    QUARKTS.QueueSize = Size_Q_Stack;
    for(i=0;i<QUARKTS.QueueSize;i++) QUARKTS.QueueStack[i].Task = ((void *)0);
    QUARKTS.QueueIndex = -1;
    QUARKTS.Flag.Init = 0x00u;
    QUARKTS.Flag.ReleaseSched = 0x00u;
    QUARKTS.Flag.FCallReleased = 0x00u;
    QUARKTS.I_Restorer = ((void *)0);
    QUARKTS.I_Disable = ((void *)0);
    QUARKTS.CurrentRunningTask = ((void *)0);
    QUARKTS.QueueData = ((void *)0);
    _qSysTick_Epochs_ = 0ul;
}
# 418 "QuarkTS.c"
qBool_t qSchedulerAddxTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, qTime_t Time, qIteration_t nExecutions, qState_t InitialState, void* arg){
    if(Task==((void *)0)) return 0x00u;
    if (((Time/2)<QUARKTS.Tick && Time) || CallbackFcn == ((void *)0)) return 0x00u;
    qSchedulerRemoveTask(Task);
    Task->Callback = CallbackFcn;
    Task->Interval = (qClock_t)(Time/QUARKTS.Tick);
    Task->TaskData = arg;
    Task->Priority = Priority;
    Task->Iterations = (nExecutions==((qIteration_t)(-32768)))? ((qIteration_t)(-32768)) : -nExecutions;
    Task->Flag.AsyncRun = Task->Flag.InitFlag = Task->Flag.RBAutoPop = Task->Flag.RBCount = Task->Flag.RBCount = Task->Flag.RBEmpty = 0x00u ;
    Task->Flag.Enabled = (qBool_t)(InitialState != 0x00u);
    Task->Next = ((void *)0);
    Task->Cycles = 0;
    Task->ClockStart = _qSysTick_Epochs_;
    Task->RingBuff = ((void *)0);
    Task->StateMachine = ((void *)0);
    Task->State = 3u;
    _qScheduler_PriorizedInsert((volatile struct _qTask_t**)&QUARKTS.Head, Task);
    return 0x01u;
}
# 464 "QuarkTS.c"
qBool_t qSchedulerAddeTask(volatile struct _qTask_t *Task, qTaskFcn_t CallbackFcn, qPriority_t Priority, void* arg){
    return qSchedulerAddxTask(Task, CallbackFcn, Priority, ((qTime_t)(0)), ((qIteration_t)(1)), (0x00u), arg);
}
# 522 "QuarkTS.c"
qBool_t qSchedulerAddSMTask(volatile struct _qTask_t *Task, qPriority_t Priority, qTime_t Time,
                            volatile struct _qSM_t *StateMachine, qSM_State_t InitState, qSM_ExState_t BeforeAnyState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState,
                            qState_t InitialTaskState, void *arg){
    if(StateMachine==((void *)0) || InitState == ((void *)0)) return 0x00u;
    if (!qSchedulerAddxTask(Task, ((qTaskFcn_t)1), Priority, Time, ((qIteration_t)(-32768)), InitialTaskState, arg)) return 0x00u;
    qStateMachine_Init(StateMachine, InitState, SuccessState, FailureState, UnexpectedState, BeforeAnyState);
    Task->StateMachine = StateMachine;
    return 0x01u;
}
# 544 "QuarkTS.c"
qBool_t qSchedulerRemoveTask(volatile struct _qTask_t *Task){
    volatile struct _qTask_t *tmp = QUARKTS.Head;
    volatile struct _qTask_t *prev = ((void *)0);
    if(tmp == ((void *)0)) return 0x00u;
    while(tmp != Task && tmp->Next != ((void *)0)){
        prev = tmp;
        tmp = tmp->Next;
    }
    if(tmp == Task){
        if(prev) prev->Next = tmp->Next;
        else QUARKTS.Head = tmp->Next;
        Task->Next = ((void *)0);
        return 0x01u;
    }
    return 0x00u;
}

static void _qScheduler_PriorizedInsert(volatile struct _qTask_t **head, volatile struct _qTask_t *Task){
    volatile struct _qTask_t *tmp_node = ((void *)0);
    if( (*head == ((void *)0)) || (Task->Priority>(*head)->Priority) ){
        Task->Next = *head;
        *head = Task;
        return;
    }
    tmp_node = *head;
    while(tmp_node->Next && (Task->Priority<=tmp_node->Next->Priority) ) tmp_node = tmp_node->Next;
    Task->Next = tmp_node->Next;
    tmp_node->Next = Task;
}

static void _qScheduler_RearrangeChain(volatile struct _qTask_t **head){
    volatile struct _qTask_t *new_head = ((void *)0);
    volatile struct _qTask_t *tmp = *head;
    volatile struct _qTask_t *tmp1 = ((void *)0);
    if(QUARKTS.I_Disable != ((void *)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    while(tmp){
        tmp1 = tmp;
        tmp = tmp->Next;
        _qScheduler_PriorizedInsert(&new_head, tmp1);
    }
    *head = new_head;
    QUARKTS.Flag.Init= 0x01u;
    if(QUARKTS.I_Restorer != ((void *)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
}
# 629 "QuarkTS.c"
qBool_t qTaskLinkRBuffer(volatile struct _qTask_t *Task, qRBuffer_t *RingBuffer, qRBLinkMode_t Mode, uint8_t arg){
    if(RingBuffer == ((void *)0) || Task==((void *)0) || Mode<qRB_AUTOPOP || Mode>qRB_EMPTY) return 0x00u;
    if(RingBuffer->data == ((void *)0)) return 0x00u;
    Task->Flag.FlagatIndex[Mode] = (qBool_t)((Mode==qRB_COUNT)? arg : (arg!=0x00u));
    Task->RingBuff = (arg>0)? RingBuffer : ((void *)0);
    return 0x01u;
}

static qTrigger_t _qCheckRBufferEvents(volatile struct _qTask_t *Task){
    if(Task==((void *)0)) return qTriggerNULL;
    if(Task->RingBuff == ((void *)0)) return qTriggerNULL;
    if(Task->Flag.RBFull) if(_qRBufferFull(Task->RingBuff)) return byRBufferFull;
    if(Task->Flag.RBCount>0) if(_qRBufferCount(Task->RingBuff) >= Task->Flag.RBCount ) return byRBufferCount;
    if(Task->Flag.RBAutoPop) if(qRBufferGetFront(Task->RingBuff)!=((void *)0)) return byRBufferPop;
    if(Task->Flag.RBEmpty) if(qRBufferEmpty(Task->RingBuff)) return byRBufferEmpty;
    return qTriggerNULL;
}

static void _qTriggerReleaseSchedEvent(void){
    QUARKTS.Flag.Init = 0x00u;
    QUARKTS.Flag.ReleaseSched = 0x00u;
    QUARKTS.EventInfo.FirstCall = (qBool_t)(!QUARKTS.Flag.FCallReleased);
    QUARKTS.EventInfo.Trigger = bySchedulingRelease;
    QUARKTS.EventInfo.TaskData = ((void *)0);
    if(QUARKTS.ReleaseSchedCallback!=((void *)0)) QUARKTS.ReleaseSchedCallback((qEvent_t)&QUARKTS.EventInfo);
    QUARKTS.Flag.FCallIdle = 0x01u;
}







void qSchedulerSysTick(void){_qSysTick_Epochs_++;}
# 672 "QuarkTS.c"
void qSchedulerRun(void){
    volatile struct _qTask_t *Task = ((void *)0);
    QUARKTS.Flag.Init=0x01u; do{
        if(!QUARKTS.Flag.Init) _qScheduler_RearrangeChain((volatile struct _qTask_t**)&QUARKTS.Head);
        if((Task = _qScheduler_PriorityQueueGet())) Task->State = _qScheduler_Dispatch(Task, byQueueExtraction);
        if(_qScheduler_ReadyTasksAvailable()){
            while((Task = _qScheduler_GetNodeFromChain()))
                Task->State = (Task->State == 1u)? _qScheduler_Dispatch(Task, Task->Trigger) : 0u;
        }
        else if(Task==((void *)0) && QUARKTS.IDLECallback) _qScheduler_Dispatch(((void *)0), byNoReadyTasks);
    }while(!QUARKTS.Flag.ReleaseSched); _qTriggerReleaseSchedEvent();
}

static volatile struct _qTask_t* _qScheduler_GetNodeFromChain(void){
    static volatile struct _qTask_t *ChainIterator = ((volatile struct _qTask_t*)-1);
    volatile struct _qTask_t *Node;
    if(ChainIterator == ((volatile struct _qTask_t*)-1)) ChainIterator = QUARKTS.Head;
    Node = ChainIterator;
    ChainIterator = (ChainIterator)? ChainIterator->Next : QUARKTS.Head;
    return Node;
}

static qTaskState_t _qScheduler_Dispatch(volatile struct _qTask_t *Task, qTrigger_t Event){
    switch(Event){
        case byTimeElapsed:
            Task->Iterations = (QUARKTS.EventInfo.FirstIteration = (qBool_t)((Task->Iterations!=((qIteration_t)(-32768))) && (Task->Iterations<0)))? -Task->Iterations : Task->Iterations;
            if(Task->Iterations!= ((qIteration_t)(-32768))) Task->Iterations--;
            if((QUARKTS.EventInfo.LastIteration = (qBool_t)(Task->Iterations == 0))) Task->Flag.Enabled = 0x00u;
            break;
        case byAsyncEvent:
            QUARKTS.EventInfo.EventData = Task->AsyncData;
            Task->Flag.AsyncRun = 0x00u;
            break;
        case byRBufferPop:
            QUARKTS.EventInfo.EventData = qRBufferGetFront(Task->RingBuff);
            break;
        case byRBufferFull: case byRBufferCount: case byRBufferEmpty:
            QUARKTS.EventInfo.EventData = (void*)Task->RingBuff;
            break;
        case byQueueExtraction:
            QUARKTS.EventInfo.EventData = QUARKTS.QueueData;
            QUARKTS.QueueData = ((void *)0);
        case byNoReadyTasks:
            QUARKTS.EventInfo.FirstCall = (qBool_t)(!QUARKTS.Flag.FCallIdle);
            QUARKTS.EventInfo.Trigger = Event;
            QUARKTS.EventInfo.TaskData = ((void *)0);
            QUARKTS.IDLECallback((qEvent_t)&QUARKTS.EventInfo);
            QUARKTS.Flag.FCallIdle = 0x01u;
            return 3u;
        default: break;
    }
    Task->State = 2u;

    QUARKTS.EventInfo.Trigger = Event; QUARKTS.EventInfo.FirstCall = (qBool_t)(!Task->Flag.InitFlag); QUARKTS.EventInfo.TaskData = Task->TaskData;
    QUARKTS.CurrentRunningTask = Task;
    if (Task->StateMachine != ((void *)0) && Task->Callback==((qTaskFcn_t)1)) qStateMachine_Run(Task->StateMachine, (void*)&QUARKTS.EventInfo);
    else if (Task->Callback != ((void *)0)) Task->Callback((qEvent_t)&QUARKTS.EventInfo);
    QUARKTS.CurrentRunningTask = ((void *)0);
    if(Event==byRBufferPop) Task->RingBuff->tail++;
    Task->Flag.InitFlag = 0x01u;

    QUARKTS.EventInfo.FirstIteration = QUARKTS.EventInfo.LastIteration = 0x00u;;
    QUARKTS.EventInfo.EventData = ((void *)0);

    Task->Cycles++;
    return 3u;
}

static qBool_t _qScheduler_ReadyTasksAvailable(void){
    volatile struct _qTask_t *Task = ((void *)0);
    qTrigger_t trg = qTriggerNULL;
    qBool_t nTaskReady = 0x00u;
    for(Task = QUARKTS.Head; Task; Task = Task->Next){
        if(Task->Flag.Enabled){
            if(((((Task->Iterations<0) && (Task->Iterations!=((qIteration_t)(-32768))))? -Task->Iterations : Task->Iterations)>0 || Task->Iterations==((qIteration_t)(-32768)))){
                if(( Task->Interval == ((qTime_t)(0)) || ((_qSysTick_Epochs_ - Task->ClockStart)>=Task->Interval) )){
                    Task->ClockStart = _qSysTick_Epochs_;
                    Task->State = 1u;
                    Task->Trigger = byTimeElapsed;
                    nTaskReady = 0x01u;
                    continue;
                }
            }
        }
        else if((trg=_qCheckRBufferEvents(Task)) != qTriggerNULL){
            Task->State = 1u;
            Task->Trigger = trg;
            nTaskReady = 0x01u;
            continue;
        }
        else if( Task->Flag.AsyncRun){
            Task->State = 1u;
            Task->Trigger = byAsyncEvent;
            nTaskReady = 0x01u;
            continue;
        }
        Task->State = 3u;
    }
    return nTaskReady;
}
# 802 "QuarkTS.c"
qBool_t qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_ExState_t SuccessState, qSM_ExState_t FailureState, qSM_ExState_t UnexpectedState, qSM_ExState_t BeforeAnyState){
    if(obj==((void *)0) || InitState == ((void *)0)) return 0x00u;
    obj->NextState = InitState;
    obj->PreviousState = ((void *)0);
    obj->StateFirstEntry = 0;
    obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;
    obj->_.__Failure = FailureState;
    obj->_.__Success = SuccessState;
    obj->_.__Unexpected = UnexpectedState;
    obj->_.__BeforeAnyState = BeforeAnyState;
    obj->_.Prev = ((void *)0);
    return 0x01u;
}
# 829 "QuarkTS.c"
void qStateMachine_Run(volatile struct _qSM_t *obj, void *Data){
    if(obj == ((void *)0)) return;
    qSM_State_t prev = ((void *)0);
    obj->Data = Data;
    if(obj->_.__BeforeAnyState != ((void *)0)) obj->_.__BeforeAnyState(obj);
    if(obj->NextState!=((void *)0)){
        obj->StateFirstEntry = (qBool_t)(obj->_.Prev != obj->NextState);
        if(obj->StateFirstEntry) obj->PreviousState = obj->_.Prev ;
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->_.Prev = prev;
    }
    else obj->PreviousReturnStatus = qSM_EXIT_FAILURE;

    switch(obj->PreviousReturnStatus){
        case qSM_EXIT_FAILURE:
            if(obj->_.__Failure != ((void *)0)) obj->_.__Failure(obj);
            break;
        case qSM_EXIT_SUCCESS:
            if(obj->_.__Success != ((void *)0)) obj->_.__Success(obj);
            break;
        default:
            if(obj->_.__Unexpected != ((void *)0)) obj->_.__Unexpected(obj);
            break;
    }
 }
# 875 "QuarkTS.c"
void qStateMachine_Attribute(volatile struct _qSM_t *obj, qFSM_Attribute_t Flag ,void *val){
    switch(Flag){
        case qSM_RESTART:
            obj->NextState = (qSM_State_t)val;
            obj->PreviousState = ((void *)0);
            obj->_.Prev = ((void *)0);
            obj->StateFirstEntry = 0;
            obj->PreviousReturnStatus = qSM_EXIT_SUCCESS;
            return;
        case qSM_CLEAR_STATE_FIRST_ENTRY_FLAG:
            obj->PreviousState = ((void *)0);
            obj->_.Prev = ((void *)0);
            return;
        case qSM_FAILURE_STATE:
            obj->_.__Failure = (qSM_ExState_t)val;
            return;
        case qSM_SUCCESS_STATE:
            obj->_.__Success = (qSM_ExState_t)val;
            return;
        case qSM_UNEXPECTED_STATE:
            obj->_.__Unexpected = (qSM_ExState_t)val;
            return;
        case qSM_BEFORE_ANY_STATE:
            obj->_.__BeforeAnyState = (qSM_ExState_t)val;
            return;
        default:
            return;
    }
}
# 924 "QuarkTS.c"
qBool_t qSTimerSet(qSTimer_t *obj, qTime_t Time){
    if(obj==((void *)0)) return 0x00u;
    if ( (Time/2.0)<QUARKTS.Tick ) return 0x00u;
    obj->TV = (qClock_t)(Time/QUARKTS.Tick);
    obj->Start = _qSysTick_Epochs_;
    obj->SR = 0x01u;
    return 0x01u;
}
# 954 "QuarkTS.c"
qBool_t qSTimerFreeRun(qSTimer_t *obj, qTime_t Time){
    if(obj==((void *)0)) return 0x00u;
    if(obj->SR){
        if (qSTimerExpired(obj)){
            qSTimerDisarm(obj);
            return 0x01u;
        }
        else return 0x00u;
    }
    qSTimerSet(obj, Time);
    return 0x00u;
}
# 981 "QuarkTS.c"
qBool_t qSTimerExpired(qSTimer_t *obj){
    if(obj==((void *)0)) return 0x00u;
    if(!obj->SR) return 0x00u;
    return (qBool_t)((_qSysTick_Epochs_ - obj->Start)>=obj->TV);
}
# 999 "QuarkTS.c"
qClock_t qSTimerElapsed(qSTimer_t *obj){
    if(obj==((void *)0)) return 0ul;
    return (_qSysTick_Epochs_-obj->Start);
}
# 1016 "QuarkTS.c"
qClock_t qSTimerRemaining(qSTimer_t *obj){
    if(obj==((void *)0)) return 0;
    qClock_t elapsed = qSTimerElapsed(obj);
    return (obj->TV <= 0 || elapsed>obj->TV)? obj->TV : obj->TV-elapsed;
}
# 1030 "QuarkTS.c"
void qSTimerDisarm(qSTimer_t *obj){
    if(obj==((void *)0)) return;
    obj->SR = 0x00u;
    obj->Start = 0ul;
}
# 1052 "QuarkTS.c"
void* qMemoryAlloc(qMemoryPool_t *obj, qSize_t size){
    if(obj==((void *)0)) return ((void *)0);
    uint8_t i, j, k, c;
    uint16_t sum;
    uint8_t *offset = obj->Blocks;
    j = 0;
    if(QUARKTS.I_Disable != ((void *)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    while( j < obj->NumberofBlocks ) {
        sum = 0;
 i = j;
 while( i < obj->NumberofBlocks ) {
            if( *(obj->BlockDescriptors+i) ) {
                offset += (*(obj->BlockDescriptors+i)) * (obj->BlockSize);
  i += *(obj->BlockDescriptors+i);
  continue;
            }
            break;
 }
 j = i;
 for(k = 1, i = j; i < obj->NumberofBlocks; k++, i++) {
            if( *(obj->BlockDescriptors+i) ) {
                j = (uint8_t)(i + *(obj->BlockDescriptors+i));
  offset = (uint8_t*) obj->Blocks;
  offset += j * (obj->BlockSize);
  break;
            }
            sum += obj->BlockSize;
            if( sum >= size ) {
                *(obj->BlockDescriptors+j) = k;
  for(c=0;c<size;c++) offset[i] = 0x00u;
                if(QUARKTS.I_Restorer != ((void *)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
  return (void*)offset;
            }
 }
 if( i == obj->NumberofBlocks ) break;
    }
    if(QUARKTS.I_Restorer != ((void *)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
    return ((void *)0);
}
# 1104 "QuarkTS.c"
void qMemoryFree(qMemoryPool_t *obj, void* pmem){
    if(obj==((void *)0) || pmem==((void *)0)) return;
    uint8_t i, *p;
    if(QUARKTS.I_Disable != ((void *)0)) QUARKTS.Flag.IntFlags = QUARKTS.I_Disable();
    p = (uint8_t*)obj->Blocks;
    for(i = 0; i < obj->NumberofBlocks; i++) {
        if( p == pmem ){
            *(obj->BlockDescriptors + i) = 0;
            break;
 }
 p += obj->BlockSize;
    }
    if(QUARKTS.I_Restorer != ((void *)0)) QUARKTS.I_Restorer(QUARKTS.Flag.IntFlags);
}




static qSize_t _qRBufferValidPowerOfTwo(qSize_t k){
    uint16_t i;
    if ( ((k-1) & k) != 0) {
        k--;
        for (i = 1; i<sizeof(uint16_t)*8; i=i*2) k = k|k>>i;
        k = (k+1)>>1;
    }
    return k;
}

static qSize_t _qRBufferCount(qRBuffer_t *obj){
    return (obj ? (obj->head - obj->tail) : 0);
}

static qBool_t _qRBufferFull(qRBuffer_t *obj){
    return (qBool_t)(obj ? (qBool_t)(_qRBufferCount(obj) == obj->Elementcount) : 0x01u);
}
# 1157 "QuarkTS.c"
void qRBufferInit(qRBuffer_t *obj, void* DataBlock, qSize_t ElementSize, qSize_t ElementCount){
    if(obj==((void *)0) || DataBlock==((void *)0)) return;
    obj->head = 0;
    obj->tail = 0;
    obj->data = DataBlock;
    obj->ElementSize = ElementSize;
    obj->Elementcount = _qRBufferValidPowerOfTwo(ElementCount);
}
# 1178 "QuarkTS.c"
qBool_t qRBufferEmpty(qRBuffer_t *obj){
    return (qBool_t)(obj ? (qBool_t)(_qRBufferCount(obj) == 0) : 0x01u);
}
# 1194 "QuarkTS.c"
void* qRBufferGetFront(qRBuffer_t *obj){
    if (obj==((void *)0)) return ((void *)0);
    return (void*)(!qRBufferEmpty(obj) ? &(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]) : ((void *)0));
}
# 1212 "QuarkTS.c"
qBool_t qRBufferPopFront(qRBuffer_t *obj, void *dest){
    if(obj == ((void *)0)) return 0x00u;
    void *data = ((void *)0);
    if (!qRBufferEmpty(obj)) {
        data = (void*)(&(obj->data[(obj->tail % obj->Elementcount) * obj->ElementSize]));
        memcpy(dest, data, obj->ElementSize);
        obj->tail++;
        return 0x01u;
    }
    return 0x00u;
}
# 1237 "QuarkTS.c"
qBool_t qRBufferPush(qRBuffer_t *obj, void *data){
    if(obj==((void *)0)) return 0x00u;
    qBool_t status = 0x00u;
    uint8_t *data_element = (uint8_t*)data;
    volatile uint8_t *ring_data = ((void *)0);
    uint16_t i;

    if(obj && data_element){
        if(!_qRBufferFull(obj)){
            ring_data = obj->data + ((obj->head % obj->Elementcount) * obj->ElementSize);
            for (i = 0; i < obj->ElementSize; i++) ring_data[i] = data_element[i];
            obj->head++;
            status = 0x01u;
        }
    }
    return status;
}
# 1265 "QuarkTS.c"
void qSwapBytes(void *data, qSize_t n){
    uint8_t *p = data;
    size_t lo, hi;
    for(lo=0, hi=n-1; hi>lo; lo++, hi--){
        char tmp=p[lo];
        p[lo] = p[hi];
        p[hi] = tmp;
    }
}
# 1283 "QuarkTS.c"
qBool_t qCheckEndianness(void){
    uint16_t i = 1;
    return (qBool_t)( *( (uint8_t*)&i ) );
}
# 1301 "QuarkTS.c"
void qPrintRaw(qPutChar_t fcn, void* storagep, void *data, qSize_t n){
    size_t i = 0;
    char *cdata = data;
    for(i=0;i<n;i++) fcn(storagep, cdata[i]);
}
# 1317 "QuarkTS.c"
void qPrintString(qPutChar_t fcn, void* storagep, const char *s){
    while(*s) fcn(storagep, *s++);
}

qBool_t qISR_ByteBufferInit(qISR_ByteBuffer_t *obj, qISR_Byte_t *pData, qSize_t size, const char EndChar, qBool_t (*AcceptCheck)(const char), char (*PreChar)(const char)){
    if(pData == ((void *)0) || size<2) return 0x00u;
    obj->AcceptCheck = AcceptCheck;
    obj->PreChar = PreChar;
    obj->EndByte = EndChar;
    obj->MaxIndex = (uint16_t)(size - 1);
    obj->pdata = pData;
    obj->index = 0;
    return 0x01u;
}

qBool_t qISR_ByteBufferFill(qISR_ByteBuffer_t *obj, const char newChar){
    if (!obj->ReadyFlag ){
        if(obj->AcceptCheck){
            if(!obj->AcceptCheck(newChar)) return 0x00u;
        }
        obj->pdata[obj->index++] = (obj->PreChar)? obj->PreChar(newChar) : newChar;
        obj->pdata[obj->index] = 0x0u;
        if (obj->index>=(obj->MaxIndex)) obj->index = 0;
        if(newChar == obj->EndByte){
            obj->ReadyFlag = 0x01u;
            obj->index=0;
            return 0x01u;
        }
    }
    return 0x00u;
}

qBool_t qISR_ByteBufferGet(qISR_ByteBuffer_t *obj, void *dest){
    if(obj->ReadyFlag){
        memcpy(dest, (void*)obj->pdata, obj->index);
        obj->ReadyFlag = 0x00u;
        return 0x01u;
    }
    return 0x00u;
}
# 1370 "QuarkTS.c"
size_t qBSBuffer_Count(qBSBuffer_t const* obj){
    return (obj ? (obj->head - obj->tail) : 0);
}
# 1386 "QuarkTS.c"
qBool_t qBSBuffer_IsFull(qBSBuffer_t const* obj){
    return (obj ? (qBSBuffer_Count(obj) == obj->length) : 0x01u);
}
# 1402 "QuarkTS.c"
qBool_t qBSBuffer_Empty(qBSBuffer_t const *obj){
    return (obj ? (qBSBuffer_Count(obj) == 0) : 0x01u);
}
# 1418 "QuarkTS.c"
uint8_t qBSBuffer_Peek(qBSBuffer_t const *obj){
    return (obj ? (obj->buffer[obj->tail % obj->length]) : 0);
}
# 1435 "QuarkTS.c"
qBool_t qBSBuffer_Get(qBSBuffer_t *obj, uint8_t *dest){
    if (!qBSBuffer_Empty(obj)) {
        *dest = obj->buffer[obj->tail % obj->length];
        obj->tail++;
        return 0x01u;
    }
    return 0x00u;
}
# 1457 "QuarkTS.c"
qBool_t qBSBuffer_Read(qBSBuffer_t *obj, void *dest, qSize_t n){
    qSize_t i;
    uint8_t *data = (uint8_t*)dest;
    if(n<=0) return 0x00u;
    for(i=0;i<n;i++){
        if (!qBSBuffer_Get(obj, data+i)) return 0x00u;
    }
    return 0x01u;
}
# 1480 "QuarkTS.c"
qBool_t qBSBuffer_Put(qBSBuffer_t *obj, uint8_t data){
    qBool_t status = 0x00u;
    if(obj){
        if(!qBSBuffer_IsFull(obj)) {
            obj->buffer[obj->head % obj->length] = data;
            obj->head++;
            status = 0x01u;
        }
    }
    return status;
}
# 1506 "QuarkTS.c"
void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, qSize_t length){
    if(obj){
        obj->head = 0;
        obj->tail = 0;
        obj->buffer = buffer;
        obj->length = _qRBufferValidPowerOfTwo(length);
    }
}


void qSchedulePrintChain(void){
    volatile struct _qTask_t *Task;
    puts("--------------------------------------------------------------------");
    puts("TaskData\tPriority\tInterval\tIterations");
    puts("--------------------------------------------------------------------");
    for(Task = QUARKTS.Head; Task != ((void *)0); Task = Task->Next){
        printf("%s\t\t%d\t\t%d\t\t", (char*)Task->TaskData,Task->Priority, Task->Interval);
        if(Task->Iterations == ((qIteration_t)(-32768))) puts("qPeriodic");
        else printf("%d\r\n",-Task->Iterations);

    }
    puts("--------------------------------------------------------------------");
}
