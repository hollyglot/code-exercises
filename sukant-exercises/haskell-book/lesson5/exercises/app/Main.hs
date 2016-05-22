module Main where

import Lib

main :: IO ()
main = someFunc


greet :: (String, String) -> IO ()
greet (name, msg) =
    putStrLn ("Hello " ++ name ++ ", " ++ msg) 

curry' :: ((a, b) -> c) -> a -> b -> c
-- curry' = \f -> \a -> \b -> f (a, b) 
-- curry' = \f a b -> f (a, b) 
curry' f a b = f (a,b)


uncurry' :: (a -> b -> c) -> (a, b) -> c

-- uncurry' f args = 
--	let a = fst args
--	    b = snd args
--	in f a b

-- uncurry' f args =
--     f a b
--	   where a = fst args
--	         b = snd args 

uncurry' f (a,b) = f a b

curryGreet :: String -> String -> IO () 
curryGreet = curry' greet

greetHolly :: String -> IO ()
greetHolly = curryGreet "Holly"

greetHollyMsg :: IO ()
greetHollyMsg =
    curry' greet "Holly" "Wazzup??"

ifEven x | x `mod` 2 == 0 = Just x
         | otherwise      = Nothing

