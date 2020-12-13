#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

fn
  coin_change
  ( sum: int
  , coins: &(@[int][4]) >> _
  ): int =
let
  fun
    aux
    {n: int | n < 4}
    ( sum: int
    , n: int n
    , coins: &(@[int][4]) >> _
    ): int = 
    if sum > 0 then
      if n >= 0
      then aux (sum, n - 1, coins) + aux (sum - coins[n], n, coins)
      else 0
    else
      if sum < 0
      then 0
      else 1
in
  aux (sum, 3, coins)
end

implement 
main0 () = {
  var coins = @[int]( 1, 5, 10, 25)
  val () = println! ("coin_change (25) = ", coin_change (25, coins))
  val () = println! ("coin_change (100) = ", coin_change (100, coins))
  val () = println! ("coin_change (1000) = ", coin_change (1000, coins))
}