#!/usr/bin/env stack
-- stack script --resolver lts-20.3

digit :: String -> Int
digit (x:xs) = if x `elem` ['0'..'9']
               then (read [x] :: Int)
               else digit xs

fDigit :: String -> Int
fDigit line = case line of
    'o':'n':'e':_         -> 1
    't':'w':'o':_         -> 2
    't':'h':'r':'e':'e':_ -> 3
    'f':'o':'u':'r':_     -> 4
    'f':'i':'v':'e':_     -> 5
    's':'i':'x':_         -> 6
    's':'e':'v':'e':'n':_ -> 7
    'e':'i':'g':'h':'t':_ -> 8
    'n':'i':'n':'e':_     -> 9
    x:xs -> if x `elem` ['0'..'9']
            then (read [x] :: Int)
            else fDigit xs

rDigit :: String -> Int
rDigit line = case line of
    '1':_ -> 1 ; '2':_ -> 2 ; '3':_ -> 3 ; '4':_ -> 4 ; '5':_ -> 5 ;
    '6':_ -> 6 ; '7':_ -> 7 ; '8':_ -> 8 ; '9':_ -> 9
    'e':'n':'o':_         -> 1
    'o':'w':'t':_         -> 2
    'e':'e':'r':'h':'t':_ -> 3
    'r':'u':'o':'f':_     -> 4
    'e':'v':'i':'f':_     -> 5
    'x':'i':'s':_         -> 6
    'n':'e':'v':'e':'s':_ -> 7
    't':'h':'g':'i':'e':_ -> 8
    'e':'n':'i':'n':_     -> 9
    x:xs -> if x `elem` ['0'..'9']
            then (read [x] :: Int)
            else rDigit xs


main :: IO ()
main =
    readFile "input.txt" >>= \file ->

    let fLines = lines file in

    putStrLn ("part A: " ++ show (
        sum $ map (
            \line -> 10 * digit line + digit (reverse line)
        ) fLines)
    ) >>

    putStrLn ("part B: " ++ show (
        sum $ map (
            \line -> 10 * fDigit line + rDigit (reverse line)
        ) fLines)
    )
