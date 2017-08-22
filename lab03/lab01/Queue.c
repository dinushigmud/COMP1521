// ADT for a FIFO queue
// COMP1521 17s2 Week01 Lab Exercise
// Written by John Shepherd, July 2017
// Modified by ...

#include <stdlib.h>
#include <stdio.h>
#include <assert.h>
#include "Queue.h"

typedef struct QueueNode {
   int jobid;  // unique job ID
   int size;   // size/duration of job
   struct QueueNode *next;
} QueueNode;

struct QueueRep {
   int nitems;      // # of nodes
   QueueNode *head; // first node
   QueueNode *tail; // last node
};

//#if 0

// remove the #if 0 and #endif
// once you've added code to use this function

// create a new node for a Queue
static
QueueNode *makeQueueNode(int id, int size)
{
   QueueNode *new;
   new = malloc(sizeof(struct QueueNode));
   assert(new != NULL);
   new->jobid = id;
   new->size = size;
   new->next = NULL;
   return new;
}

//#endif


// make a new empty Queue
Queue makeQueue()
{
   Queue new;
   new = malloc(sizeof(struct QueueRep));
   assert(new != NULL);
   new->nitems = 0;
   new->head = new->tail = NULL;
   return new;
}

// release space used by Queue
void  freeQueue(Queue q)
{
   assert(q != NULL);

   QueueNode *curr;
   QueueNode *temp;
   curr = q->head;
   while (curr != NULL) {
      temp = curr->next;
      free(curr);
      curr = temp;

//free queuerep
   }
}

// add a new item to tail of Queue
void  enterQueue(Queue q, int id, int size)
{
   assert(q != NULL);

   QueueNode *curr;
   QueueNode *nNode;
   nNode = makeQueueNode(id, size);
   if(q->head == NULL){
	   q->head = nNode;
	   q->tail = nNode;
   } else {
	   curr = q->head;
	   while(curr->next != NULL){
	       curr = curr->next;
	   }
	   curr->next = nNode;
	   q->tail = curr->next;
   }
    q->nitems++;
}

// remove item on head of Queue
int   leaveQueue(Queue q)
{
   assert(q != NULL);
   int jobid = 0;
   if( q->head != NULL && q->head->next != NULL){
		QueueNode *temp = q->head;
   		QueueNode *curr = q->head->next;

   		jobid = q->head->jobid;
        q->head = curr;
   		free(temp);
		q->nitems--;
	} else if(q -> head != NULL && q -> head -> next == NULL){
		//when there is a single node in queue
		jobid = q->head->jobid;
		free(q->head);
		q->head = q->tail = NULL;
		q->nitems--;
	} else {
		q->head = q->tail = NULL;
	}
	
	return jobid; // replace this statement
}

// count # items in Queue
int   lengthQueue(Queue q)
{
   assert(q != NULL);
   return q->nitems;
}

// return total size in all Queue items
int   volumeQueue(Queue q)
{
   assert(q != NULL);
   int totalSize = 0;
   QueueNode *curr = q->head;

   while(curr!= NULL){
	 totalSize = totalSize + curr->size;
	 curr = curr->next;
   }
   return totalSize; // replace this statement
}

// return size/duration of first job in Queue
int   nextDurationQueue(Queue q)
{
    assert(q != NULL);
	if(q->head!= NULL){
		return q->head->size; // replace this statement
	} else {
		return 0;
	}
}


// display jobid's in Queue
void showQueue(Queue q)
{
   QueueNode *curr;
   curr = q->head;
   while (curr != NULL) {
      printf(" (%d,%d)", curr->jobid, curr->size);
      curr = curr->next;
   }
}




