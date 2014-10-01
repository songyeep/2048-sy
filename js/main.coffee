randomInt = (x) ->
  Math.floor(Math.random() * x)

randomCellIndices = ->
  [randomInt(4), randomInt(4)]

buildBoard = ->
  [0..3].map -> ([0..3].map -> 0)

generateTile = ->
  value = 2
  console.log randomCellIndices()

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