graph = '1-8-2 2-6-3 3-3-4 4-1-5 5-4-6 6-1-7 7-2-8 8-7-1 8-1-6 1-5-5 7-2-3 6-7-4'

# исходный граф выше задан как строка множества всех дуг, каждая в виде вершина1-длина-вершина2

class Graph # класс графа
    def initialize(graph)
        @nodes = Hash.new { |h, k| h[k] = [] } # граф имеет только вершины (вершина тут - множество всех дуг, смежных с ней)
        graph.split.map { |a| a.split('-').map &:to_i }.each do |edge| # инициализация графа по строке графа
            pair = [edge.first, edge.last]
            [pair, pair.reverse].each do |a|
                @nodes[a.first] << [a.first, edge[1], a.last]
            end
        end
    end

    def find_msp # метод, находящий минимальный остов (по алгоритму Прима)
        cost = Hash.new Float::INFINITY # 'цена' перехода на вершину, изначально равна бесконечности
        best_edge = Hash.new # вершина, имеющая эту ^ цену
        msp = Hash.new { |h, k| h[k] = [] } # минимальный остов
        vertices = @nodes.keys # вершины, которые мы будем рассматривать
        until vertices.empty? # пока есть эти вершины
            v = vertices.min { |a| cost[a] } # находим вершину с минимальной ценой
            vertices.delete v # убираем ее из рассматриваемых
            
            if b = best_edge[v] # если есть дуга с минимальной длиной/ценой к этой вершине
                pair = [b.first, b.last]
                [pair, pair.reverse].each do |a| # добавляем ее в остов
                    msp[a.first] << [a.first, b[1], a.last]
                end
            end

            @nodes[v].each do |e| # для каждой смежной вершины
                next unless vertices.include?(e.last) && e[1] < cost[e.last] # пропускаем, если она не в рассматриваемых или ее цена больше уже найденной
                cost[e.last] = e[1] # обновляем цену смежной вершины
                best_edge[e.last] = e # и дугу к этой вершине
            end
        end
        msp # возвращаем найденный остов
    end
end

g = Graph.new graph # создаем граф
p g.find_msp # ищем остов