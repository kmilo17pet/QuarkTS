/*This file is part of the QuarkTS distribution.*/
#ifndef QFLM_H
    #define QFLM_H

    #include "qtypes.h"    

    #ifdef __cplusplus
    extern "C" {
    #endif

    /*General purpose Function-like Macros */
    #define qFLM_BitsSet(Register, Bits)                    (Register) |= (Bits)
    #define qFLM_BitsClear(Register, Bits)                  (Register) &= ~(Bits)
    #define qFLM_BitSet(Register, Bit)                      (Register) |= (1 << (Bit))
    #define qFLM_BitClear(Register, Bit)                    (Register) &= (~(1<< (Bit)))
    #define qFLM_BitRead(Register,Bit)                      ((qFalse == ((Register)& (1<<(Bit))))? qFalse : qTrue)
    #define qFLM_BitToggle(Register,Bit)                    ((Register)^= (1<<(Bit)))
    #define qFLM_BitWrite(Register, Bit, Value)             ((Value) ? qFLM_BitSet((Register),(Bit)) : qFLM_BitClear((Register),(Bit)))
    #define qFLM_BitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0)       (qUINT8_t)( ((b7)<<7) + ((b6)<<6) + ((b5)<<5) + ((b4)<<4) + ((b3)<<3) + ((b2)<<2) + ((b1)<<1) + ((b0)<<0) )
    #define qFLM_ByteHighNibble(Register)                   ((qUINT8_t)((Register)>>4))
    #define qFLM_ByteLowNibble(Register)                    ((qUINT8_t)((Register)&0x0F))
    #define qFLM_ByteMergeNibbles(H,L)                      ((qUINT8_t)(((H)<<4)|(0x0F&(L))))    
    #define qFLM_WordHighByte(Register)                     ((qUINT8_t)((Register)>>8))
    #define qFLM_WordLowByte(Register)                      ((qUINT8_t)((Register)&0x00FF))
    #define qFLM_WordMergeBytes(H,L)                        ((qUINT16_t)(((H)<<8)|(L)))
    #define qFLM_DWordHighWord(Register)                    ((qUINT16_t)((Register) >> 16))
    #define qFLM_DWordLowWord(Register)                     ((qUINT16_t)((Register) & 0xFFFF))
    #define qFLM_DWordMergeWords(H,L)                       ((qUINT32_t)(((qUINT32_t)(H) << 16 ) | (L) ) )
    #define qFLM_Clip(X, Max, Min)                          (((X) < (Min)) ? (Min) : (((X) > (Max)) ? (Max) : (X)))
    #define qFLM_ClipUpper(X, Max)                          (((X) > (Max)) ? (Max) : (X))
    #define qFLM_ClipLower(X, Min)                          (((X) < (Min)) ? (Min) : (X))
    #define qFLM_IsBetween(X, Low, High)                    ((qBool_t)((X) >= (Low) && (X) <= (High)))
    #define qFLM_Min(a,b)                                   (((a)<(b))?(a):(b))
    #define qFLM_Max(a,b)                                   (((a)>(b))?(a):(b))

    #ifdef __cplusplus
    }
    #endif

#endif
