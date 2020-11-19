#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"

typedef
int4 = (int, int, int, int)

val theCoins = (1, 5, 10, 25): int4

fn coin_get
  (n: int): int = 
 (if n = 0 then theCoins.0
  else if n = 1 then theCoins.1
  else if n = 2 then theCoins.2
  else if n = 3 then theCoins.3
  else ~1)

fun coin_change
  (sum: int): int =
  let
    fun aux (sum: int, n: int): int = 
      if sum > 0 then
        (if n >= 0 then aux (sum, n - 1) + aux (sum - coin_get (n), n) else 0)
      else (if sum < 0 then 0 else 1)
  in
    aux (sum, 3)
  end

implement 
main0 () = {
  val () = println! ("coin_change (25) = ", coin_change (25))
  val () = println! ("coin_change (100) = ", coin_change (100))
  val () = println! ("coin_change (1000) = ", coin_change (1000))
}