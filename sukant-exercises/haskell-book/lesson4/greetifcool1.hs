module GreetIfCool1 where
greetIfCool :: String -> IO ()
greetIfCool coolness =
    if cool
        then putStrLn "eyyy. What's shakin'?"
    else 
        putStrLn "psshhh."
    where cool = coolness == "downright frosty yo"
