#include "fifo.h"
using namespace std;


Queue* QCreate( int Size )
{
	Queue* p = ( Queue* )calloc( 1, sizeof( Queue ) *Size );
	if( !q )
		printf( "Error: Queue not create\n" );

	p->PQueue = ( int* )calloc( Size, sizeof( int ) );
	p->nHead = -1;
	p->nTail = -1;
	p->nCurrentItems = 0;
	
	return p;
}

int QEmpty( Queue* q )
{
	//return !( q->nCurrentItems );  
	return(q->nHead==-1 && q->nTail==-1);
}

void QEnqueue( Queue* q, int x )
{
	if( q->nCurrentItems = q->nTab )
	{
		printf( "Error: Qenqueue(). Queue is full\n" );
		return;
	}
	else if( QEmpty( q ) )
	{
		q->nHead = 0;
		q->nTail = 0;
		/*
		q->PQueue[ q->nTail ] = x;
		q->nTail++;
		q->nCurrentItems++;
		*/
	}
	else
		q->nTail = ( q->nTail + 1 ) % q->nTab;
		/*
		q->PQueue[ q->nTail ] = x;
		q->nTail = ( q->nTail + 1 ) % q->nTab;
		q->nCurrentItems++;
		*/

	q->PQueue[q->nTail ] = x;
	q->nTail++;
	q->nCurrentItems++;
}

int QDequeue( Queue* q )
{
	if( QEmpty( q ) )
	{
		printf( "Error: QDequeue(). Queue is empty\n" );
		return -1;
	}
	else if( q->nHead == q->nTail )
	{
		q->nTail = -1;
		q->nHead = -1;
		/*
		int tmp = q->PQueue[ q->nHead ];
		q->nHead = ( q->nHead + 1 ) % q->nTab;
		q->nCurrentItems--;
		return tmp;
		*/
	}
	else
	{
		q->nHead = ( q->nHead + 1 ) % q->nTab;
	}
	/*if( q->nCurrentItems )
	{
		q->nCurrentItems--;
		q->nHead++;
		if( q->nHead == q->nTab )
			q->nHead = 0;
	}
	*/

	int x = q->PQueue[ q->nHead ];
	q->nCurrentItems--;
	q->nHead++;
	return x;
}

void QClear( Queue* q )
{
	while( !QEmpty( q ) )
		QDequeue( q );
}

void QDel( Queue** q )
{
	if( !q )
	{
		QClear( *q );
		free( *q );
		*q = NULL;
	}
	else
		printf( "Error: QDel(). No list\n" );
}

void QPrint( Queue* q )
{
	if( !QEmpty( q ) )
	{
		for( int i = q->nHead; i < q->nCurrentItems; i++ )
			printf( "%d\t", q->PQueue[ i ] );
		printf( "\n" );
	}
	else
		printf( "Error: QPrint(). Queue is empty\n" );
	
}

void QRemove( Queue* q )
{

}