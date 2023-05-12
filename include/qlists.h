/*!
 * @file qlists.h
 * @author J. Camilo Gomez C.
 * @version 1.14
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

    /** 
    * @addtogroup qlists
    * @brief The provided list implementation uses a generic doubly-linked 
    * approach in which each node, apart from storing its data, has two link 
    * pointers. The first link points to the previous node in the list and the 
    * second link, points to the next node in the list. The first node of the 
    * list has its previous link pointing to @c NULL, similarly, the last node
    * of the list has its next node pointing to @c NULL.
    * 
    * The list data-structure, referenced through an object of type qList_t 
    * also has a head and a tail pointer, to allow fast operations on boundary 
    * nodes.
    *
    * Nodes should be an user-defined data structure of any number of members, 
    * however, they must be specially defined to be compatible with the 
    * provided APIs. All the user-defined nodes must have the 
    * #qNode_MinimalFields definition on top of the structure. An example is 
    * shown below:
    * 
    * @code{.c}
    * typedef struct {
    *     qNode_MinimalFields;
    *     int a;
    *     int b;
    *     float y;
    * } userdata_t;
    * @endcode
    *
    * With this special type definition on all custom data, the application 
    * writer can take advantage of this versatile data structure.
    *  @{
    */

    /**
    * @brief A list-node object (Used internally)
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qList_Node_s {
        /*! @cond  */
        struct _qList_Node_s *next, *prev;  /*< Pointers to adjacent nodes. */
        void *container;                    /*< Pointer to the container list*/
        /*! @endcond  */
    }
    qList_Node_t;

    /**
    * @brief This macro can be used to create custom data that can be used as
    * node of a list.
    * User should locate this macro as the first member of the custom structure.
    *
    * Example :
    * @code{.c}
    * typedef struct {
    *       qNode_MinimalFields;
    *       int x;
    *       float y;
    *       char str[ 10 ];
    * } mydata_t;
    * @endcode
    */

    #define qNode_MinimalFields     void *next, *prev, *container

    /**
    * @brief A list object (Generic double-linked)
    * @note Do not access any member of this structure directly.
    */
    typedef struct _qList_s {
        /*! @cond  */
        qNode_MinimalFields;        /*< To allow "list of lists" aka "nested-lists"*/
        qList_Node_t *head, *tail;  /*< Pointers to the beginning of and the end of the list. */
        size_t size;                /*< Used to hold the current size of the list. */
        /*! @endcond  */
    }
    qList_t;

    /**
    * @brief This macro can be used to initialize empty lists.
    */
    #define QLIST_INITIALIZER   { NULL, NULL, NULL, NULL, NULL, 0u }

    /**
    * @brief An enum to describe the ForEach stage.
    */
    typedef enum {
        qList_WalkInit,                 /**< When the loop is about to start. In this case, A @c NULL value will be passed in the node pointer.*/
        qList_WalkThrough,              /**< When the loop is traversing the list.*/
        qList_WalkEnd,                  /**< When the loop has finished. In this case, A @c NULL value will be passed in the node pointer.*/
    }
    qList_WalkStage_t;

    /**
    * @brief Handle of the qList_ForEach() API that is passed as an argument to
    * the function that operates on each node.
    * @note The user must verify the members of this structure to operate
    * correctly at each stage of the cycle.
    */
    typedef struct _qList_ForEachHandle_s {
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
    typedef struct _qList_CompareHandle_s {
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
    * qBool_t ForEach_ListExample( qList_ForEachHandle_t h ) {
    *       if ( qList_WalkThrough == h->stage ) {
    *
    *       }
    *       else if ( qList_WalkInit == h->stage ) {
    *
    *       }
    *       else if ( qList_WalkEnd == h->stage ) {
    *
    *       }
    *       else {
    *
    *       }
    * }
    * @endcode
    * @param[in] h A handle to the list iterator.
    * @return A boolean value that can be used to continue or break the walk
    * through loop over the list. If a #qTrue value its returned the break will
    * be performed
    */
    typedef qBool_t (*qList_NodeFcn_t)( qList_ForEachHandle_t h );

    /**
    * @brief Typedef to hold the target position of a node in a list.
    */
    typedef qINT32_t qList_Position_t;

    /**
    * @brief This macro should be used to define the destination position of a
    * node in front of a list
    */
    #define QLIST_AT_FRONT          ( (qList_Position_t)( -1 ) )

    /**
    * @brief This macro should be used to define the destination position of a
    * node at the end of a list
    */
    #define QLIST_AT_BACK           ( (qList_Position_t)( 2147483647 ) )


    /**
    * @brief Must be called before a list is used. This initialises all the
    * members of the
    * list structure.
    * @param[in] l Pointer to the list being initialised.
    * @return #qTrue on success, #qFalse otherwise.
    */
    qBool_t qList_Initialize( qList_t * const l );

    /**
    * @brief Insert an item into the list.
    * @param[in] l Pointer to the list
    * @param[in] node A pointer to the node to be inserted
    * @param[in] p The position where the node will be inserted. Could be
    * #QLIST_ATFRONT, #QLIST_ATBACK or any other index number where the node
    * will be inserted after.
    * @return #qTrue if the item was successfully added to the list, otherwise
    * returns #qFalse
    */
    qBool_t qList_Insert( qList_t * const l,
                          void * const node,
                          const qList_Position_t p );

    /**
    * @brief If the node is member of a list, the node will be removed from it.
    * @param[in] node A pointer to the node.
    * @return #qTrue on Success. #qFalse if removal can't be performed.
    */
    qBool_t qList_RemoveItself( void *const node );

    /**
    * @brief Remove an item from the list.
    * @param[in] l Pointer to the list.
    * @param[in] node A pointer to the node to be deleted (to ignore pass @c NULL ).
    * If the node is member or the list, use qList_RemoveItself() to avoid
    * overhead
    * @param[in] p The position of the node that will be removed. Could be
    * #QLIST_ATFRONT, #QLIST_ATBACK or any other index number.
    * @return A pointer to the removed node. @c NULL if removal can't be performed.
    */
    void* qList_Remove( qList_t * const l,
                        void * const node,
                        const qList_Position_t p );

    /**
    * @brief Moves(or merge) the entire list pointed by @a src to the list
    * pointed by
    * @a dst at location specified by @a p.
    * After the move operation, this function leaves empty the list pointed by
    * @a src.
    * @param[in,out] dst Pointer to the list where the @a src nodes are to be
    * moved.
    * @param[in] src  Pointer to the source list to be moved.
    * @param[in] p The position where @a src list will be inserted. Could be
    * #QLIST_ATFRONT, #QLIST_ATBACK or any other index number  where the list
    * will be inserted after.
    * @return #qTrue if the move operation is performed successfully, otherwise
    * returns #qFalse
    */
    qBool_t qList_Move( qList_t *const dst,
                        qList_t *const src,
                        const qList_Position_t p );

    /**
    * @brief Check if the node is member of the list.
    * @param[in] l Pointer to the list.
    * @param[in] node  A pointer to the node
    * @return #qTrue if the node belongs to the list, #qFalse if it is not.
    */
    qBool_t qList_IsMember( const qList_t * const l,
                            const void * const node );

    /**
    * @brief Get a pointer to the front item of the list
    * @param[in] l Pointer to the list.
    * @return A pointer to the front node. @c NULL if the list is empty
    */
    void* qList_GetFront( const qList_t * const l );

    /**
    * @brief Get a pointer to the back item of the list
    * @param[in] l Pointer to the list.
    * @return A pointer to the back node. @c NULL if the list is empty
    */
    void* qList_GetBack( const qList_t * const l );

    /**
    * @brief Check if the list is empty.
    * @param[in] l Pointer to the list.
    * @return #qTrue if the list is empty, #qFalse if it is not.
    */
    qBool_t qList_IsEmpty( const qList_t * const l );

    /**
    * @brief Get the number of items inside the list.
    * @param[in] l Pointer to the list.
    * @return The number of items of the list.
    */
    size_t qList_Length( const qList_t * const l );


    /**
    * @brief Pointer to a function used by the qList_Sort() API to compare
    * nodes of a list.
    *
    * Example :
    * @code{.c}
    * qBool_t myNode_CompareFcn( qList_CompareHandle_t h ) {
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
    * @brief Sort the double linked list using the @a f function to
    * determine the order. The sorting algorithm used by this function compares
    * pairs of adjacent nodes by calling the specified @a f function
    * with pointers to them as arguments. The sort is performed only
    * modifying node's links without data swapping, improving performance if
    * nodes have a large storage.
    * @note The function modifies the content of the list by reordering its
    * elements as defined by @a f.
    * @param[in] l Pointer to the list.
    * @param[in] f Pointer to a function that compares two nodes.
    * This function is called repeatedly by qList_Sort() to compare two nodes.
    * It shall follow the following prototype:
    * @code qBool_t CompareFcn( qList_CompareHandle_t h ) @endcode
    *
    * The function defines the order of the elements by returning a Boolean data,
    * where a #qTrue value indicates that element pointed by @a node1 goes
    * after the element pointed to by @a node2.
    * @return #qTrue if at least one reordering is performed over the list.
    */
    qBool_t qList_Sort( qList_t * const l,
                        qList_CompareFcn_t f ) ;

    /*! @cond  */
    qList_Node_t* _qNode_Backward( const qList_Node_t *const n ); /*This function are not intended for the user usage*/
    qList_Node_t* _qNode_Forward( const qList_Node_t *const n ); /*This function are not intended for the user usage*/
    /*! @endcond  */

    /**
    * @brief Typedef to hold the direction in which the list should be traversed.
    */
    typedef qList_Node_t* (*qList_Direction_t)( const qList_Node_t *const node );

    /**
    * @brief This macro should be used to define the direction of travel of the
    * list forward
    */
    #define QLIST_FORWARD   ( _qNode_Forward )

    /**
    * @brief This macro should be used to define the direction of travel of the
    * list backwards
    */
    #define QLIST_BACKWARD  ( _qNode_Backward )

    /**
    * @brief Typedef to hold a list-iterator instance.
    */
    typedef struct _qList_Iterator_s {
        /*! @cond  */
        qList_t *l;
        qList_Node_t *iter;
        void *current;
        /*! @endcond  */
    }
    qList_Iterator_t;


    /**
    * @brief Setup an instance of the given iterator to traverse the list.
    * @param[in] i Pointer to the iterator instance
    * @param[in] l Pointer to the list.
    * @param[in] nodeOffset The start offset-node. To ignore, pass @c  NULL.
    * @param[in] d Use one of the following options: #QLIST_FORWARD or
    * #QLIST_BACKWARD.
    * @return #qTrue on success. Otherwise returns #qFalse.
    */
    qBool_t qList_IteratorSet( qList_Iterator_t *i,
                               qList_t *const l,
                               void *nodeOffset,
                               qList_Direction_t d );

    /**
    * @brief Operate on each element of the list.
    * @param[in] l Pointer to the list.
    * @param[in] f The function to perform over the node. Should have this
    * prototype:
    * @code qBool_t Function( qList_ForEachHandle_t h ) @endcode
    *
    * If @a f returns #qTrue, the walk-through loop will be terminated.
    * @param[in] arg Argument passed to @a f
    * @param[in] d Direction. Use one of the following options: #QLIST_FORWARD
    * or #QLIST_BACKWARD.
    * @param nodeOffset If available, the list walk through will start from this
    * node. To ignore, pass @c NULL.
    * @return #qTrue if the walk through was early terminated, otherwise returns
    * #qFalse.
    */
    qBool_t qList_ForEach( qList_t *const l,
                           const qList_NodeFcn_t f,
                           void *arg,
                           qList_Direction_t d,
                           void *nodeOffset );

    /**
    * @brief Swap two nodes that belongs to the same list by changing its own
    * links.
    * @note The list containing nodes will be updated if any node is part of the
    * boundaries.
    * @param[in] node1 Pointer to the first node.
    * @param[in] node2 Pointer to the second node.
    * @return #qTrue if the swap operation is performed. Otherwise returns
    * #qFalse.
    */
    qBool_t qList_Swap( void *node1,
                        void *node2 );

    /**
    * @brief Returns an iterator pointing to the first element in the 
    * list container.
    * @param[in] xList Pointer to the list.
    * @return An iterator to the beginning of the sequence container.
    */
    qList_Iterator_t qList_Begin( qList_t *const xList );

    /**
    * @brief Returns an iterator pointing to the last element in the 
    * list container.
    * @param[in] xList Pointer to the list.
    * @return An iterator to the latest item of the sequence container.
    */
    qList_Iterator_t qList_End( qList_t *const xList );

    /**
    * @brief Check until current iterator reach the given node
    * @param[in] i Pointer to the iterator instance
    * @param[in] node A pointer to the node you want to reach. To ignore pass
    * @c NULL as argument.
    * @return  #qTrue if the iterator has reach the given node.
    */
    qBool_t qListIterator_Until( qList_Iterator_t *i,
                                 void *node );

    /**
    * @brief Move the iterator forward
    * @param[in] i Pointer to the iterator instance
    */
    void qListIterator_Forward( qList_Iterator_t *i );

    /**
    * @brief Move the iterator backward
    * @param[in] i Pointer to the iterator instance
    */
    void qListIterator_Backward( qList_Iterator_t *i );

    /**
    * @brief Gets the node that the iterator is currently pointing to.
    * @return A pointer to the node currently being pointed.
    */
    void* qListIterator_Get( qList_Iterator_t *i );

    /** @}*/
    #ifdef __cplusplus
    }
    #endif

#endif
