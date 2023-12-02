#!/usr/bin/env stack
-- stack script --resolver lts-20.3

import Data.List.Split

main :: IO ()
main = do
    contents <- readFile "input.txt"

    putStrLn $ "Part B: " ++ show ( sum $ map ((\games ->
           let (min_r, min_g, min_b) = foldl (\(r, g, b) game ->
                       let moves = splitOn ", " game in
                       foldl (\(r, g, b) move ->
                           let [n, colour] = splitOn " " move in
                           if      colour == "red"   then (max r (read n), g, b)
                           else if colour == "green" then (r, max g (read n), b)
                           else if colour == "blue"  then (r, g, max b (read n))
                           else error "Invalid colour"
                       ) (r, g, b) moves
                   ) (0, 0, 0) games
           in min_r * min_g * min_b
       ) . splitOn "; " . last . splitOn ": ") $ lines contents)

    putStrLn $ "Part A: " ++ show ( sum $ zipWith (\i games ->
           let (min_r, min_g, min_b) = foldl (\(r, g, b) game ->
                       let moves = splitOn ", " game in
                       foldl (\(r, g, b) move ->
                           let [n, colour] = splitOn " " move in
                           if      colour == "red"   then (max r (read n), g, b)
                           else if colour == "green" then (r, max g (read n), b)
                           else if colour == "blue"  then (r, g, max b (read n))
                           else error "Invalid colour"
                       ) (r, g, b) moves
                   ) (0, 0, 0) games
           in if min_r < 13 && min_g < 14 && min_b < 15 
              then i 
              else 0
       ) [1..] $ map (splitOn "; " . last . splitOn ": ") $ lines contents)
