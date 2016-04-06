

void mergeLinkedList(linkedList list1, linkedList list1 )
{
	linkedList list3;

	node cursor1 = list1.head;
	node cursor2 = list2.head;


	if (list3.head == NULL)
	{
		if (cursor1.value <= cursor2.value)
		{
			list3.head = cursor1;
		}

		else
		{
			cursor3 = list3.head;
		}
	}

	while (cursor1 != NULL && cursor2 != NULL)
	{
		if (cursor1.value <= cursor2.value)
		{
			list1.head = cursor1.next;
			cursor3.next = cursor1;
			cursor1 = cursor1.next;
			cursor3 = cursor3.next;
		}

		else
		{
			list2.head = cursor3.next;
			cursor3.next = cursor2;
			cursor2 = cursor2.next;
			cursor3 = cursor3.next;
		}
	}

	while (cursor1 != NULL)
	{
		cursor3.next = cursor1;
		cursor1 = cursor1.next;
		cursor3 = cursor3.next;
	}



	while (cursor2 != NULL)
	{
		cursor3.next = cursor2;
		cursor2 = cursor2.next;
		cursor3 = cursor3.next;
	}
}