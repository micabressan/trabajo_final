edge(1,2,7).
edge(1,3,9).
edge(1,6,14).
edge(2,3,10).
edge(2,4,15).
edge(3,4,11).
edge(3,6,2).
edge(4,5,6).
edge(5,6,9).

redge(S,T,edge(S,T,D)) :- edge(T,S,D).

remove(X,[X|T],T).
remove(X,[H|T],[H|S]) :- remove(X,T,S).

direct_path(S,T,edge(S,T,D)) :- edge(S,T,D).
direct_path(S,T,edge(S,T,D)) :- edge(T,S,D).

find_path(S,T,Visited,Path) :- direct_path(S,T,edge(S,T,D)).
find_path(S,T,Visited,Path) :- direct_path(S,X,edge(S,X,D)),
			       direct_path(X,T,edge(X,T,D)).

path(S,T,Path) :- find_path(S,T,S,Path).