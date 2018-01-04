                                                                                                      
bool operator<(const Card& a, const Card& b) {                                                        
  return a.face < b.face;                                                                             
}                                                                                                     
                                                                                                      
ostream& operator<<(ostream& os, const Card& x) {                                                     
  return os << x.face;                                                                                
}                                                                                                     
                                                                                                      
// Function to deal some cards from the deck                                                          
void deal( Card deck[], int numPlayers, Hand *hands, const string faces[] ) {                         
  int i = 0;                                                                                          
  for(int i = 0; i < numPlayers; i++){                                                                
        Hand h = hands[i];                                                                            
        h.player = i;                                                                                 
                                                                                                      
        set<Card> myFaces;                                                                            
                                                                                                      
        Card x{1};                                                                                    
                                                                                                      
        for(int index = 0; index < 5; i++){                                                           
                hand[index] = deck[index+1]                                                           
        }                                                                                             
                                                                                                      
        for(Card c : myFaces){                                                                        
                myFaces.insert(c.face);                                                               
        }                                                                                             
                                                                                                      
        cout << "SIZE is " << (int) set.size() << endl;                                               
                                                                                                      
        i +=5;                                                                                        
                                                                                                      
  }                                                                                                   
                                                                                                      
}