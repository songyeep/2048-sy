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

move =(board, direction) ->
  newBoard = buildBoard()

  for i in [0..3]
    if direction is "right" #or "left"
      row = getRow(i, board)
      row = mergeCells(row, direction)
      row = collapseCells(row, direction)
      setRow(row, i, newBoard)
  newBoard
#pass by reference (for array) - we need to create a new board, we need a clone
getRow = (r, b) ->
  [b[r][0], b[r][1], b[r][2], b[r][3]]
  # takes the arguments row and board. these are cloned rows and boards that do not change
  # the original @board


setRow = (row, index, board) ->
  board[index] = row

mergeCells = (row, direction) ->
  if direction is "right"
    for a in [3...0]
      for b in [a-1..0]
        if row[a] is 0 then break
        else if row[a] == row[b]
          row[a] *= 2
          row[b] = 0
          break
        else if row[b] isnt 0 then break
  # else if direction is "left"
  #   for a in [0...3]
  #     for b in [a+1..0]
  #       if row[b] is 0 then break
  #       else if row[a] == row[b]
  #         row[a] *= 2
  #         row[b] = 0
  #         break
  #       else if row[a] isnt 0 then break
  row

collapseCells = (row, direction) ->
  row = row.filter (x) -> x isnt 0

  if direction is "right"
    while row.length < 4
      row.unshift 0
  # else if direction is "left"
  #   while row.length < 4
  #     row.push 0
  row


moveIsValid = (originalBoard, newBoard) ->
  answer = true
  for row in [0..3]
    for column in [0..3]
      if originalBoard[row][column] isnt newBoard[row][column]
        return true
  false

showValue = (value) ->
  if value is 0 then "" else value


showBoard = (board) ->
  for row in [0..3]
    for column in [0..3]
      $(".r#{row}.c#{column} > div").html(showValue(board[row][column]))


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
        generateTile(@board)
        showBoard(@board)
      else
        console.log "invalid"

    else
      # do nothing
















