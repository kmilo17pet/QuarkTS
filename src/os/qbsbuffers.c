#include "qbsbuffers.h"

#if ( Q_BYTE_SIZED_BUFFERS ==1 )

static qSize_t _qQueueValidPowerOfTwo( qSize_t k );

/*============================================================================*/
static qSize_t _qQueueValidPowerOfTwo( qSize_t k ){
    uint16_t i;
    qSize_t r = k;
    if( ((k-1u) & k) != 0u ){
        k--;
        for( i = 1u; i<sizeof(uint16_t)*8u; i= (uint16_t) (i * 2u)){
            k = k | (qSize_t)( k >> i );
        }
        k = (qSize_t) ((k + 1u) >> 1u);
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
qSize_t qBSBuffer_Count( const qBSBuffer_t * const obj ){
    qSize_t RetValue = 0u;
    if( NULL != obj ){
        RetValue = (qSize_t)( obj->head - obj->tail );
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
uint8_t qBSBuffer_Peek( const qBSBuffer_t * const obj ){
    uint8_t RetValue = 0x0u;
    if( NULL != obj ){
        RetValue = (uint8_t) ( obj->buffer[obj->tail % obj->length] );
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Get(qBSBuffer_t * const obj, uint8_t *dest)
 
Gets one data-byte from the front of the BSBuffer(Byte-sized Buffer), and removes it
 
Parameters:

    - obj : a pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: the location where the data-byte will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Get( qBSBuffer_t * const obj, uint8_t *dest ){
    qBool_t RetValue = qFalse;
    if ( qFalse == qBSBuffer_Empty( obj ) ) {
        *dest = obj->buffer[obj->tail % obj->length];
        obj->tail++;
        RetValue = qTrue;
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const size_t n )
 
Gets n data from the BSBuffer(Byte-sized Buffer) and removes them
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - dest: The location where the data will be written
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const qSize_t n ){
    qSize_t i;
    uint8_t *data = (uint8_t*)dest;
    qBool_t RetValue = qFalse;
    if( n > 0u ){
        RetValue = qTrue;
        for( i = 0u ; i < n ; i++ ){
            RetValue = qBSBuffer_Get( obj, data+i );
        }
    }
    return RetValue;
}
/*============================================================================*/
/*qBool_t qBSBuffer_Put(qBSBuffer_t *obj, uint8_t data){
 
Adds an element of data to the BSBuffer(Byte-sized Buffer)

Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - data: The data to be added
  
Return value:

    qTrue on success, otherwise returns qFalse
*/
qBool_t qBSBuffer_Put( qBSBuffer_t * const obj, const uint8_t data ){
    qBool_t status = qFalse;
    if( NULL != obj ){ 
        if( qFalse == qBSBuffer_IsFull( obj ) ) {/* limit the ring to prevent overwriting */
            obj->buffer[obj->head % obj->length] = data;
            obj->head++;
            status = qTrue;
        }
    }
    return status;
}
/*============================================================================*/
/*void qBSBuffer_Init(qBSBuffer_t *obj, volatile uint8_t *buffer, size_t length){
 
Initialize the BSBuffer(Byte-sized Buffer)
 
Parameters:

    - obj : A pointer to the qBSBuffer(Byte-sized Buffer) object
    - buffer: Block of memory or array of data
    - length: The size of the buffer(Must be a power of two)
  
*/
void qBSBuffer_Init( qBSBuffer_t * const obj, volatile uint8_t *buffer, const qSize_t length ){
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