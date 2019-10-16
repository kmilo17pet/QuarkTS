/*This file is part of the QuarkTS distribution.*/
#ifndef QBSBUFFERS_H
    #define QBSBUFFERS_H

    #include "qtypes.h"

    typedef struct{
        volatile qUIndex_t head;    /*< Used to hold the index of the head. */
        volatile qUIndex_t tail;    /*< Used to hold the index of the tail. */
        qSize_t length;             /*< The length of the buffer(a valid power of two). */ 
        volatile qUINT8_t *buffer;   /*< Points to the begining of the buffer storage area. */
    }qBSBuffer_t;

    qSize_t qBSBuffer_Count( const qBSBuffer_t * const obj );
    qBool_t qBSBuffer_IsFull( const qBSBuffer_t * const obj );
    qBool_t qBSBuffer_Empty( const qBSBuffer_t * const obj );
    qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const obj );

    qBool_t qBSBuffer_Get( qBSBuffer_t * const obj, qUINT8_t *dest );
    qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const qSize_t n );
    qBool_t qBSBuffer_Put( qBSBuffer_t * const obj, const qUINT8_t data );
    void qBSBuffer_Init( qBSBuffer_t * const obj, volatile qUINT8_t *buffer, const qSize_t length );

#endif