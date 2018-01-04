public: 
void postorderWalk(Node *temp)
	{
		int counter; 
		counter = postorder(temp); 
		cout << "Liczba odwiedzonych wezlow: " << counter << endl; 
	}
private: 	
int postorder(Node *temp)
	{
		int count = 0; 
		int numOfElements;
		if (temp != NULL)
		{
			numOfElements = sizeof(temp->charTable) / sizeof(temp->charTable[0]);
			count = postorder(temp->left) + 1;
			count += postorder(temp->right);
			cout << "Wartosc kluczowa wezla to: " << temp->key << endl;
			cout << "Tablica char wezla to: ";
			for (int i = 0; i < numOfElements; i++)
			{
				cout << temp->charTable[i];
			}
			cout << endl;
		}
		return count; 
	}