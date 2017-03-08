# 1 "QuarkSM.c"
# 1 "/cygdrive/e/GDrive/Proyects/libs/c/QuarkTS//"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "QuarkSM.c"
# 1 "QuarkSM.h" 1
# 27 "QuarkSM.h"
# 1 "/usr/include/stdlib.h" 1 3 4
# 10 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/machine/ieeefp.h" 1 3 4
# 11 "/usr/include/stdlib.h" 2 3 4
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
# 12 "/usr/include/stdlib.h" 2 3 4




# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 212 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 324 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef short unsigned int wchar_t;
# 17 "/usr/include/stdlib.h" 2 3 4

# 1 "/usr/include/sys/reent.h" 1 3 4
# 13 "/usr/include/sys/reent.h" 3 4
# 1 "/usr/include/_ansi.h" 1 3 4
# 14 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 147 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 3 4
typedef long int ptrdiff_t;
# 15 "/usr/include/sys/reent.h" 2 3 4
# 1 "/usr/include/sys/_types.h" 1 3 4
# 12 "/usr/include/sys/_types.h" 3 4
# 1 "/usr/include/machine/_types.h" 1 3 4






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
# 8 "/usr/include/machine/_types.h" 2 3 4
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
# 19 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 45 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-cygwin/4.9.3/include/stddef.h" 1 3 4
# 46 "/usr/include/sys/cdefs.h" 2 3 4
# 20 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/machine/stdlib.h" 1 3 4
# 17 "/usr/include/machine/stdlib.h" 3 4
char *mkdtemp (char *);
# 21 "/usr/include/stdlib.h" 2 3 4

# 1 "/usr/include/alloca.h" 1 3 4
# 23 "/usr/include/stdlib.h" 2 3 4



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


char *canonicalize_file_name (const char *);
int unsetenv (const char *);


char *initstate (unsigned seed, char *state, size_t size);
long random (void);
char *setstate (const char *state);
void srandom (unsigned);


char *ptsname (int);
int ptsname_r(int, char *, size_t);
int getpt (void);
int grantpt (int);
int unlockpt (int);


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




typedef struct
{
  long long int quot;
  long long int rem;
} lldiv_t;




typedef int (*__compar_fn_t) (const void *, const void *);







int __attribute__((__cdecl__)) __locale_mb_cur_max (void);



void __attribute__((__cdecl__)) abort (void) __attribute__ ((__noreturn__));
int __attribute__((__cdecl__)) abs (int);
int __attribute__((__cdecl__)) atexit (void (*__func)(void));
double __attribute__((__cdecl__)) atof (const char *__nptr);

float __attribute__((__cdecl__)) atoff (const char *__nptr);

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

extern char *suboptarg;
int __attribute__((__cdecl__)) getsubopt (char **, char * const *, char **);

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


char * __attribute__((__cdecl__)) mkdtemp (char *);
int __attribute__((__cdecl__)) mkostemp (char *, int);
int __attribute__((__cdecl__)) mkostemps (char *, int, int);
int __attribute__((__cdecl__)) mkstemp (char *);
int __attribute__((__cdecl__)) mkstemps (char *, int);
char * __attribute__((__cdecl__)) mktemp (char *) __attribute__ ((__warning__ ("the use of `mktemp' is dangerous; use `mkstemp' instead")));

char * __attribute__((__cdecl__)) _mkdtemp_r (struct _reent *, char *);
int __attribute__((__cdecl__)) _mkostemp_r (struct _reent *, char *, int);
int __attribute__((__cdecl__)) _mkostemps_r (struct _reent *, char *, int, int);
int __attribute__((__cdecl__)) _mkstemp_r (struct _reent *, char *);
int __attribute__((__cdecl__)) _mkstemps_r (struct _reent *, char *, int);
char * __attribute__((__cdecl__)) _mktemp_r (struct _reent *, char *) __attribute__ ((__warning__ ("the use of `mktemp' is dangerous; use `mkstemp' instead")));

void __attribute__((__cdecl__)) qsort (void * __base, size_t __nmemb, size_t __size, __compar_fn_t _compar);
int __attribute__((__cdecl__)) rand (void);
void * __attribute__((__cdecl__)) realloc (void * __r, size_t __size) ;

void * __attribute__((__cdecl__)) reallocf (void * __r, size_t __size);
char * __attribute__((__cdecl__)) realpath (const char * path, char * resolved_path);

void __attribute__((__cdecl__)) srand (unsigned __seed);
double __attribute__((__cdecl__)) strtod (const char * __n, char ** __end_PTR);
double __attribute__((__cdecl__)) _strtod_r (struct _reent *,const char * __n, char ** __end_PTR);



float __attribute__((__cdecl__)) strtof (const char * __n, char ** __end_PTR);







long __attribute__((__cdecl__)) strtol (const char * __n, char ** __end_PTR, int __base);
long __attribute__((__cdecl__)) _strtol_r (struct _reent *,const char * __n, char ** __end_PTR, int __base);
unsigned long __attribute__((__cdecl__)) strtoul (const char * __n, char ** __end_PTR, int __base);
unsigned long __attribute__((__cdecl__)) _strtoul_r (struct _reent *,const char * __n, char ** __end_PTR, int __base);

int __attribute__((__cdecl__)) system (const char *__string);


long __attribute__((__cdecl__)) a64l (const char *__input);
char * __attribute__((__cdecl__)) l64a (long __input);
char * __attribute__((__cdecl__)) _l64a_r (struct _reent *,long __input);
int __attribute__((__cdecl__)) on_exit (void (*__func)(int, void *),void * __arg);




void __attribute__((__cdecl__)) _Exit (int __status) __attribute__ ((__noreturn__));


int __attribute__((__cdecl__)) putenv (char *__string);
int __attribute__((__cdecl__)) _putenv_r (struct _reent *, char *__string);
void * __attribute__((__cdecl__)) _reallocf_r (struct _reent *, void *, size_t);
int __attribute__((__cdecl__)) setenv (const char *__string, const char *__value, int __overwrite);
int __attribute__((__cdecl__)) _setenv_r (struct _reent *, const char *__string, const char *__value, int __overwrite);

char * __attribute__((__cdecl__)) gcvt (double,int,char *);
char * __attribute__((__cdecl__)) gcvtf (float,int,char *);
char * __attribute__((__cdecl__)) fcvt (double,int,int *,int *);
char * __attribute__((__cdecl__)) fcvtf (float,int,int *,int *);
char * __attribute__((__cdecl__)) ecvt (double,int,int *,int *);
char * __attribute__((__cdecl__)) ecvtbuf (double, int, int*, int*, char *);
char * __attribute__((__cdecl__)) fcvtbuf (double, int, int*, int*, char *);
char * __attribute__((__cdecl__)) ecvtf (float,int,int *,int *);
char * __attribute__((__cdecl__)) dtoa (double, int, int, int *, int*, char**);

char * __attribute__((__cdecl__)) __itoa (int, char *, int);
char * __attribute__((__cdecl__)) __utoa (unsigned, char *, int);

char * __attribute__((__cdecl__)) itoa (int, char *, int);
char * __attribute__((__cdecl__)) utoa (unsigned, char *, int);
int __attribute__((__cdecl__)) rand_r (unsigned *__seed);

double __attribute__((__cdecl__)) drand48 (void);
double __attribute__((__cdecl__)) _drand48_r (struct _reent *);
double __attribute__((__cdecl__)) erand48 (unsigned short [3]);
double __attribute__((__cdecl__)) _erand48_r (struct _reent *, unsigned short [3]);
long __attribute__((__cdecl__)) jrand48 (unsigned short [3]);
long __attribute__((__cdecl__)) _jrand48_r (struct _reent *, unsigned short [3]);
void __attribute__((__cdecl__)) lcong48 (unsigned short [7]);
void __attribute__((__cdecl__)) _lcong48_r (struct _reent *, unsigned short [7]);
long __attribute__((__cdecl__)) lrand48 (void);
long __attribute__((__cdecl__)) _lrand48_r (struct _reent *);
long __attribute__((__cdecl__)) mrand48 (void);
long __attribute__((__cdecl__)) _mrand48_r (struct _reent *);
long __attribute__((__cdecl__)) nrand48 (unsigned short [3]);
long __attribute__((__cdecl__)) _nrand48_r (struct _reent *, unsigned short [3]);
unsigned short *
       __attribute__((__cdecl__)) seed48 (unsigned short [3]);
unsigned short *
       __attribute__((__cdecl__)) _seed48_r (struct _reent *, unsigned short [3]);
void __attribute__((__cdecl__)) srand48 (long);
void __attribute__((__cdecl__)) _srand48_r (struct _reent *, long);




long long __attribute__((__cdecl__)) atoll (const char *__nptr);


long long __attribute__((__cdecl__)) _atoll_r (struct _reent *, const char *__nptr);




long long __attribute__((__cdecl__)) llabs (long long);
lldiv_t __attribute__((__cdecl__)) lldiv (long long __numer, long long __denom);
long long __attribute__((__cdecl__)) strtoll (const char * __n, char ** __end_PTR, int __base);


long long __attribute__((__cdecl__)) _strtoll_r (struct _reent *, const char * __n, char ** __end_PTR, int __base);




unsigned long long __attribute__((__cdecl__)) strtoull (const char * __n, char ** __end_PTR, int __base);


unsigned long long __attribute__((__cdecl__)) _strtoull_r (struct _reent *, const char * __n, char ** __end_PTR, int __base);
# 246 "/usr/include/stdlib.h" 3 4
char * __attribute__((__cdecl__)) _dtoa_r (struct _reent *, double, int, int, int *, int*, char**);







int __attribute__((__cdecl__)) _system_r (struct _reent *, const char *);

void __attribute__((__cdecl__)) __eprintf (const char *, const char *, unsigned int, const char *);
# 279 "/usr/include/stdlib.h" 3 4
extern long double strtold (const char *, char **);




# 28 "QuarkSM.h" 2

typedef enum state {SM_ERROR = 0xFEEF, SM_OK = 0xFEAF} qSM_Status_t;

struct _qSM_t{
    qSM_Status_t (*NextState)(volatile struct _qSM_t*);
    qSM_Status_t (*PreviousState)(volatile struct _qSM_t*);
    qSM_Status_t PreviousReturnStatus;
};


typedef qSM_Status_t (*qSM_State_t)(volatile struct _qSM_t*);

int _qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_State_t OKState, qSM_State_t ErrorState, qSM_State_t UnexpectedState);
int _qStateMachine_Run(volatile struct _qSM_t *obj);
# 2 "QuarkSM.c" 2

static qSM_Status_t (*__qSM_Error)(volatile struct _qSM_t*) = ((void *)0);
static qSM_Status_t (*__qSM_OK)(volatile struct _qSM_t*) = ((void *)0);
static qSM_Status_t (*__qSM_Unexpected)(volatile struct _qSM_t*) = ((void *)0);


int _qStateMachine_Init(volatile struct _qSM_t *obj, qSM_State_t InitState, qSM_State_t OKState, qSM_State_t ErrorState, qSM_State_t UnexpectedState){
    obj->NextState = InitState;
    obj->PreviousState = ((void *)0);
    __qSM_Error = ErrorState;
    __qSM_OK = OKState;
    __qSM_Unexpected = UnexpectedState;
}

int _qStateMachine_Run(volatile struct _qSM_t *obj){
    qSM_State_t prev = ((void *)0);
    if(obj->NextState!=((void *)0)){
        prev = obj->NextState;
        obj->PreviousReturnStatus = obj->NextState(obj);
        obj->PreviousState = prev;
    }
    else obj->PreviousReturnStatus = SM_ERROR;

    switch(obj->PreviousReturnStatus){
        case SM_ERROR:
            if(__qSM_Error != ((void *)0)) __qSM_Error(obj);
            break;
        case SM_OK:
            if(__qSM_OK != ((void *)0)) __qSM_OK(obj);
            break;
        default:
            if(__qSM_Unexpected != ((void *)0)) __qSM_Unexpected(obj);
            break;
    }

    return 0;
 }
