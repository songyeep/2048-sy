#random, library functions

randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

randomValue = ->
  values = [2, 2, 2, 4]
  values[randomInt(4)]






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

noZero = (value) ->
  if value == 0 then "" else value


showBoard = (board) ->
  for row in [0..3]
    for column in [0..3]
      $(".r#{row}.c#{column} > div").html(noZero(board[row][column]))



printArray = (array) ->
  console.log "-- Start -- "
  for row in array
    console.log row
  console.log "-- End --"

$ ->
  newBoard = buildBoard()
  generateTile(newBoard)
  generateTile(newBoard)
  printArray(newBoard)
  showBoard(newBoard)