import Graphics.Element exposing (..)
import List exposing (concat, repeat, append, foldr, map, filter, length) 
import Html exposing (Html, div, text)

type Coin
    = Quarter 
    | Loonie
    
type alias Cents
    = Int
      
cents : Coin -> Cents
cents coin =
    case coin of
      Quarter -> 25
      Loonie -> 100 

cycleCost : List Coin
cycleCost = (concat << repeat 2) [Quarter, Quarter, Loonie]               

nDaysCost : Int -> List Coin
nDaysCost n = repeat n cycleCost |> foldr (++) []

sumCost : List Coin -> Cents
sumCost = map cents >> foldr (+) 0

loonies : List Coin -> Int
loonies = filter ((==) Loonie) >> length          

quarters : List Coin -> Int
quarters = filter ((==) Quarter) >> length          

showCoinsNeeded : Int -> Html                
showCoinsNeeded n = let cost = nDaysCost n
                        l = loonies cost
                        q = quarters cost
                        t = (sumCost cost) // 100 -- OK to discard remainder as our cost rounds to dollars
                    in
                      div []
                           [ div [] [ text <| "To do laundry " ++ toString n ++ " times, ask the cashier for:" ]
                           , div [] [ text <| toString l ++ " loonies," ]
                           , div [] [ text <| toString q ++ " quarters, from" ]
                           , div [] [ text <| "$" ++ toString t ++ " cash back" ]
                           ]
      

main : Html
main =
  showCoinsNeeded 4