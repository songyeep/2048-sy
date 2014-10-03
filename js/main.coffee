#random, library functions

randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]



#game functions

buildBoard = ->
  [0..3].map -> ([0..3].map -> 0)

#note: recursive function
generateTile = (board) ->
  value = 2
  [row, column] = randomCellIndices()
  # console.log "row: #{row}/ col: #{column}}"
  if board[row][column] == 0
    board[row][column] = value
  else
    generateTile(board)

move = (board, direction) ->
  newBoard = buildBoard()
  for i in [0..3]
    if direction is "right" or direction is "left"
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
    else if direction is "up" or direction is "down"
      column = getColumn(i, board)
      column = mergeCells(column, direction)
      column = collapseCells(column, direction)
      setColumn(column, i, newBoard)

  newBoard
#pass by reference (for array) - we need to create a new board, we need a clone
getRow = (r, b) ->
  [b[r][0], b[r][1], b[r][2], b[r][3]]
  # takes the arguments row and board. these are cloned rows and boards that do not change
  # the original @board

getColumn = (c, b) ->
  [b[0][c], b[1][c], b[2][c], b[3][c]]

setRow = (row, index, board) ->
  board[index] = row

setColumn = (column, index, board) ->
  for i in [0..3]
    board[i][index] = column[i]

mergeCells = (cells, direction) ->

  merge = (cells) ->
    for a in [3...0]
      for b in [a-1..0]
        if cells[a] is 0 then break
        else if cells[a] == cells[b]
          cells[a] *= 2
          cells[b] = 0
          break
        else if cells[b] isnt 0 then break
    cells


  if direction is "right" or direction is "down"
    cells = merge(cells)
  else if direction is "left" or direction is "up"
    cells = merge(cells.reverse()).reverse()

  cells

collapseCells = (cells, direction) ->
  cells = cells.filter (x) -> x isnt 0

  if direction is "right" or direction is "down"
    while cells.length < 4
      cells.unshift 0

  else if direction is "left" or direction is "up"
    while cells.length < 4
      cells.push 0

  cells


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
  direction = 'right' or 'left' or 'down' or 'up'
  newBoard = move(board, direction)
  if moveIsValid(board, newBoard)
    return false
  true


isGameOver = (board) ->
  boardIsFull(board) and noValidMove(board)


showBoard = (board) ->
  for row in [0..3]
    for column in [0..3]
      if board[row][column] is 0
        $(".r#{row}.c#{column} > div").html("")
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

      printArray newBoard

      if moveIsValid(@board, newBoard)
        console.log "valid"
        @board = newBoard

        #generate tile
        generateTile(@board)

        #show board
        showBoard(@board)

         #check whether gameover
        if isGameOver(@board)
          alert "YOU SUCK"
      else
        console.log "invalid"

    else
      # do nothing

