/*!
 * @file qlists.h
 * @author J. Camilo Gomez C.
 * @version 1.08
 * @note This file is part of the QuarkTS distribution.
 * @brief API to create and manage double-linked generic lists.
 **/
#ifndef  QLISTS_H
    #define QLISTS_H

    #include "qtypes.h"
    #include <string.h>

    #ifdef __cplusplus
    extern "C" {
    #endif

    /** @addtogroup qlists
     * @brief API to create and manage double-linked generic lists.
     *  @{
     */

    /** 
    * @brief A list-node object (Used internally)
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qList_Node_s{
        /*! @cond  */
        struct _qList_Node_s *next, *prev;  /*< Pointers to adjacent nodes. */
        void *container;                    /*< Pointer to the container list*/
        /*! @endcond  */
    }qList_Node_t;

    /**
    * @brief This macro can be used to create custom data that can be used as node of a list.
    *  User should locate this macro as the first member of the custom structure.
    * 
    * Example :
    * @code{.c}
    * typedef struct{
    *       qNode_MinimalFields;
    *       int x;
    *       float y;
    *       char str[10];  
    * }mydata_t;
    * @endcode
    */
   
    #define qNode_MinimalFields     void *next, *prev, *container

    /** 
    * @brief A list object (Generic double-linked)
    * @note Do not access any member of this structure directly. 
    */
    typedef struct _qList_s{
        /*! @cond  */
        qNode_MinimalFields;        /*< To allow "list of lists" aka "nested-lists"*/
        qList_Node_t *head, *tail;  /*< Pointers to the beginning of and the end of the list. */
        size_t size;                /*< Used to hold the current size of the list. */
        /*! @endcond  */
    }qList_t;

    /**
    * @brief This macro can be used to initialize empty lists. 
    */
    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, NULL, 0u }

    /**
    * @brief An enum to describe the ForEach stage.
    */
    typedef enum{ 
        qList_WalkInit,                 /**< When the loop is about to start. In this case, A NULL value will be passed in the node pointer.*/
        qList_WalkThrough,              /**< When the loop is transversing the list.*/
        qList_WalkEnd,                  /**< When the loop has finished. In this case, A NULL value will be passed in the node pointer.*/
     }qList_WalkStage_t;
 
    /**
    * @brief Handle of the qList_ForEach() API that is passed as an argument to 
    * the function that operates on each node. 
    * @note The user must verify the members of this structure to operate 
    * correctly at each stage of the cycle.
    */
    typedef struct _qList_ForEachHandle_s{
        void *node;                     /**< Points to the node that is currently being processed*/   
        void *arg;                      /**< User storage pointer */
        qList_WalkStage_t stage;        /**< Member that indicates the stage of the iterative cycle*/
    }
    #ifdef DOXYGEN
    qList_ForEachHandle_t;
    #else
    _qList_ForEachHandle_t;
    typedef _qList_ForEachHandle_t* qList_ForEachHandle_t;
    #endif

    /**
    * @brief Handle of the qList_Sort() API that is passed as an argument to 
    * the compare function. 
    * @note The user must verify the input nodes to return a boolean value
    * that determines the order in which the nodes should be ordered
    */
    typedef struct _qList_CompareHandle_s{
        const void *n1;                 /**< Points to the node that is currently being processed*/  
        const void *n2;                 /**< Points to the node that is currently being processed*/ 
    }
    #ifdef DOXYGEN
    qList_CompareHandle_t;
    #else
    _qList_CompareHandle_t;
        typedef _qList_CompareHandle_t* qList_CompareHandle_t;
    #endif

    /**
    * @brief Pointer to a function that operates on every node when using
    * the qList_ForEach() API.
    * 
    * Example :
    * @code{.c}
    * qBool_t ForEach_ListExample( qList_ForEachHandle_t h );{
    *       if( qList_WalkThrough == h->stage ){
    *           
    *       }
    *       else if ( qList_WalkInit == h->stage  ) {
    *       
    *       }
    *       else if ( qList_WalkEnd == h->stage  )
    *           
    *       }
    *       else{
    *       
    *       }
    * }
    * @endcode
    * @param[in] h THe for-Each handle.
    * @return none.
    */
    typedef qBool_t (*qList_NodeFcn_t)( qList_ForEachHandle_t h );

    /**
    * @brief Typedef to hold the target position of a node in a list.
    */
    typedef qINT32_t qList_Position_t;

    /**
    * @brief This macro should be used to define the destination position of a node in front of a list
    */
    #define QLIST_ATFRONT           ((qList_Position_t)(-1))

    /**
    * @brief This macro should be used to define the destination position of a node at the end of a list
    */    
    #define QLIST_ATBACK            ((qList_Position_t)(2147483647))


    /**
    * @brief Must be called before a list is used. This initialises all the members of the 
    * list structure.
    * @param[in] list Pointer to the list being initialised.
    * @return none
    */   
    void qList_Initialize( qList_t * const list );

    /**
    * @brief Insert an item into the list.
    * @param[in] list Pointer to the list 
    * @param[in] node A pointer to the node to be inserted
    * @param[in] position The position where the node will be inserted. Could be #QLIST_ATFRONT,
    * #QLIST_ATBACK or any other index number where the node will be inserted after.
    * @return #qTrue if the item was successfully added to the list, othewise returns #qFalse   
    */       
    qBool_t qList_Insert( qList_t * const list, void * const node, const qList_Position_t position );

    /**
    * @brief If the node is member of a list, the node will be removed from it.
    * @param[in] node A pointer to the node.
    * @return #qTrue on Success. #qFalse if removal can't be performed.   
    */   
    qBool_t qList_RemoveItself( void *const node );

    /**
    * @brief Remove an item from the list.
    * @param[in] list Pointer to the list.
    * @param[in] node  A pointer to the node to be deleted (to ignore pass NULL ). 
    * If the node is member or the list, use qList_RemoveItself() to avoid overhead
    * @param[in] position The position of the node that will be removed. Could be
    * #QLIST_ATFRONT, #QLIST_ATBACK or any other index number.
    * @return A pointer to the removed node. NULL if removal can't be performed. 
    */       
    void* qList_Remove( qList_t * const list, void * const node, const qList_Position_t position );

    /**
    * @brief Moves(or merge) the entire list pointed by @a source to the list pointed by 
    * @a destination at location specified by @a position. 
    * After the move operation, this function leaves empty the list pointed 
    * by @a source.
    * @param[in,out] destination Pointer to the list where the @a source nodes are to be moved.
    * @param[in] source  Pointer to the source list to be moved.
    * @param[in] position The position where @a source list will be inserted. Could be 
    * #QLIST_ATFRONT, #QLIST_ATBACK or any other index number  where the list will 
    * be inserted after.
    * @return #qTrue if the move operation is performed successfully, otherwise 
    * returns #qFalse  
    */     
    qBool_t qList_Move( qList_t *const destination, qList_t *const source, const qList_Position_t position );

    /**
    * @brief Check if the node is member of the list.
    * @param[in] list Pointer to the list.
    * @param[in] node  A pointer to the node
    * @return #qTrue if the node belongs to the list, #qFalse if it is not.   
    */      
    qBool_t qList_IsMember( qList_t * const list, void * const node );

    /**
    * @brief Get a pointer to the front item of the list
    * @param[in] list Pointer to the list.
    * @return A pointer to the front node. NULL if the list is empty 
    */      
    void* qList_GetFront( const qList_t * const list );

    /**
    * @brief Get a pointer to the back item of the list
    * @param[in] list Pointer to the list.
    * @return A pointer to the back node. NULL if the list is empty 
    */       
    void* qList_GetBack( const qList_t * const list );

    /**
    * @brief Check if the list is empty.
    * @param[in] list Pointer to the list.
    * @return #qTrue if the list is empty, #qFalse if it is not.  
    */       
    qBool_t qList_IsEmpty( const qList_t * const list );

    /**
    * @brief Get the number of items inside the list.
    * @param[in] list Pointer to the list.
    * @return The number of items of the list.  
    */       
    size_t qList_Length( const qList_t * const list );


    /**
    * @brief Pointer to a function used by the qList_Sort() API to compare 
    * nodes of a list.
    * 
    * Example :
    * @code{.c}
    * qBool_t myNode_CompareFcn( qList_CompareHandle_t h );
    *       mydata_t *n1 = (mydata_t *)h->n1;
    *       mydata_t *n2 = (mydata_t *)h->n2;
    *       return (qBool_t)( n1->x > n2->x );
    * }
    * @endcode
    * @param[in] h The handler object containing the objects being compared.
    * @return  #qTrue value indicates that element pointed by @a node1 goes
    * after the element pointed to by @a node2
    */
    typedef qBool_t (*qList_CompareFcn_t)( qList_CompareHandle_t h );

    /**
    * @brief Sort the double linked list using the @a CompareFcn function to 
    * determine the order. The sorting algorithm used by this function compares 
    * pairs of adjacent nodes by calling the specified @a CompareFcn function 
    * with pointers to them as arguments. The sort is performed only 
    * modifying node's links without data swapping, improving performance if 
    * nodes have a large storage.
    * @note The function modifies the content of the list by reordering its 
    * elements as defined by @a CompareFcn.
    * @param[in] list Pointer to the list.
    * @param[in] CompareFcn Pointer to a function that compares two nodes.
    * This function is called repeatedly by qList_Sort() to compare two nodes. 
    * It shall follow the following prototype:
    * @code qBool_t CompareFcn(void *node1, void *node2) @endcode
    * 
    * Taking two pointers as arguments (both converted to const void*). 
    * The function defines the order of the elements by returning a Boolean data, 
    * where a #qTrue value indicates that element pointed by @a node1 goes
    * after the element pointed to by @a node2.
    * @return #qTrue if at least one reordering is performed over the list.   
    */      
    qBool_t qList_Sort( qList_t * const list, qList_CompareFcn_t CompareFcn ) ;

    /*! @cond  */
    qList_Node_t* _qNode_Backward( const qList_Node_t *const node ); /*This function are not intended for the user usage*/
    qList_Node_t* _qNode_Forward( const qList_Node_t *const node ); /*This function are not intended for the user usage*/
    /*! @endcond  */

    /**
    * @brief Typedef to hold the direction in which the list should be traversed.
    */
    typedef qList_Node_t* (*qList_Direction_t)( const qList_Node_t *const node );      

    /**
    * @brief This macro should be used to define the direction of travel of the list forward
    */
    #define QLIST_FORWARD   ( _qNode_Forward  )  

    /**
    * @brief This macro should be used to define the direction of travel of the list backwards
    */   
    #define QLIST_BACKWARD  ( _qNode_Backward )
    
    /**
    * @brief Typedef to hold a list-iterator instance.
    */
    typedef struct _qList_Iterator_s{
        /*! @cond  */
        qList_Node_t *next;             /*< Where the iterator is currently pointing. */
        qList_Direction_t direction;    /*< How the iterator scrolls through the list, #QLIST_FORWARD or #QLIST_BACKWARD. */
        /*! @endcond  */
    }qList_Iterator_t;

    /**
    * @brief Setup an instance of the given iterator to traverse the list.
    * @param[in] iterator Pointer to the iterator instance
    * @param[in] list Pointer to the list.
    * @param[in] NodeOffset The start offset-node. To ignore, pass NULL.
    * @dir Use one of the following options: #QLIST_FORWARD or #QLIST_BACKWARD.
    * @return #qTrue on success. Otherwise returns #qFalse.  
    */       
    qBool_t qList_IteratorSet( qList_Iterator_t *iterator, qList_t *const list, void *NodeOffset, qList_Direction_t dir );
    
    /**
    * @brief Get the current node available in the iterator. After invoked, 
    * iterator will be updated to the next node.
    * @param[in] iterator Pointer to the iterator instance
    * @return Return the next node or NULL when no more nodes remain in the list.
    */     
    void* qList_IteratorGetNext( qList_Iterator_t *iterator );

    /**
    * @brief Operate on each element of the list.
    * @param[in] list Pointer to the list.
    * @param[in] Fcn The function to perform over the node. Should have this prototype:
    * @code qBool_t Function( qList_ForEachHandle_t h ) @endcode
    * 
    * If @a Function returns #qTrue, the walk-through loop will be terminated.
    * @param[in] arg Argument passed to @a Fcn
    * @param[in] dir Use one of the following options: #QLIST_FORWARD or #QLIST_BACKWARD.
    * @param NodeOffset If available, the list walk through will start from this node.  
    * To ignore, pass NULL. 
    * @return #qTrue if the walk through was early terminated, otherwise returns #qFalse.
    */     
    qBool_t qList_ForEach( qList_t *const list, const qList_NodeFcn_t Fcn, void *arg, qList_Direction_t dir, void *NodeOffset );
    
    /**
    * @brief Swap two nodes that belongs to the same list by changing its own links.
    * @note The list containing nodes will be updated if any node is part of the boundaries.
    * @param[in] node1 Pointer to the first node.
    * @param[in] node2 Pointer to the second node.
    * @return #qTrue if the swap operation is performed. Otherwise returns #qFalse.
    */      
    qBool_t qList_Swap( void *node1, void *node2 );


    #ifdef QLIST_D_HANDLING  /*use only if strictly necessary*/
        typedef void* (*qList_MemAllocator_t)( size_t size );
        typedef void (*qList_MemFree_t)( void *ptr );
        void qList_SetMemoryAllocation( qList_MemAllocator_t mallocFcn, qList_MemFree_t freeFcn );
        qBool_t qList_DInsert( qList_t *const list, void *Data, size_t Size, qList_Position_t position );
        void* qList_DRemove( qList_t * const list, void * const node, const qList_Position_t position );
        qBool_t qList_DRemoveItself( void * const node );
    #endif


    /** @}*/
    #ifdef __cplusplus
    }
    #endif

#endif 
