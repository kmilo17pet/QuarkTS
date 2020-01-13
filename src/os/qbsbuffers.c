#include "qbsbuffers.h"

#if ( Q_BYTE_SIZED_BUFFERS ==1 )

static size_t _qQueueValidPowerOfTwo( size_t k );

/*============================================================================*/
static size_t _qQueueValidPowerOfTwo( size_t k ){
    qIndex_t i;
    size_t r = k;
    if( ((k-1u) & k) != 0u ){
        k--;
        for( i = 1u; i<sizeof(qIndex_t)*8u; i= (qIndex_t) (i * 2u)){
            k = k | (size_t)( k >> i );
        }
        k = (size_t) ((k + 1u) >> 1u);
    }
    return ( k < r )? k*2u : k;
}
/*============================================================================*/
/*size_t qBSBuffer_Count(const qBSBuffer_t * const obj)
 
Query the number of elements in the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    Number of elements in the BSBuffer(Byte-sized Buffer)
*/
size_t qBSBuffer_Count( const qBSBuffer_t * const obj ){
    size_t RetValue = 0u;
    qIndex_t head, tail;
    if( NULL != obj ){
        head = obj->head;
        tail = obj->tail;
        RetValue = (size_t)( head - tail );
    }

    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_IsFull(const qBSBuffer_t * const obj)
 
Query the the full status of the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    qTrue if the BSBuffer(Byte-sized Buffer) is full, qFalse if it is not.
*/
qBool_t qBSBuffer_IsFull( const qBSBuffer_t * const obj ){
    qBool_t RetValue = qFalse;
    if( NULL != obj ){
        RetValue = ( obj->length == qBSBuffer_Count( obj ) )? qTrue : qFalse;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Empty(const qBSBuffer_t * const obj)
 
Query the the empty status of the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    qTrue if the BSBuffer(Byte-sized Buffer) is empty, qFalse if it is not.
*/
qBool_t qBSBuffer_Empty( const qBSBuffer_t * const obj ){
    qBool_t RetValue = qTrue;
    if( NULL != obj ){
        RetValue = ( 0u == qBSBuffer_Count( obj ) )? qTrue : qFalse;
    }
    return RetValue;
}
/*============================================================================*/
/*uint8_t qBSBuffer_Peek(const qBSBuffer_t * const obj)
 
Looks for one byte from the head of the BSBuffer(Byte-sized Buffer) without removing it
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
  
Return value:

    byte of data, or zero if nothing in the list
*/
qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const obj ){
    qUINT8_t RetValue = 0x0u;
    qIndex_t index;
    if( NULL != obj ){
        index = obj->tail % obj->length;
        RetValue = (qUINT8_t) ( obj->buffer[ index ] ); /*MISRAC2004-17.4_b deviation allowed*/
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Get(qBSBuffer_t * const obj, qUINT8_t *dest)
 
Gets one data-byte from the front of the BSBuffer(Byte-sized Buffer), and removes it
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: the location where the data-byte will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Get( qBSBuffer_t * const obj, qUINT8_t *dest ){
    qBool_t RetValue = qFalse;
    qIndex_t index;
    if ( qFalse == qBSBuffer_Empty( obj ) ) {
        index = obj->tail % obj->length;
        *dest = obj->buffer[ index ]; /*MISRAC2004-17.4_b deviation allowed*/
        obj->tail++;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const qSize_t n )
 
Gets n data from the BSBuffer(Byte-sized Buffer) and removes them
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: The location where the data will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const size_t n ){
    size_t i;
    qUINT8_t *data = (qUINT8_t*)dest; /*MISRAC2012-Rule-11.5 deviation allowed*/
    qBool_t RetValue = qFalse;
    if( n > 0u ){
        RetValue = qTrue;
        for( i = 0u ; i < n ; i++ ){
            RetValue = qBSBuffer_Get( obj, &data[i] ); /*MISRAC2004-17.4_a deviation allowed*/
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Put(qBSBuffer_t * const obj, const qUINT8_t data){
 
Adds an element of data to the BSBuffer(Byte-sized Buffer)

Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - data: The data to be added
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Put( qBSBuffer_t * const obj, const qUINT8_t data ){
    qBool_t status = qFalse;
    if( NULL != obj ){ 
        if( qFalse == qBSBuffer_IsFull( obj ) ) {/* limit the ring to prevent overwriting */
            obj->buffer[obj->head % obj->length] = data; /*MISRAC2004-17.4_b deviation allowed*/
            obj->head++;
            status = qTrue;
        }
    }
    return status;
}
/*============================================================================*/
/*void qBSBuffer_Init(qBSBuffer_t *const obj, volatile uint8_t *buffer, const qSize_t length){
 
Initialize the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - buffer: Block of memory or array of data
    - length: The size of the buffer(Must be a power of two)
  
*/
void qBSBuffer_Init( qBSBuffer_t * const obj, volatile qUINT8_t *buffer, const size_t length ){
    if( NULL != obj ){
        obj->head = 0u;
        obj->tail = 0u;
        obj->buffer = buffer;
        #if ( Q_QUEUES == 1 )
            obj->length = _qQueueValidPowerOfTwo( length );
        #else
            obj->length = length;
        #endif      
    }
}
/*============================================================================*/

#endif /* #if ( Q_BYTE_SIZED_BUFFERS ==1 ) */