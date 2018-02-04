    public function edge_lt(p:Segment,q:Segment) {
        vec_new(u); vec_new(v);
        var flip:Bool;
        $(mixin comp_y_at_x(vertex,edge) ({
            //assume edge not vertical
            flip = edge.right.x < edge.left.x;
            vec_sub(edge.right.,edge.left., u);
            vec_sub(vertex.,edge.left.,v);
            flip ? vec_cross(v,u) : vec_cross(u,v);
        }));
        $(mixin lrg_y_vertex_x(edge,vertex) ({
            if(edge.left.x==edge.right.x) {
                if(edge.left.y < edge.right.y)
                     edge.left.y > vertex.y;
                else edge.right.y > vertex.y;
            }else
                comp_y_at_x(vertex,edge) < 0;
        }));

        if(p.left==q.left && p.right==q.right) return false;
        elif(p.left ==q.right) return  lrg_y_vertex_x(p,q.left);
        elif(p.right==q.left ) return !lrg_y_vertex_x(q,p.left);
        elif(p.left ==q.left ) return  lrg_y_vertex_x(p,q.right);
        elif(p.right==q.right) return  lrg_y_vertex_x(p,q.left);

        //neither end point shared.
        if(p.left.x==p.right.x) {
            if(q.left.x==q.right.x) {
                var pmax = if(p.left.y < p.right.y) p.right else p.left;
                var qmax = if(q.left.y < q.right.y) q.right else q.left;
                return pmax.y > qmax.y;
            }else {
                var  plrg = comp_y_at_x(p.left,q);
                var aplrg = comp_y_at_x(p.right,q);
                if(plrg*aplrg>=0) return plrg >= 0.0;
                else //take into accoutn sweep oisition
                    return sweepx >= p.left.x;
            }
        }else if(q.left.x==q.right.x) {
            var  qlrg = comp_y_at_x(q.left,p);
            var aqlrg = comp_y_at_x(q.right,p);
            if(qlrg*aqlrg>=0) return qlrg < 0.0;
            else //take into account sweep position
                return sweepx < q.left.x;
        }else {
            var qlrg  = comp_y_at_x(q.left,p) < 0.0;
            var aqlrg = comp_y_at_x(q.right,p) < 0.0;
            if  (qlrg==aqlrg)         return qlrg;
            else {
                var  plrg = comp_y_at_x(p.left,q) >= 0.0;
                var aplrg = comp_y_at_x(p.right,q) >= 0.0;
                if(plrg==aplrg) return plrg;

                //take into account sweep position
                var py = (sweepx - p.left.x)/(p.right.x-p.left.x)*(p.right.y-p.left.y) + p.left.y;
                var qy = (sweepx - q.left.x)/(q.right.x-q.left.x)*(q.right.y-q.left.y) + q.left.y;
                return py > qy;
            }
        }
    }