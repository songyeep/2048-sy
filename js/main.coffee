buildBoard = ->
  [0..3].map -> ([0..3].map -> 0)


generateTile = ->
  console.log "generate tile"

printArray = (array) ->
  console.log "-- Start -- "
  for row in array
    console.log row
  console.log "-- End --"

$ ->
  newBoard = buildBoard()
  printArray(newBoard)
  generateTile()
  generateTile()