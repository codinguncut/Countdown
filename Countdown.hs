-- Copyright (c) 2012 Jonas Tullus
-- Licensed under MIT license
-- Available on GitHub at http://github.com/jethr0/Countdown
-- You can find the task at: http://www.rubyquiz.com/quiz7.html
--
-- Program finds the first exactly matching solution
module Main where

import Control.Monad (guard)
import Data.List (delete, sort)

type NumType = Rational
data Term = Plus  {arg1, arg2 :: Term,  eval :: NumType}
          | Minus {arg1, arg2 :: Term,  eval :: NumType}
          | Mult  {arg1, arg2 :: Term,  eval :: NumType}
          | Div   {arg1, arg2 :: Term,  eval :: NumType}
          | TNum  {                     eval :: NumType}
          deriving (Eq, Ord)


instance Show Term where
  show (TNum  a)      = show $ (round a :: Int)
  show (Plus  a b _)  = show' "+" a b
  show (Minus a b _)  = show' "-" a b
  show (Mult  a b _)  = show' "*" a b
  show (Div   a b _)  = show' "/" a b
show' op a b  = "(" ++ show a ++ op ++ show b ++ ")"


tPlus  a b  = Plus  a b (eval a + eval b)
tMinus a b  = Minus a b (eval a - eval b)
tMult  a b  = Mult  a b (eval a * eval b)
tDiv   a b  = Div   a b (eval a / eval b)
tNum   a    = TNum  a


-- (++) and delete are incredibly slow operations
-- we could improve speed by a large factor using a better data type.
generateTerms ns = generateTerms' (length ns) (sort ns)
generateTerms' l ns = takeNumber ++ terms
  where takeNumber = do
          n <- ns
          return (delete n ns, tNum n)

        terms = do
          guard (l >= 2)
          (ns' , left)  <- generateTerms' (l-1) ns
          (ns'', right) <- generateTerms' (l-1) ns'
          let pluss = do
                guard (eval left < eval right)
                guard (eval left /= 0 && eval right /= 0)
                return $ (ns'', tPlus left right)
              minuss = do
                guard (eval right /= 0)
                return $ (ns'', tMinus left right)
              mults = do
                guard (eval left < eval right)
                guard (eval left /= 1 && eval right /= 1)
                return $ (ns'', tMult left right)
              divs = do
                guard (eval right /= 0 && eval right /= 1)
                return $ (ns'', tDiv left right)
          pluss ++ minuss ++ mults ++ divs


run ns target = filter pred $ generateTerms ns
  where pred (_, t) = eval t == target


numbers = [100, 5, 5, 2, 6, 8] :: [NumType]


main = 
  putStrLn . unlines . map (show . snd) . take 1 $ run numbers 522
