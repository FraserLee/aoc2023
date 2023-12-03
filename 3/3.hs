#!/usr/bin/env stack
import System.IO (isEOF)
-- stack script --resolver lts-20.3

main :: IO ()
main = do
    -- contents <- readFile "sample.txt"
    contents <- readFile "input.txt"

    let table = lines contents
        parts = map (map (\x -> if x `elem` ('.' : ['1'..'9']) then 0 else 1)) table
        -- 1 for every "part", 0 for every non-part

        combine = zipWith (zipWith (+))

        false_row = replicate (length (head table)) 0
        up        = tail parts ++ [false_row]
        down      = false_row : init parts

        adjmap_intermediate = combine down $ combine parts up

        left     = map (\x -> tail x ++ [0]) adjmap_intermediate
        right    = map (\x -> 0 : init x) adjmap_intermediate

        -- True for every square adjacent to a part
        adjmap = combine left $ combine adjmap_intermediate right


        -- sum over all numbers in table, if one of their adjacent squares is a part
        stream :: [(Char, Int)]
        stream = (foldl1 (\l1 l2 -> l1 ++ [('.', 0)] ++ l2) $ zipWith zip table adjmap) ++ [('.', 0)]
        -- sum of all numbers in stream, only if at least one of their digits has True

        nums = foldl (\((last_n, last_adj):acc, in_current) (c, adj) -> 
            if c `elem` ['1'..'9'] then
                let n = read [c] in
                if in_current then
                    ((last_n * 10 + n, max last_adj adj):acc, True)
                else
                    ((n, adj):(last_n, last_adj):acc, True)
            else
                ((last_n, last_adj):acc, False)
            ) ([(0, 0)], False) stream

        res = sum $ map (\(x,y) -> x * y) $ fst nums
                






        s1 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> (show x) !! 0)) parts
        s2 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> (show x) !! 0)) adjmap_intermediate
        s3 = foldl1 (\x y -> x ++ "\n" ++ y) $ map (map (\x -> (show x) !! 0)) adjmap


    putStrLn s1
    putStrLn ""
    putStrLn s2
    putStrLn ""
    putStrLn s3
    putStrLn $ map fst stream
    putStrLn $ map (\x -> head $ show $ snd x) stream
    print $ map fst $ fst nums
    print res




