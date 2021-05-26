/*!
 * @file qflm.h
 * @author J. Camilo Gomez C.
 * @version 1.41
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
    * @brief Uses the bitwise OR operator to set bits into <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bits Indicates which bits are to be set
    * @return none.
    */       
    #define qFLM_BitsSet(Register, Bits)                    (Register) |= (Bits)

    /**
    * @brief Uses the bitwise AND operator to clear  bits into <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bits Indicates which bits are to be cleared
    * @return none.
    */        
    #define qFLM_BitsClear(Register, Bits)                  (Register) &= ~(Bits)

    /**
    * @brief Uses the bitwise OR operator to set a single bit into <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bit The bit-index 
    * @return none.
    */        
    #define qFLM_BitSet(Register, Bit)                      (Register) |= (1 << (Bit))

    /**
    * @brief Uses the bitwise AND operator to clear a single bit into <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bit The bit-index 
    * @return none.
    */     
    #define qFLM_BitClear(Register, Bit)                    (Register) &= (~(1<< (Bit)))

    /**
    * @brief Uses the bitwise AND operator to read the value of a single bit from <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bit The bit-index 
    * @return The value of the requested bit.
    */     
    #define qFLM_BitRead(Register,Bit)                      ((qFalse == ((Register)& (1<<(Bit))))? qFalse : qTrue)

    /**
    * @brief Uses the bitwise XOR operator to toggle the value of a single bit from <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bit The bit-index 
    * @return none.
    */    
    #define qFLM_BitToggle(Register,Bit)                    ((Register)^= (1<<(Bit)))

    /**
    * @brief Write the <b>Value</b> in a single bit of the <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @param Bit The bit-index 
    * @param Value The boolean value to write 
    * @return none.
    */       
    #define qFLM_BitWrite(Register, Bit, Value)             ((Value) ? qFLM_BitSet((Register),(Bit)) : qFLM_BitClear((Register),(Bit)))

    /**
    * @brief Build a byte value from independent bits 
    * @param b7...b0 
    * @return The value of the byte formed
    */   
    #define qFLM_BitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0)       (qUINT8_t)( ((b7)<<7) + ((b6)<<6) + ((b5)<<5) + ((b4)<<4) + ((b3)<<3) + ((b2)<<2) + ((b1)<<1) + ((b0)<<0) )

    /**
    * @brief Read the high-nibble from <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @return The value of the high nibble
    */       
    #define qFLM_ByteHighNibble(Register)                   ((qUINT8_t)((Register)>>4))

    /**
    * @brief Read the low-nibble from <b>Register</b> 
    * @param Register The variable where the operation will be applied
    * @return The value of the low nibble
    */     
    #define qFLM_ByteLowNibble(Register)                    ((qUINT8_t)((Register)&0x0F))

    /**
    * @brief Merges two nibbles to form one byte.
    * @param H The high nibble
    * @param L The low nibble
    * @return The value of the resulting byte
    */        
    #define qFLM_ByteMergeNibbles(H,L)                      ((qUINT8_t)(((H)<<4)|(0x0F&(L))))    

    /**
    * @brief Read the high-byte from <b>Register</b> assuming it as a Word
    * @param Register The variable where the operation will be applied
    * @return The value of the high byte
    */    
    #define qFLM_WordHighByte(Register)                     ((qUINT8_t)((Register)>>8))

    /**
    * @brief Read the low-byte from <b>Register</b> assuming it as a Word
    * @param Register The variable where the operation will be applied
    * @return The value of the low byte
    */     
    #define qFLM_WordLowByte(Register)                      ((qUINT8_t)((Register)&0x00FF))

    /**
    * @brief Merges two bytes to form one Word.
    * @param H The high byte
    * @param L The low byte
    * @return The value of the resulting word
    */      
    #define qFLM_WordMergeBytes(H,L)                        ((qUINT16_t)(((H)<<8)|(L)))

    /**
    * @brief Read the high-word from <b>Register</b> assuming it as a DWord
    * @param Register The variable where the operation will be applied
    * @return The value of the high word
    */       
    #define qFLM_DWordHighWord(Register)                    ((qUINT16_t)((Register) >> 16))

    /**
    * @brief Read the low-word from <b>Register</b> assuming it as a DWord
    * @param Register The variable where the operation will be applied
    * @return The value of the low word
    */       
    #define qFLM_DWordLowWord(Register)                     ((qUINT16_t)((Register) & 0xFFFF))

    /**
    * @brief Merges two words to form one DWord.
    * @param H The high word
    * @param L The low word
    * @return The value of the resulting DWord
    */      
    #define qFLM_DWordMergeWords(H,L)                       ((qUINT32_t)(((qUINT32_t)(H) << 16 ) | (L) ) )

    /**
    * @brief Ensures that <b>X</b> is between the limits set by <b>Min</b> and <b>Max</b>. 
    * @note If <b>Min</b> is greater than <b>Max</b> the result is undefined.
    * @param X The value to clamp
    * @param Min The minimum value allowed.
    * @param Max The maximum value allowed.
    * @return The value of <b>X</b> clamped to the range between <b>Min</b> and <b>Max</b>.
    */     
    #define qFLM_Clip(X, Min, Max)                          (((X) < (Min)) ? (Min) : (((X) > (Max)) ? (Max) : (X)))

    /**
    * @brief Ensures that <b>X</b> is bellow the limits set by <b>Max</b>. 
    * @param X The value to clamp
    * @param Max The maximum value allowed.
    * @return The value of <b>X</b> clamped to the value of <b>Max</b>.
    */     
    #define qFLM_ClipUpper(X, Max)                          (((X) > (Max)) ? (Max) : (X))

    /**
    * @brief Ensures that <b>X</b> is above the value set by <b>Min</b>. 
    * @param X The value to clamp
    * @param Min The minimum value allowed.
    * @return The value of <b>X</b> clamped to the value of <b>Min</b>.
    */         
    #define qFLM_ClipLower(X, Min)                          (((X) < (Min)) ? (Min) : (X))

    /**
    * @brief Check if the value of <b>X</b> is within the limits defined by <b>Low</b> and <b>High</b>. 
    * @param X The value to check
    * @param Low The minimum value allowed.
    * @param High The maximum value allowed.
    * @return True if the <b>X</b> is between the defined range. Otherwise returns false.
    */      
    #define qFLM_IsBetween(X, Low, High)                    ((qBool_t)((X) >= (Low) && (X) <= (High)))

    /**
    * @brief Calculates the minimum of <b>a</b> and <b>b</b>.
    * @param a A numeric value
    * @param b A numeric value
    * @return The minimum of <b>a</b> and <b>b</b>.
    */        
    #define qFLM_Min(a,b)                                   (((a)<(b))?(a):(b))

    /**
    * @brief Calculates the maximum  of <b>a</b> and <b>b</b>.
    * @param a A numeric value
    * @param b A numeric value
    * @return The maximum  of <b>a</b> and <b>b</b>.
    */      
    #define qFLM_Max(a,b)                                   (((a)>(b))?(a):(b))

    /**
    * @brief Returns the number of elements in an array <b>x</b>.
    * @param x The input array
    * @return The number of elements in <b>x</b>.
    */        
    #define qFLM_ArraySize(x)                               (sizeof(x) / sizeof((x)[0]))

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif
