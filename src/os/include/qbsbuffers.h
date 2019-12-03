/*This file is part of the QuarkTS distribution.*/
#ifndef QBSBUFFERS_H
    #define QBSBUFFERS_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    typedef struct{
        volatile qUINT8_t *buffer;  /*< Points to the begining of the buffer storage area. */
        volatile qIndex_t head;     /*< Used to hold the index of the head. */
        volatile qIndex_t tail;     /*< Used to hold the index of the tail. */
        size_t length;              /*< The length of the buffer(a valid power of two). */ 
    }qBSBuffer_t;

    size_t qBSBuffer_Count( const qBSBuffer_t * const obj );
    qBool_t qBSBuffer_IsFull( const qBSBuffer_t * const obj );
    qBool_t qBSBuffer_Empty( const qBSBuffer_t * const obj );
    qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const obj );

    qBool_t qBSBuffer_Get( qBSBuffer_t * const obj, qUINT8_t *dest );
    qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const size_t n );
    qBool_t qBSBuffer_Put( qBSBuffer_t * const obj, const qUINT8_t data );
    void qBSBuffer_Init( qBSBuffer_t * const obj, volatile qUINT8_t *buffer, const size_t length );

    #ifdef __cplusplus
    }
    #endif

#endif