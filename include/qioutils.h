/*!
 * @file qioutils.h
 * @author J. Camilo Gomez C.
 * @version 4.60
 * @note This file is part of the QuarkTS distribution.
 * @brief API for input/output utilities and safe string interfaces.
 **/
#ifndef QIOUTILS_H
    #define QIOUTILS_H

    #include "qtypes.h"
    #include "qconfig.h"
    #include "qedgecheck.h"
    
    #include <string.h>
    #include <ctype.h>

    #ifdef __cplusplus
    extern "C" {
    #endif


    #ifndef  Q_MAX_FTOA_PRECISION
        #define Q_MAX_FTOA_PRECISION    ( 10u )
    #endif
    
    #ifndef Q_ATOF_FULL
        #define Q_ATOF_FULL             ( 0 )
    #endif

    #define Q_IOUTIL_MAX_STRLEN      ( (size_t)512 )

    /** @addtogroup qioutils I/O Utils
    * @brief API for input/output utilities and safe string interfaces.
    *  @{
    */   


    /**
    * @brief Pointer to function that write-out a single character
    * 
    * @note  User should use bare-metal code to implement this function.
    * Example :
    * @code{.c}
    * void BSP_PutChar( void *sp, const char c ){
    *       (void)sp;
    *       HAL_UARTWriteByte( c );    
    * }
    * @endcode
    * @param[in] sp The user storage pointer.
    * @param[in] c The character to write out.
    * @return none.
    */
    typedef void (*qPutChar_t)(void* arg1, const char arg2);

     /**
    * @brief Pointer to function that get-a single character
    * 
    * @note  User should use bare-metal code to implement this function.
    * Example :
    * @code{.c}
    * char BSP_GetChar( void *sp ){
    *       (void)sp;
    *       return HAL_UARTReceiveByte( );    
    * }
    * @endcode
    * @param[in] sp The user storage pointer.
    * @return none.
    */   
    typedef char (*qGetChar_t)(void* arg1);

    /**
    * @brief Returns a pointer to the first occurrence of character in the C string 
    * @a s.
    * The terminating null-character is considered part of the C string. Therefore, 
    * it can also be located in order to retrieve a pointer to the end of a string.
    * @param[in] s Pointer to the null-terminated byte string to be examined
    * @param[in] c Character to be located. It is passed as its int promotion, but it 
    * is internally converted back to char for the comparison.
    * @param[in] maxlen Maximum number of characters to examine
    * @return A pointer to the first occurrence of character in @a s. 
    * If the character is not found, the function returns a null pointer.
    */     
    char* qIOUtil_StrChr( const char *s, int c, size_t maxlen );

    /**
    * @brief Returns the length of the given null-terminated byte string, that is, the number 
    * of characters in a character array whose first element is pointed to by @a str up 
    * to and not including the first null character.
    * The function returns zero if @a str is a null pointer and returns @a maxlen if the 
    * null character was not found in the first @a maxlen bytes of @a str.
    * @param[in] str Pointer to the null-terminated byte string to be examined
    * @param[in] maxlen Maximum number of characters to examine
    * @return The length of the null-terminated byte string @a str on success, zero if @a str 
    * is a null pointer, @a maxlen if the null character was not found.
    */  
    size_t qIOUtil_StrLen( const char* str, size_t maxlen);

    /**
    * @brief Copies up to @a (maxlen - 1) characters from the null-terminated string @a src to 
    * @a dst, null-terminating the result.
    * @param[out] dst The destination string
    * @param[in] src The source string
    * @param[in] maxlen Maximum number of characters to copy
    * @return The length of @a src
    */      
    size_t qIOUtil_StrlCpy( char * dst, const char * src, size_t maxlen );

    /**
    * @brief Invert the endianess for n bytes of the specified memory location.
    * @param[in,out] Data A pointer to block of data
    * @param[in] n The number of bytes to swap
    * @return none.
    */     
    void qIOUtil_SwapBytes( void *Data, const size_t n );

    /**
    * @brief Check the system endianess
    * @return #qTrue if Little-Endian, otherwise returns #qFalse.
    */     
    qBool_t qIOUtil_CheckEndianness( void );

    /**
    * @brief API interface to write a string through @a fcn 
    * @param[in] fcn The basic output byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[in] s The string to be written
    * @param[in] AIP Auto-Increment the storage-pointer
    * @return none.
    */      
    void qIOUtil_OutputString( qPutChar_t fcn, void* pStorage, const char *s, qBool_t AIP );

    /**
    * @brief API interface to write data in HEX notation through @a fcn 
    * @param[in] fcn The basic output byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[in] Data A pointer to the block of data
    * @param[in] n The number of bytes to print out
    * @return none.
    */      
    void qIOUtil_PrintXData( qPutChar_t fcn, void* pStorage, void *Data, size_t n );

    /**
    * @brief API interface to write n RAW data through @a fcn
    * @param[in] fcn The basic output byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[in] Data A pointer to the block of data
    * @param[in] n The number of bytes that will be transferred to the output
    * @param[in] AIP Auto-Increment the storage-pointer
    * @return none.
    */      
    void qIOUtil_OutputRaw( qPutChar_t fcn, void* pStorage, void *Data, const size_t n, qBool_t AIP );

    /**
    * @brief API interface to get n RAW data through @a fcn
    * @param[in] fcn The basic input byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[out] Data A pointer to the block where the read data will be saved
    * @param[in] n The number of bytes to get
    * @param[in] AIP Auto-Increment the storage-pointer
    * @return none.
    */      
    void qIOUtil_InputRaw( const qGetChar_t fcn, void* pStorage, void *Data, const size_t n, qBool_t AIP );
      
    /**
    * @brief Macro interface to write a string through @a fcn
    * @param[in] fcn The basic input byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[in] s The string to be written
    * @return none.
    */      
    #define qIOUtil_PrintString( fcn, pStorage, s )          qIOUtil_OutputString( (fcn), (void*)(pStorage), (const char *)(s), qFalse )
   
    /**
    * @brief Macro interface to write RAW datathrough @a fcn
    * @param[in] fcn The basic input byte function
    * @param[in] pStorage The storage pointer passed to @a fcn
    * @param[in] Data A pointer to the block of data
    * @param[in] n The number of bytes to print out.
    * @return none.
    */      
    #define qIOUtil_PrintRaw( fcn, pStorage, Data, n )       qIOUtil_OutputRaw( (fcn), (void*)(pStorage), (void*)(Data), (n), qFalse ) 

    /**
    * @brief Converts an unsigned integer value to a null-terminated string using the 16 base
    * and stores the result in the array given by @a str parameter.
    * @a str should be an array long enough to contain any possible value.
    * @param[in] value Value to be converted to a string.
    * @param[out] str Array in memory where to store the resulting null-terminated string.
    * @param[in] n The number of chars used to represent the value in @a str
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */ 
    char* qIOUtil_U32toX( qUINT32_t value, char *str, qINT8_t n );

    /**
    * @brief Converts the input string consisting of hexadecimal digits into an unsigned 
    * integer value. The input parameter should consist exclusively of hexadecimal 
    * digits, with optional whitespaces. The string will be processed one character at
    * a time, until the function reaches a character which it doesn't recognize
    * (including a null character).
    * @param[in] s The hex string to be converted.
    * @return The numeric value uint32_t.
    */ 
    qUINT32_t qIOUtil_XtoU32( const char *s );

    /**
    * @brief Parses the C string @a s, interpreting its content as a floating point number and 
    * returns its value as a double(qFloat64_t). The function first discards as many 
    * whitespace characters (as in isspace) as necessary until the first non-whitespace 
    * character is found. Then, starting from this character, takes as many characters 
    * as possible that are valid following a syntax resembling that of floating point 
    * literals, and interprets them as a numerical value. The rest of the string after
    * the last valid character is ignored and has no effect on the behavior of this 
    * function.
    * @param[in] s The string beginning with the representation of a floating-point number.
    * @return  On success, the function returns the converted floating point number as 
    * a double(qFloat64_t) value.
    * If no valid conversion could be performed, the function returns zero (0.0).
    * If the converted value would be out of the range of representable values by
    * a double(qFloat64_t), it causes undefined behavior
    */     
    qFloat64_t qIOUtil_AtoF( const char *s );

    /**
    * @brief Converts a float value to a formatted string.
    * @param[in] num Value to be converted to a string.
    * @param[out] str  Array in memory where to store the resulting null-terminated string.
    * @param[in] precision Desired number of significant fractional digits in the string.
    * (The max allowed precision is MAX_FTOA_PRECISION=10)
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */     
    char* qIOUtil_FtoA( qFloat32_t num, char *str, qUINT8_t precision );

    /**
    * @brief Parses the C-string @a s interpreting its content as an integral number, which is 
    * returned as a value of type int. The function first discards as many whitespace
    * characters (as in isspace) as necessary until the first non-whitespace character 
    * is found. Then, starting from this character, takes an optional initial plus or
    * minus sign followed by as many base-10 digits as possible, and interprets them 
    * as a numerical value.
    * The string can contain additional characters after those that form the integral
    * number, which are ignored and have no effect on the behavior of this function.
    * If the first sequence of non-whitespace characters in @a s is not a valid integral 
    * number, or if no such sequence exists because either @a s is empty or it contains 
    * only whitespace characters, no conversion is performed and zero is returned.
    * @param[in] s The string beginning with the representation of a integer number.
    * @return On success, the function returns the converted integral number as an int value.
    * If the converted value would be out of the range of representable values by 
    * an int, it causes undefined behavior.
    */     
    int qIOUtil_AtoI( const char *s );

    /**
    * @brief Converts an unsigned value to a null-terminated string using the specified base 
    * and stores the result in the array given by @a str parameter. 
    * The argument @a str should be an array long enough to contain any possible value: 
    * (sizeof(int)*8+1) for radix=2, i.e. 17 bytes in 16-bits platforms and 33 in 
    * 32-bits platforms.
    * @param[in] num Value to be converted to a string.
    * @param[out] str  Array in memory where to store the resulting null-terminated string.
    * @param[in] base Numerical base used to represent the value as a string, between 2 
    * and 36, where 10 means decimal base, 16 hexadecimal, 8 octal, and 2 binary. 
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */       
    char* qIOUtil_UtoA( qUINT32_t num, char* str, qUINT8_t base );

    /**
    * @brief Converts an integer value to a null-terminated string using the specified base 
    * and stores the result in the array given by @a str parameter. If base is 10 and 
    * value is negative, the resulting string is preceded with a minus sign (-). 
    * With any other base, value is always considered unsigned.
    * 
    * The argument @a str should be an array long enough to contain any possible value: 
    * (sizeof(int)*8+1) for radix=2, i.e. 17 bytes in 16-bits platforms and 33 in 
    * 32-bits platforms.
    * @param[in] num Value to be converted to a string.
    * @param[out] str  Array in memory where to store the resulting null-terminated string.
    * @param[in] base Numerical base used to represent the value as a string, between 2 
    * and 36, where 10 means decimal base, 16 hexadecimal, 8 octal, and 2 binary. 
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */      
    char* qIOUtil_ItoA( qINT32_t num, char* str, qUINT8_t base );

    /**
    * @brief Converts a boolean value to a null-terminated string. Input is considered true
    * with any value different to zero (0).
    * The argument @a str should be an array long enough to contain the output
    * @param[in] num Value to be converted to a string.
    * @param[out] str  Array in memory where to store the resulting null-terminated string.
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */      
    char* qIOUtil_BtoA( qBool_t num, char *str );

    /**
    * @brief Converts a qBool_t value to a null-terminated string. Input is considered true
    * with any value different to zero (0).
    * The argument @a str should be an array long enough to contain the output
    * @param[in] num Value to be converted to a string.
    * @param[out] str  Array in memory where to store the resulting null-terminated string.
    * @return A pointer to the resulting null-terminated string, same as parameter @a str.
    */     
    char* qIOUtil_QBtoA( qBool_t num, char *str );

    /**
    * @brief Determines if the given floating point number arg is positive or negative infinity.
    * @param[in] f Floating point value(32bits).
    * @return #qTrue is argument has an infinite value, otherwise #qFalse.
    */      
    qBool_t qIOUtil_IsInf( qFloat32_t f );

    /**
    * @brief Determines if the given floating point number arg is a not-a-number (NaN) value. 
    * @param[in] f Floating point value(32bits).
    * @return #qTrue is argument is NaN, otherwise #qFalse
    */       
    qBool_t qIOUtil_IsNan( qFloat32_t f );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
