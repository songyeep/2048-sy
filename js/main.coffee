#random, library functions

randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = ["x", "x", "x", 2, 2, 2, 2, 2, 2, 2, 4, 4, 4, 4, 4]
  values[randomInt(15)]
# x for explode tile


#game functions

buildBoard = ->
  [0..3].map -> ([0..3].map -> 0)

#note: recursive function
generateTile = (board) ->
  value = randomValue()
  [row, column] = randomCellIndices()
  if board[row][column] == 0
    board[row][column] = value
  else
    generateTile(board)


move = (board, direction) ->
  newBoard = buildBoard()
  for i in [0..3]
    if direction in ["right", "left"]
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction in ["up", "down"]
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      setColumn(column, i, newBoard)

  newBoard

#pass by reference (for array) - we need to create a new board, we need a clone
getRow = (r, b) ->
  [b[r][0], b[r][1], b[r][2], b[r][3]]

getColumn = (c, b) ->
  [b[0][c], b[1][c], b[2][c], b[3][c]]

setRow = (row, index, board) ->
  board[index] = row

setColumn = (column, index, board) ->
  for i in [0..3]
    board[i][index] = column[i]

mergeCells = (cell, direction) ->

  merge = (cell) ->
    for a in [3...0]
      for b in [a-1..0]
        if (cell[a] == cell[b]) and (cell[a] isnt "x")
          cell[a] *= 2
          cell[b] = 0

        else if cell[a] == "x"
          if cell[b] > 0
            cell[a] = 0
            cell[b] = 0
            $(".bomb_audio").trigger("play");

            break

          else if cell[a] == cell[b] == "x"
            cell[a] = 0
            cell[b] = 0
            $(".bomb_audio").trigger("play");

            break

        else if cell[b] == "x"
          if cell[a] > 0
            cell[a] = 0
            cell[b] = 0
            $(".bomb_audio").trigger("play");

            break

        else if cell[b] isnt 0 then break

    cell

  if direction in ["right", "down"]
    cell = merge(cell)
  else if direction in ["left", "up"]
    cell = merge(cell.reverse()).reverse()

  cell


collapseCells = (cell, direction) ->
  cell = cell.filter (x) -> x isnt 0
  # bombCell = cell.filter(x) -> x is "x"

  while cell.length < 4
    if direction in ["right", "down"]
      cell.unshift 0
    else if direction in ["left", "up"]
      cell.push 0



#while cell includes "x"
# if direction in ["right", "down"]
# cell.unshift 0, 0
# else if direction in ["left", "up"]
# cell.push 0, 0



  cell


moveIsValid = (originalBoard, newBoard) ->
  answer = true
  for row in [0..3]
    for column in [0..3]
      if originalBoard[row][column] isnt newBoard[row][column]
        return true
  false

boardIsFull = (board) ->
  for row in board
    if 0 in row
      return false
  true

noValidMove = (board) ->
  for direction in ['right', 'left', 'down', 'up']
    newBoard = move(board, direction)
    if moveIsValid(board, newBoard)
      return false
  true

isGameOver = (board) ->
  boardIsFull(board) and noValidMove(board)


showBoard = (board) ->
  for row in [0..3]
    for column in [0..3]
      if board[row][column] == 0
        $(".r#{row}.c#{column} > div").html("").css("background", "#797980") #background color
      else if board[row][column] == 'x'
        $(".r#{row}.c#{column} > div").html('<img src="/img/BOMB-620_1611903a.png" class="bomb-pic">')
      else
        $(".r#{row}.c#{column} > div").html(board[row][column])


printArray = (array) ->
  console.log "-- Start -- "
  for row in array
    console.log row
  console.log "-- End --"




$ ->
  @board = buildBoard()
  generateTile(@board)
  generateTile(@board)

  printArray(@board)
  showBoard(@board)

  $("body").hide()
  $("body").fadeIn(1000)


  $("body").keydown (e) =>


    key = e.which
    keys = [37..40]

    if key in keys
      e.preventDefault()
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

      #try moving
      newBoard = move(@board, direction)
      #check the move validity,
      # by comparing the original and new board

      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard

        #generate tile
        generateTile(@board)

        #show board
        showBoard(@board)

        printArray newBoard

         #check whether gameover
        if isGameOver(@board)
          alert "Game over, dude"
      else
        console.log "invalid"

    else
      # do nothing


  $("#startNewGame").click () =>
    @board = buildBoard()
    generateTile(@board)
    generateTile(@board)
    printArray(@board)
    showBoard(@board)




































