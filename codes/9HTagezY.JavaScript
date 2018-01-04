<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>Bubbles</title>
  <style>
    * {
      margin: auto;
      box-sizing: border-box;
    }

    #board {

      margin: 0;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);

      display: flex;
      flex-flow: wrap column;
      align-content: flex-start;
    }

    .row {
      display: flex;
    }

    .cell {
      width: 50px;
      height: 50px;
      border: 1px solid white;
      border-radius: 6px;
      background-color: lightgray;
      opacity: 0.55;
      transition: all 0.5s ease;

      display: flex;
    }

    .cell:hover {
      opacity: 1;
    }

    .bubble {
      width: 80%;
      height: 80%;
      border-radius: 50%;
    }

    @keyframes pulse {
      0% {
        transform: scale(0.6);
      }
      50% {
        transform: scale(1);
      }
      100% {
        transform: scale(0.6);
      }
    }

    .bubble:hover {}
  </style>
</head>

<body>
  <div id="board"></div>

  <script>
    function main() {
      const dim = 10; //length and width of a matrix

      let matrix = new Matrix(dim, dim);
      matrix.addBubblesInRandomLocation(20);

      //matrix.setBubbleInCell(0, 1, new Bubble);
      //  matrix.setBubbleInCell(1, 1, new Bubble);

      let graph = new Graph(matrix);

      //console.log(BFS(graph.adjList, 0, blockedList));
      //  console.log(graph.adjList, BFS(graph.adjList, 0));
      // let parents = BFS([
      //   [1, 2],
      //   [0, 2],
      //   [0, 1, 3],
      //   [2]
      // ], 3);
      //
      //console.log(findShortestPath(graph.adjList, 0, 6));

      //graph.printAdjList();

    }
    main();

    //==> Bubble constructor <==//
    function Bubble() {
      this.htmlElement = createDiv("bubble");
      this.htmlElement.style.backgroundColor = getRandomColor();

      function getRandomColor() {
        let colors = ["#16B27D", "#99336d", "#CC2E13", "#90CC05", "#0058B2", "#B84734", "#B27417"];
        return colors[Math.floor(Math.random() * colors.length)];
      }
    }

    //==> Cell constructor <==//
    function Cell() {
      this.htmlElement = createDiv("cell");
      this.htmlElement.addEventListener("click", () => {
        this.isSelected = this.isSelected ? false : true;
      });
      this.htmlElement.addEventListener("mouseover", () => {
        this.isHoveredOver = true;
      });


      this.isSelected = false;
      this.isHoveredOver = false;
      this.bubble = null;
      this.hasBubble = function() {
        return this.bubble != null;
      };

      this.pushBubble = function(bubble) {
        appendHtmlElement(bubble.htmlElement, this.htmlElement);
        this.bubble = bubble;
      }

      this.popBubble = function() {
        let bubble = this.bubble;
        let htmlBubble = bubble.htmlElement;
        htmlBubble.parentNode.removeChild(htmlBubble);
        this.bubble = null;

        return bubble;
      }
    }

    //==> Matrix constructor <==//
    function Matrix(width, height) {
      this.cells = createCells2DArray(width, height);
      createHtmlMatrix(this.cells);
      let htmlElement = document.getElementById("board");
      htmlElement.addEventListener("click", () => {
        console.log(getSelectedCells(this.cells));

      });
      htmlElement.addEventListener("mouseover", () => {
        getHoveredCell(this.cells);
      //  if(selectedCells.length)
      });
      this.width = width;
      this.height = height;
      this.selectedCells = [];

      this.setBubbleInCell = function(x, y, bubble) {
        this.cells[y][x].pushBubble(bubble);
      }

      this.popBubbleFromCell = function(x, y) {
        return this.cells[y][x].pop();
      }

      this.addBubblesInRandomLocation = function(n) {
        let emptyCells = [];
        for (let row of this.cells) {
          for (let cell of row) {
            if (!cell.hasBubble()) emptyCells.push(cell);
          }
        }

        shuffledArray(emptyCells);

        for (var i = 0; i < n; i++) {
          let emptyCell = emptyCells.pop();
          emptyCell.pushBubble(new Bubble());
        }

      }

      this.getAdjacentNeighboursByCell = function(cell) {
        for (var y = 0; y < this.cells.length; y++)
          for (var x = 0; x < this.cells[y].length; x++)
            if (this.cells[y][x] === cell)
              return this.getAdjacentNeighboursByXY(x, y);
      }

      this.getAdjacentNeighboursByXY = function(x, y) {
        let neighbours = [];
        let adjacentCellsDirections = [{
            x: 0,
            y: 1
          }, //top
          {
            x: 1,
            y: 0
          }, //right
          {
            x: 0,
            y: -1
          }, //bottom
          {
            x: -1,
            y: 0
          } //left
        ];
        for (let direction of adjacentCellsDirections) {
          let neighbourX = direction.x + x;
          let neighbourY = direction.y + y;

          if (neighbourX < this.width &&
            neighbourX >= 0 &&
            neighbourY < this.height &&
            neighbourY >= 0) {

            neighbours.push(this.cells[neighbourY][neighbourX]);
          }
        }
        return neighbours;
      }

      function createCells2DArray(width, height) {
        let cells = [];
        for (var y = 0; y < height; y++) {
          cells.push([]);
          for (var x = 0; x < width; x++) {
            cells[y][x] = new Cell(x, y, null);
          }
        }
        return cells;
      }

      function createHtmlMatrix(cells) {
        let board = document.getElementById("board");
        for (var y = 0; y < cells.length; y++) {
          appendHtmlElement(createDiv("row", "row_" + y), board);
          let row = document.getElementById("row_" + y);
          for (let cell of cells[y]) {
            appendHtmlElement(cell.htmlElement, row);
          }
        }
      }

      function getSelectedCells(cells) {
        let selectedCells = [];
        for (let row of cells)
          for (let cell of row)
            if (cell.isSelected) selectedCells.push(cell);

        return selectedCells;
      }

      function getHoveredCell(cells) {
        let hoveredCell;
        for (let row of cells) {
          for (let cell of row) {
            if (cell.isHoveredOver) hoveredCell = cell;
            cell.isHoveredOver = false;
          }
        }
        return hoveredCell;
      }
    }

    //==> Node constructor <==//
    function Node(id, content) {
      this.id = id;
      this.content = content;
    }

    //==> Graph constructor <==//
    function Graph(matrix) {
      this.nodes = createNodesFromMatrix(matrix);
      this.adjList = createAdjList(this.nodes, matrix);

      function createNodesFromMatrix(matrix) {
        let nodes = [];
        let id = 0;
        for (let row of matrix.cells) {
          for (let item of row) {
            nodes.push(new Node(id, item));
            ++id;
          }
        }
        return nodes;
      }

      function createAdjList(nodes, matrix) {
        let adjList = [];

        for (let node of nodes) {
          adjList.push([]);

          let neighbours = matrix.getAdjacentNeighboursByCell(node.content);
          let neighboursIDList = [];
          for (let node of nodes) {
            for (let neighbour of neighbours) {
              if (node.content === neighbour) {
                neighboursIDList.push(node.id);
              }
            }
          }
          adjList[node.id] = neighboursIDList;
        }
        return adjList;
      }

      this.printAdjList = function() {
        for (var i = 0; i < this.adjList.length; i++) {
          console.log(i + ": " + this.adjList[i]);
        }
      }
    }

    //==> HTML creation functions <==//
    function createDiv(className, id) {
      var div = document.createElement("div");
      div.classList.add(className);
      if (id != undefined)
        div.setAttribute("id", id);
      return div;
    }

    function appendHtmlElement(element, destination) {
      destination.appendChild(element);
    }

    function makeElementVisuallySelected(element) {

    }
    //==> DFS <==//
    function DFS(adjList, start = 0, visited = []) {
      //visited -> list for visited nodes, provide own to make some nodes 'blocked'
      let parent = []; //parents list for shortest path

      parent[start] = null; //first node don't have a parent, so null
      _DFS(adjList, start); //kickoff

      function _DFS(graph, v) {
        visited[v] = true; //visit v
        for (let neighbour of graph[v]) { //for every neighbour of v
          if (!visited[neighbour]) { //if neighbour not visited
            parent[neighbour] = v; //set parent of neighbour to v
            _DFS(graph, neighbour); //call DFS for neighbour
          }
        }
      }

      return parent; //return parents
    }

    //==> BFS <==//
    function BFS(graph, start = 0, visited = []) {
      //visited -> list for visited nodes, provide own to make some nodes 'blocked'
      let parent = [];
      let queue = [];


      parent[start] = null;
      queue.unshift(start);
      visited[start] = true;

      while (queue.length > 0) {
        let v = queue.shift();
        for (let neighbour of graph[v]) {
          if (!visited[neighbour]) {
            parent[neighbour] = v;
            queue.unshift(neighbour);
            visited[neighbour] = true;
          }
        }
      }

      return parent;
    }

    //==> Utility functions <==//
    function printParents(parents) {
      for (var i = 0; i < parents.length; i++) {
        console.log("Parent of " + i + " is " + parents[i]);
      }
    }

    function makeBlockedArray(blocked) {
      return [].concat.apply([], blocked);
    }

    function shuffledArray(array) {
      array.sort(function() {
        return 0.5 - Math.random()
      });
      return array;
    }

    function parentsToShortestPath(parents, from) {
      if (parents[from] != undefined) {
        let path = [];
        while (parents[from] != null) {
          path.push(parents[from]);
          from = parents[from];
        }
        return path;
      }
      console.log("ERROR: 'from' index out of bounds");
    }

    function findShortestPath(graph, from, to, blockedList = []) {
      let parents = BFS(graph, to, blockedList);
      return parentsToShortestPath(parents, from);
    }
  </script>
</body>

</html>