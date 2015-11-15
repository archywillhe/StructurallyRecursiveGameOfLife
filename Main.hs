import Data.List

powerset [] = [[]]
powerset (x:xs) = [ x:ns | ns <- recursion] ++ recursion
  where recursion = powerset xs

neighboursOf :: (Int,Int) -> [(Int,Int)]
neighboursOf (a,b) = [(x,y)| x <- f a, y <- f b] \\ [(a,b)]
  where f n = [n-1,n,n+1]

survive :: [(Int,Int)] -> [(Int, Int)] -> [(Int,Int)]
survive [] world = []
survive (cell:cells) world
  | aliveN == 2 || aliveN == 3 = cell:(survive cells world)
  | otherwise = survive cells world
  where aliveN = length $ (neighboursOf cell) `intersect` world

produce :: [(Int,Int)] -> [(Int,Int)]
produce cells =  [ x | x <- deadCellsWith3NOrMore, counts deadCellsWith3NOrMore x == 1] \\ cells
--note: if a dead cell has more than 3 neighbours, it would appear more than 1 time in the list dCellsWith3NOrMore
 where
    deadCellsWith3NOrMore = concat $ [nIntersect xs | xs <- powerset cells, length xs == 3 ]
    nIntersect (x:[]) = neighboursOf x
    nIntersect (x:xs) = neighboursOf x `intersect` nIntersect xs
    counts [] x = 0
    counts (y:ys) x
      | y == x = 1 + (counts ys x)
      | otherwise = counts ys x

makeNewWorld :: [(Int,Int)] -> Int -> [(Int,Int)]
makeNewWorld cells 0 = cells
makeNewWorld cells n = makeNewWorld ((survive cells cells) ++ (produce cells)) (n-1)
-- this function is in more of the accumulator style (rather than being structurally recursive)
-- I don't think a structurally recursive implementation makes sense here.


testMakeNewWorld :: [(Int,Int)] -> Int -> [(Int,Int)] -> Bool
testMakeNewWorld world n newWorld = null ((makeNewWorld world n) \\ newWorld)

runTests :: [([(Int,Int)], Int, [(Int,Int)])] -> Bool
runTests [] = True
runTests ((world,n,newWrold):testcases) = (testMakeNewWorld world n newWrold) && (runTests testcases)

testcases = [([(0,0)],1,[]),
             ([(0,0),(0,1)],99,[]),
             ([(0,0),(0,1),(1231,124),(13,125)],1,[]),
             ([(0,0),(1,0),(-1,1),(1,1)],1,[(0,0),(1,0),(1,1)]),
             ([(0,0),(0,1),(1,1)],1,[(1,0),(0,0),(0,1),(1,1)]),
             ([(0,0),(0,1),(1,1)],99,[(1,0),(0,0),(0,1),(1,1)])]

-- main = print $ runTests testcases

main = do
      putStrLn "Hello, please enter the initial state of the game! e.g [(0,0),(0,1)] "
      state <- getLine
      putStrLn "now please enter the number of iterations! e.g 1"
      number <- getLine
      putStrLn "This is the state after the iterations:"
      print $ makeNewWorld (read state :: [(Int,Int)]) (read number :: Int)
