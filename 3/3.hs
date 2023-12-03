#!/usr/bin/env stack
import System.IO (isEOF)
-- stack script --resolver lts-20.3

main :: IO ()
main = do
    contents <- readFile "sample.txt"
    -- contents <- readFile "input.txt"

    let table = lines contents
        parts = map (map (\x -> x `notElem` ('.' : ['1'..'9']))) table
        -- True for every "part", False for every non-part

        combine = zipWith (zipWith (||))

        false_row = replicate (length (head table)) False
        up        = tail parts ++ [false_row]
        down      = false_row : init parts

        adjmap_intermediate = combine down $ combine parts up

        left     = map (\x -> tail x ++ [False]) adjmap_intermediate
        right    = map (\x -> False : init x) adjmap_intermediate

        -- True for every square adjacent to a part
        adjmap = combine left $ combine adjmap_intermediate right



        -- sum over all numbers in table, if one of their adjacent squares is a part
        stream = (foldl1 (\l1 l2 -> l1 ++ [('.', False)] ++ l2) $ zipWith zip table adjmap) ++ [('.', False)]
        -- sum of all numbers in stream, only if at least one of their digits has True

        nums = foldl (\((last_n, last_adj):acc, in_current) (c, adj) -> 
            if c `elem` ['1'..'9'] then
                let n = read [c] in
                if in_current then
                    ((last_n * 10 + n, last_adj || adj):acc, True)
                else
                    ((n, adj):(last_n, last_adj):acc, True)
            else
                ((last_n, last_adj):acc, False)
            ) ([(0, False)], False) stream

        res = sum $ map fst $ filter snd $ fst nums
                






        s1 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> if x then '1' else '0')) parts
        s2 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> if x then '1' else '0')) adjmap_intermediate
        s3 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> if x then '1' else '0')) adjmap
        -- s3 = foldl1 (\x y -> x ++ "\n" ++ y) table


    putStrLn s1
    putStrLn ""
    putStrLn s2
    putStrLn ""
    putStrLn s3
    putStrLn $ map fst stream
    putStrLn $ map (\x -> if snd x then '1' else '0') stream
    print $ map fst $ fst nums
    print res




