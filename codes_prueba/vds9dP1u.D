$(import nape);

class Main {

    static function main() {
        var c = flash.Lib.current;

        var space = new Space(new Vec2(0,600));

        var debug = new BitmapDebug(600,600,0x333333);
        c.addChild(debug.display);

        var border = new Body(BodyType.STATIC);
        border.shapes.add(new Polygon(Polygon.rect(0,0,-40,600)));
        border.shapes.add(new Polygon(Polygon.rect(600,0,40,600)));
        border.shapes.add(new Polygon(Polygon.rect(0,0,600,-40)));
        border.shapes.add(new Polygon(Polygon.rect(0,600,600,40)));
        border.space = space;

        var gp:GeomPoly = null;
        var pre:Vec2 = null;
        c.stage.addEventListener(flash.events.MouseEvent.MOUSE_DOWN, function (_) {
            gp = new GeomPoly();
            gp.push(pre = Vec2.get(c.mouseX,c.mouseY));
        });
        c.stage.addEventListener(flash.events.MouseEvent.MOUSE_UP, function (_) {
            if(gp!=null && gp.size()>3) {
                var polys = gp.simple_decomposition();
                for(p in polys) {
                    var body = new Body();
                    var cons = p.convex_decomposition();
                    for(c in cons) body.shapes.add(new Polygon(c));
                    body.align();
                    body.space = space;
                }
            }
            gp = null;
        });

        (new haxe.Timer(0)).run = function() {
            debug.clear();

            if(gp!=null) {
                var cur = Vec2.get(c.mouseX,c.mouseY);
                if(cur.sub(pre).length>5) {
                    gp.push(cur);
                    pre = cur;
                }
                debug.drawFilledPolygon(gp,0x505050);
            }

            space.step(1/60,10,10);
            debug.draw(space);
            debug.flush();
        }
    }

}