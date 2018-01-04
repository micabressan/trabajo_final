	public inline function insert(obj:T) {
		assert(!has(obj),"object already in set");

		//ROTATE(x,left,right) = left rotation
		//ROTATE(x,right,left) = right rotation
		$(mixin ROTATE(x,L,R) {
			var y = x.R;
			x.R = y.L;
			if(y.L!=null) y.L.parent = x;
			y.parent = x.parent;
			if(x.parent==null) parent = y; //root
			elif(x==x.parent.L) x.parent.L = y;
			else                x.parent.R = y;
			y.L = x;
			x.parent = y;
		});

		var x = Get(Set(T));
		x.data = obj;

		__insert(x);

		//rebalancing tree and satisfaction of red-black properties
		while(x!=parent/*root*/ && x.parent.isred) {
			var g = x.parent.parent;
			$(mixin IF(L,R) {
				var y = g.R;
				if(y!=null && y.isred) {
					x.parent.isred = y.isred = false;
					g.isred = true;
					x = g;
				}else {
					if(x==x.parent.R) {
						x = x.parent;
						ROTATE(x,L,R);
					}
					x.parent.isred = false;
					g = x.parent.parent;
					g.isred = true;
					ROTATE(g,R,L);
				}
			});
			if(x.parent==g.prev) IF(prev,next) else IF(next,prev);
		}
		parent.isred = false; //root
	}

	inline function __insert(n:Set(T)) {
		n.isred = true;

		if(parent==null) parent = n; //roots
		else {
			var cur = parent; //root
			while(true) {
				if(n.data.rb_lt(cur.data)) {
					if(cur.prev==null) { cur.prev = n; n.parent = cur; break; }
					else cur = cur.prev;
				}else {
					if(cur.next==null) { cur.next = n; n.parent = cur; break; }
					else cur = cur.next;
				}
			}
		}
		return n;
	}