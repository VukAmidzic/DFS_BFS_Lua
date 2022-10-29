EMPTY = 0
WALL = 1
START = 2
END = 3
VISITED = 4
------------------
WIDTH = 40
HEIGHT = 20


-- red color: 48;5;160m
-- blue color: 48;5;25m
-- grey color: 48;5;250m
-- green color: 48;5;40m

-- making a new maze
local function makeBoard()
   board = {}
   
   for i = 0,HEIGHT,1 do
        board[i] = {}
        for j = 0,WIDTH,1 do
            if (i == 0 or i == HEIGHT) or 
                (j == 0 or j == WIDTH) then
                board[i][j] = WALL
            else
                board[i][j] = EMPTY
            end
        end
   end
   
   return board
end

-- drawing a maze
local function printBoard(board) 
    for i = 0,HEIGHT,1 do
      for j = 0,WIDTH,1 do
          if (board[i][j] == START) then
              io.write("\27[48;5;40m \27[0m")
          elseif (board[i][j] == END) then
              io.write("\27[48;5;160m \27[0m")
          elseif (board[i][j] == WALL) then
              io.write("\27[48;5;25m \27[0m")
          elseif (board[i][j] == VISITED) then
              io.write("\27[48;5;250m \27[0m")
          else
              io.write(" ")
          end
      end
      print()
    end
end

-- pause function
local function sleep(sec)
    local curr_time = os.clock()
    while (os.clock() - curr_time) <= sec do end
end

--DFS function
local function DFS(curr_x, curr_y, board, goal_x, goal_y, start_x, start_y) 
    if (board[curr_y][curr_x] == WALL or board[curr_y][curr_x] == VISITED) then
        return false
    end
        
    board[curr_y][curr_x] = VISITED
    board[start_y][start_x] = START
    
    printBoard(board)
    sleep(0.1)
    os.execute("clear")
    
    if (curr_x == goal_x and curr_y == goal_y) then
        board[goal_y][goal_x] = END
        printBoard(board)
        return true
    end
        
    if (curr_x > 1 and DFS(curr_x - 1, curr_y, board, goal_x, goal_y, start_x, start_y) == true) then
        return true
    end
    if (curr_x < WIDTH and DFS(curr_x + 1, curr_y, board, goal_x, goal_y, start_x, start_y) == true) then
        return true
    end
    if (curr_x > 1 and DFS(curr_x, curr_y - 1, board, goal_x, goal_y, start_x, start_y) == true) then
        return true
    end
    if (curr_x < HEIGHT and DFS(curr_x, curr_y + 1, board, goal_x, goal_y, start_x, start_y) == true) then
        return true
    end
        
    return false
end

function main()
    local board = makeBoard()
    
    for i = 1,150,1 do
        local wall_x = math.random(2, WIDTH-1)
        local wall_y = math.random(2, HEIGHT-1)
        
        while (board[wall_y][wall_x] == WALL) do
          wall_x = math.random(2, WIDTH-1)
          wall_y = math.random(2, HEIGHT-1)
        end
        
        board[wall_y][wall_x] = WALL
    end
    
    local start_x = math.random(2, WIDTH-1)
    local start_y = math.random(2, HEIGHT-1)
        
    while (board[start_y][start_x] == WALL) do
        start_x = math.random(2, WIDTH-1)
        start_y = math.random(2, HEIGHT-1)
    end
        
    board[start_y][start_x] = START
    
    local end_x = math.random(2, WIDTH-1)
    local end_y = math.random(2, HEIGHT-1)
        
    while (board[end_y][end_x] == WALL or board[end_y][end_x] == START) do
        end_x = math.random(2, WIDTH-1)
        end_y = math.random(2, HEIGHT-1)
    end
        
    board[end_y][end_x] = END
    
    start_time = os.clock()
    if DFS(start_x, start_y, board, end_x, end_y, start_x, start_y) then
      print("Found a path! :) :)")
    else
      print("No path found...")
    end
    end_time = os.clock()
    
    print("Time to find a path: "..(end_time - start_time).."s")
end
    
main()

