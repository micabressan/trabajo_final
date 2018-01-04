QPolygonF tr;
tr.append(QPointF(0, 30));
tr.append(QPointF(30, 30));
tr.append(QPointF(30, 0));
tr.append(QPointF(60, 0));
tr.append(QPointF(60, 40));
tr.append(QPointF(0, 40));

QPolygonF poll;
poll.append((QPointF(40, 10)));
poll.append((QPointF(40, 20)));
poll.append((QPointF(50, 20)));
poll.append((QPointF(50, 10)));

QPainterPath p;
p.addPolygon(tr);
p.addPolygon(poll);
QList<QPolygonF> list = p.toFillPolygons();
qDebug() << list;

/// (QPolygonF(QPointF(0,30)QPointF(30,30)QPointF(30,0)QPointF(60,0)QPointF(60,40)QPointF(0,40)QPointF(0,30)QPointF(40,10)QPointF(40,20)QPointF(50,20)QPointF(50,10)QPointF(40,10)QPointF(0,30)))