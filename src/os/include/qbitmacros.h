/*This file is part of the QuarkTS distribution.*/
#ifndef QBITMACROS_H
    #define QBITMACROS_H

    #include "qtypes.h"    

    #ifdef __cplusplus
    extern "C" {
    #endif

    #define qBitsSet(Register, Bits)                    (Register) |= (Bits)
    #define qBitsClear(Register, Bits)                  (Register) &= ~(Bits)
    #define qBitSet(Register, Bit)                      (Register) |= (1 << (Bit))
    #define qBitClear(Register, Bit)                    (Register) &= (~(1<< (Bit)))
    #define qBitRead(Register,Bit)                      ((qFalse == ((Register)& (1<<(Bit))))? qFalse : qTrue)
    #define qBitToggle(Register,Bit)                    ((Register)^= (1<<(Bit)))
    #define qBitWrite(Register, Bit, Value)             ((Value) ? qBitSet((Register),(Bit)) : qBitClear((Register),(Bit)))
    #define qBitMakeByte(b7,b6,b5,b4,b3,b2,b1,b0)       (qUINT8_t)( ((b7)<<7) + ((b6)<<6) + ((b5)<<5) + ((b4)<<4) + ((b3)<<3) + ((b2)<<2) + ((b1)<<1) + ((b0)<<0) )
    #define qByteMakeFromBits(b7,b6,b5,b4,b3,b2,b1,b0)  (qBitMakeByte((b7),(b6),(b5),(b4),(b3),(b2),(b1),(b0)))
    #define qByteHighNibble(Register)                   ((qUINT8_t)((Register)>>4))
    #define qByteLowNibble(Register)                    ((qUINT8_t)((Register)&0x0F))
    #define qByteMergeNibbles(H,L)                      ((qUINT8_t)(((H)<<4)|(0x0F&(L))))    
    #define qWordHighByte(Register)                     ((qUINT8_t)((Register)>>8))
    #define qWordLowByte(Register)                      ((qUINT8_t)((Register)&0x00FF))
    #define qWordMergeBytes(H,L)                        ((qUINT16_t)(((H)<<8)|(L)))
    #define qDWordHighWord(Register)                    ((qUINT16_t)((Register) >> 16))
    #define qDWordLowWord(Register)                     ((qUINT16_t)((Register) & 0xFFFF))
    #define qDWordMergeWords(H,L)                       ((qUINT32_t)(((qUINT32_t)(H) << 16 ) | (L) ) )
    #define qClip(X, Max, Min)                          (((X) < (Min)) ? (Min) : (((X) > (Max)) ? (Max) : (X)))
    #define qClipUpper(X, Max)                          (((X) > (Max)) ? (Max) : (X))
    #define qClipLower(X, Min)                          (((X) < (Min)) ? (Min) : (X))
    #define qIsBetween(X, Low, High)                    ((qBool_t)((X) >= (Low) && (X) <= (High)))
    #define qMin(a,b)                                   (((a)<(b))?(a):(b))
    #define qMax(a,b)                                   (((a)>(b))?(a):(b))

    #ifdef __cplusplus
    }
    #endif

#endif