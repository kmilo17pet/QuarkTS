/*!
 * @file qflm.h
 * @author J. Camilo Gomez C.
 * @version 1.43
 * @note This file is part of the QuarkTS distribution.
 * @brief General purpose Function-like Macros
 **/
#ifndef QFLM_H
    #define QFLM_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    /** @addtogroup qflm
    * @brief General purpose Function-like Macros
    * @{
    */

    /**
    * @brief Uses the bitwise OR operator to set bits into @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBits Indicates which bits are to be set
    * @return none.
    */
    #define qFLM_BitsSet( dst, xBits )    (dst) |= (xBits)

    /**
    * @brief Uses the bitwise AND operator to clear  bits into @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBits Indicates which bits are to be cleared
    * @return none.
    */
    #define qFLM_BitsClear( dst, xBits )  (dst) &= ~(xBits)

    /**
    * @brief Uses the bitwise OR operator to set a single bit into @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBit The bit-index
    * @return none.
    */
    #define qFLM_BitSet( dst, xBit, xType )                                 \
    (dst) |= (xType)( (xType)1u << (xBit) )                                 \

    /**
    * @brief Uses the bitwise AND operator to clear a single bit into @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBit The bit-index
    * @return none.
    */
    #define qFLM_BitClear( dst, xBit, xType )                               \
    (dst) &= (xType)( ~( (xType)1u << (xBit) ) )                            \

    /**
    * @brief Uses the bitwise AND operator to read the value of a single bit
    * from @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBit The bit-index
    * @return The value of the requested bit.
    */
    #define qFLM_BitRead( dst, xBit )                                       \
    ( ( qFalse == ( (dst) & ( 1 << (xBit) ) ) )? qFalse : qTrue )           \

    /**
    * @brief Uses the bitwise XOR operator to toggle the value of a single bit
    * from @a dst
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBit The bit-index
    * @return none.
    */
    #define qFLM_BitToggle( dst, xBit )   ( (dst) ^= ( 1 << (xBit) ) )

    /**
    * @brief Write the @a bVal in a single bit of the @a dst variable
    * @param[in] dst The variable where the operation will be applied
    * @param[in] xBit The bit-index
    * @param[in] bVal The boolean value to write
    * @return none.
    */
    #define qFLM_BitWrite( dst, xBit, xVal )                                \
    ( (xVal) ? qFLM_BitSet( (dst), (xBit) )                                 \
             : qFLM_BitClear( (dst),(xBit) ) )                              \

    /**
    * @brief Build a byte value from independent bits
    * @param[in] b7...b0
    * @return The value of the byte formed
    */
    #define qFLM_BitMakeByte( b7, b6, b5, b4, b3, b2, b1, b0 )              \
    (qUINT8_t)(                                                             \
                ( (b7) << 7 ) +                                             \
                ( (b6) << 6 ) +                                             \
                ( (b5) << 5 ) +                                             \
                ( (b4) << 4 ) +                                             \
                ( (b3) << 3 ) +                                             \
                ( (b2) << 2 ) +                                             \
                ( (b1) << 1 ) +                                             \
                ( (b0) << 0 )                                               \
              )                                                             \

    /**
    * @brief Read the high-nibble from @a dst
    * @param[in] dst The variable where the operation will be applied
    * @return The value of the high nibble
    */
    #define qFLM_ByteHighNibble( dst )    ( (qUINT8_t)( (dst) >> 4 ) )

    /**
    * @brief Read the low-nibble from @a dst
    * @param[in] dst The variable where the operation will be applied
    * @return The value of the low nibble
    */
    #define qFLM_ByteLowNibble( dst )     ( (qUINT8_t)( (dst) & 0x0F ) )

    /**
    * @brief Merges two nibbles to form one byte.
    * @param[in] H The high nibble
    * @param[in] L The low nibble
    * @return The value of the resulting byte
    */
    #define qFLM_ByteMergeNibbles( H, L )                                   \
    ( (qUINT8_t)( ( (H) << 4 ) | ( 0x0F & (L) ) ) )                         \

    /**
    * @brief Read the high-byte from @a dst assuming it as a Word
    * @param[in] dst The variable where the operation will be applied
    * @return The value of the high byte
    */
    #define qFLM_WordHighByte( dst )      ( (qUINT8_t)( (dst) >> 8 ) )

    /**
    * @brief Read the low-byte from @a dst  assuming it as a Word
    * @param[in] dst The variable where the operation will be applied
    * @return The value of the low byte
    */
    #define qFLM_WordLowByte( dst )       ( (qUINT8_t)( (dst) & 0x00FF ) )

    /**
    * @brief Merges two bytes to form one Word.
    * @param[in] H The high byte
    * @param[in] L The low byte
    * @return The value of the resulting word
    */
    #define qFLM_WordMergeBytes( H, L )                                     \
    ( (qUINT16_t) ( ( (H) << 8 ) | (L) ) )                                  \

    /**
    * @brief Read the high-word from @a dst  assuming it as a DWord
    * @param[in] dst The variable where the operation will be applied
    * @return The value of the high word
    */
    #define qFLM_DWordHighWord( dst )     ( (qUINT16_t)( (dst) >> 16 ) )

    /**
    * @brief Read the low-word from @a dst  assuming it as a DWord
    * @param[in] Register The variable where the operation will be applied
    * @return The value of the low word
    */
    #define qFLM_DWordLowWord( dst )      ( (qUINT16_t)( (dst) & 0xFFFF ) )

    /**
    * @brief Merges two words to form one DWord.
    * @param[in] H The high word
    * @param[in] L The low word
    * @return The value of the resulting DWord
    */
    #define qFLM_DWordMergeWords( H, L )                                    \
    ( (qUINT32_t)( ( (qUINT32_t)(H) << 16 ) | (L) ) )                       \

    /**
    * @brief Ensures that @a X is between the limits set by @a Min and @a Max.
    * @note If @a Min is greater than @a Max the result is undefined.
    * @param[in] X The value to clamp
    * @param[in] Min The minimum value allowed.
    * @param[in] Max The maximum value allowed.
    * @return The value of @a X clamped to the range between @a Min and @a Max.
    */
    #define qFLM_Clip( X, Min, Max )                                        \
    ( ( (X) < (Min) ) ? (Min) : ( ( (X) > (Max) ) ? (Max) : (X) ) )         \

    /**
    * @brief Ensures that @a X  is bellow the limits set by @a Max.
    * @param[in] X The value to clamp
    * @param[in] Max The maximum value allowed.
    * @return The value of @a X clamped to the value of @a Max.
    */
    #define qFLM_ClipUpper( X, Max )        ( ( (X) > (Max) ) ? (Max) : (X) )

    /**
    * @brief Ensures that @a X  is above the value set by @a Min.
    * @param[in] X The value to clamp
    * @param[in] Min The minimum value allowed.
    * @return The value of @a X clamped to the value of @a Min.
    */
    #define qFLM_ClipLower( X, Min )        ( ( (X) < (Min) ) ? (Min) : (X) )

    /**
    * @brief Check if the value of @a X  is within the limits defined by
    * @a Low and @a High.
    * @param[in] X The value to check
    * @param[in] Low The minimum value allowed.
    * @param[in] High The maximum value allowed.
    * @return True if the @a X is between the defined range. Otherwise returns
    * false.
    */
    #define qFLM_IsBetween( X, Low, High )                                  \
    ( ( (X) >= (Low) ) && ( (X) <= (High) ) )                               \

    /**
    * @brief Calculates the minimum of @a a and @a b.
    * @param[in] a A numeric value
    * @param[in] b A numeric value
    * @return The minimum of @a a and @a b.
    */
    #define qFLM_Min( a, b )                ( ( (a) < (b) )? (a) : (b) )

    /**
    * @brief Calculates the maximum  of @a a and @a b.
    * @param[in] a A numeric value
    * @param[in] b A numeric value
    * @return The maximum  of @a a and @a b.
    */
    #define qFLM_Max( a, b )                ( ( (a) > (b) )? (a) : (b) )

    /**
    * @brief Returns the number of elements in an array @a x.
    * @param[in] x The input array
    * @return The number of elements in @a x.
    */
    #define qFLM_ArraySize( x )             ( sizeof((x))/sizeof((x)[ 0 ]) )

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
