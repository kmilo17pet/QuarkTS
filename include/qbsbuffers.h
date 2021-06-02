/*!
 * @file qbsbuffers.h
 * @author J. Camilo Gomez C.
 * @version 1.23
 * @note This file is part of the QuarkTS distribution.
 * @brief An interrupt-safe byte-sized ring buffer interface.
 **/
#ifndef QBSBUFFERS_H
    #define QBSBUFFERS_H

    #include "qtypes.h"

    #ifdef __cplusplus
    extern "C" {
    #endif

    #ifndef Q_BYTE_SIZED_BUFFERS
        #define Q_BYTE_SIZED_BUFFERS    ( 1 )
    #endif

    /** @addtogroup qbsbuffers Byte-Sized Buffers
     * @brief An interrupt-safe byte-sized ring buffer interface.
     *  @{
     */

    /** 
    * @brief A BSBuffer(Byte-sized buffer) object
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qBSBuffer_s{
        /*! @cond  */
        struct _qBSBuffer_Private_s{
            volatile qUINT8_t *buffer;  /*< Points to the begining of the buffer storage area. */
            volatile qIndex_t head;     /*< Used to hold the index of the head. */
            volatile qIndex_t tail;     /*< Used to hold the index of the tail. */
            size_t length;              /*< The length of the buffer(a valid power of two). */ 
        }qPrivate;
        /*! @endcond  */
    }qBSBuffer_t;

    /**
    * @brief Query the number of elements in the BSBuffer(Byte-sized Buffer)
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @return Number of elements in the BSBuffer(Byte-sized Buffer)
    */ 
    size_t qBSBuffer_Count( const qBSBuffer_t * const obj );

    /**
    * @brief Query the the full status of the BSBuffer(Byte-sized Buffer)
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @return #qTrue if the BSBuffer(Byte-sized Buffer) is full, #qFalse if it is not.
    */    
    qBool_t qBSBuffer_IsFull( const qBSBuffer_t * const obj );

    /**
    * @brief Query the the empty status of the BSBuffer(Byte-sized Buffer)
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @return #qTrue if the BSBuffer(Byte-sized Buffer) is empty, #qFalse if it is not.
    */      
    qBool_t qBSBuffer_Empty( const qBSBuffer_t * const obj );

    /**
    * @brief Looks for one byte from the head of the BSBuffer(Byte-sized Buffer) without removing it
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @return byte of data, or zero if nothing in the list
    */         
    qUINT8_t qBSBuffer_Peek( const qBSBuffer_t * const obj );

    /**
    * @brief Gets one data-byte from the front of the BSBuffer(Byte-sized Buffer), and removes it
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @param[out] dest the location where the data-byte will be written
    * @return #qTrue on success, otherwise returns #qFalse
    */ 
    qBool_t qBSBuffer_Get( qBSBuffer_t * const obj, qUINT8_t *dest );

    /**
    * @brief Gets n data from the BSBuffer(Byte-sized Buffer) and removes them
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @param[out] dest the location where the data-byte will be written
    * @param[in] n The number of bytes to read
    * @return #qTrue on success, otherwise returns #qFalse
    */     
    qBool_t qBSBuffer_Read( qBSBuffer_t * const obj, void *dest, const size_t n );

    /**
    * @brief Adds an element of data to the BSBuffer(Byte-sized Buffer)
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @param[in] Data The data to be added
    * @return #qTrue on success, otherwise returns #qFalse
    */     
    qBool_t qBSBuffer_Put( qBSBuffer_t * const obj, const qUINT8_t Data );

    /**
    * @brief Initialize the BSBuffer(Byte-sized Buffer)
    * @param[in] obj a pointer to the qBSBuffer(Byte-sized Buffer) object
    * @param[in] buffer Block of memory or array of data
    * @param[in] length The size of the buffer(Must be a power of two)
    * @return none.
    */     
    void qBSBuffer_Setup( qBSBuffer_t * const obj, volatile qUINT8_t *buffer, const size_t length );

    /** @}*/

    #ifdef __cplusplus
    }
    #endif

#endif