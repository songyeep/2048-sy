buildBoard = ->
  board = []
  for i1 in [0..3]
    row = [] #first loop will create 4 rows into an array
    for i2 in [0..3]
      row[i2] = 0 #second loop will create 4 cells with value "o" inside each row
    board[i1] = row #board creates 4 rows in total with 4 cells with value "o"




  console.log board
  console.log "build board"

generateTile = ->
  console.log "generate tile"


$ ->
  buildBoard()
  generateTile()
  generateTile()