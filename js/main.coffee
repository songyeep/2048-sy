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

  for i in [0..3]
    if direction is 'right'
      row = getRow(i, board)
      mergeCells(row, direction)
      collapseCells()


#pass by reference (for array) - we need to create a new board, we need a clone
getRow = (r, b) ->
  [b[r][0], b[r][1], b[r][2], b[r][3]]
  # takes the arguments row and board. these are cloned rows and boards that do not change
  # the original @board

mergeCells = (r, d) ->
  if direction is 'right'
    for a in [3...0]
      for b in [a-1..0]
        r[a] == r[b]


# takes the arguments row and direction

  console.log "merge cells"

collapseCells = ->
  console.log "collapse cells"



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
    e.preventDefault()

    key = e.which
    keys = [37..40]

    if key in keys
      direction = switch key
        when 37 then 'left'
        when 38 then 'up'
        when 39 then 'right'
        when 40 then 'down'

      #try moving

      move(@board, direction)


      #check the move validity


    else
      # do nothing
















