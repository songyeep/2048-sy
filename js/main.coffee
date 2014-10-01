buildBoard = ->
  board = []
  for r in [0..3]
    # row = [] # first loop will create 4 rows into an array
    board[r] = []
    for c in [0..3]
      board[r][c] = 0 #second loop will create 4 cells with value "o" inside each row


  console.log board
  console.log "build board"

generateTile = ->
  console.log "generate tile"


$ ->
  buildBoard()
  generateTile()
  generateTile()