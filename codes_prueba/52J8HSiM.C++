inline bool canAddOnSameChain(Vertex *p, Vertex *q, Vertex *r, ChainId id) {
    i64 area = getArea(*p, *q, *r);
    return (id == RIGHT) ? (area < 0) : (area > 0);
}

// вызов          самая нижняя вершина      вершина на верхушке стека    предыдущая перед верхушкой стека
canAddOnSameChain(newVertex.second->origin, stack.back().second->origin, lastPopped.second->origin, newVertex.first)