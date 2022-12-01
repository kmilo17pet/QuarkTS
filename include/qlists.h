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
    * <center>
    * @htmlonly
    * <!DOCTYPE html>
    * <html>
    * <head>
    * <title>qlist</title>
    * <meta charset="utf-8"/>
    * </head>
    * <body><div class="mxgraph" style="max-width:100%;border:1px solid transparent;" data-mxgraph="{&quot;highlight&quot;:&quot;#0000ff&quot;,&quot;nav&quot;:true,&quot;zoom&quot;:1.2,&quot;resize&quot;:true,&quot;toolbar&quot;:&quot;zoom layers tags lightbox&quot;,&quot;edit&quot;:&quot;_blank&quot;,&quot;xml&quot;:&quot;&lt;mxfile host=\&quot;app.diagrams.net\&quot; modified=\&quot;2022-10-19T20:37:00.387Z\&quot; agent=\&quot;5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/106.0.0.0 Safari/537.36\&quot; etag=\&quot;KSbS3wh_9uupMrEyc6ED\&quot; version=\&quot;20.4.1\&quot; type=\&quot;google\&quot;&gt;&lt;diagram id=\&quot;mmlpRbxcPcDZs_50ANYI\&quot; name=\&quot;Página-1\&quot;&gt;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&lt;/diagram&gt;&lt;/mxfile&gt;&quot;}"></div>
    * <script type="text/javascript" src="https://viewer.diagrams.net/js/viewer-static.min.js"></script>
    * </body>
    * </html>
    * @endhtmlonly
    * <em>Doubly-linked list implementation</em>
    * </center>
    * 
    * Nodes should be an user-defined data structure of any number of members, 
    * however, they must be specially defined to be compatible with the 
    * provided APIs. All the user-defined nodes must have the 
    * #qNode_MinimalFields definition on top of the structure. An example is 
    * shown below:
    * 
    * @code{.c}
    * typedef struct {
    *     qNode_MinimalFields; // required for lists
    *     int a;
    *     int b;
    *     float y;
    * } userdata_t;
    * @endcode
    *
    * With this special type definition on all custom data, the application 
    * writer can take advantage of this powerful data structure.
    * 
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
    #define QLIST_ATFRONT           ( (qList_Position_t)( -1 ) )

    /**
    * @brief This macro should be used to define the destination position of a
    * node at the end of a list
    */
    #define QLIST_ATBACK            ( (qList_Position_t)( 2147483647 ) )


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
        qList_Node_t *next;             /*< Where the iterator is currently pointing. */
        qList_Direction_t direction;    /*< How the iterator scrolls through the list, #QLIST_FORWARD or #QLIST_BACKWARD. */
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
    * @brief Get the current node available in the iterator. After invoked,
    * iterator will be updated to the next node.
    * @param[in] i Pointer to the iterator instance
    * @return Return the next node or @c NULL when no more nodes remain in the list.
    */
    void* qList_IteratorGetNext( qList_Iterator_t *i );

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

    /** @}*/
    #ifdef __cplusplus
    }
    #endif

#endif
