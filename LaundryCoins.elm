import Graphics.Element exposing (..)

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
        
showCoinsNeeded : Int -> String                
showCoinsNeeded n = "XXX"

main : Element
main =
  showCoinsNeeded 4 |> show