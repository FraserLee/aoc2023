#!/usr/bin/env stack
-- stack script --resolver lts-20.3

import Data.List.Split

main :: IO ()
main = do
    contents <- readFile "input.txt"
    print $ sum $ map (\games -> 
                let (min_r, min_g, min_b) = foldl (\(r, g, b) game -> 
                            let moves = splitOn ", " game in
                            foldl (\(r, g, b) move -> 
                                let [n, colour] = splitOn " " move in
                                if      colour == "red"   then (max r (read n :: Int), g, b)
                                else if colour == "green" then (r, max g (read n :: Int), b)
                                else if colour == "blue"  then (r, g, max b (read n :: Int))
                                else error "Invalid colour"
                            ) (r, g, b) moves
                        ) (0, 0, 0) games in min_r * min_g * min_b
            ) $ map (\line -> splitOn "; " (last (splitOn ": " line))) $ lines contents


