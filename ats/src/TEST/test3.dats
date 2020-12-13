// https://www.reddit.com/r/ATS/comments/imtp77/the_coin_change_problem_in_ats_rust_and_zig_a/
#include "share/atspre_define.hats"
#include "share/atspre_staload.hats"
staload "libats/ML/SATS/array0.sats"
staload _ = "libats/ML/DATS/array0.dats"

val theCoins = array0($arrpsz{int}(1, 5, 10, 25))

fun coin_change
  (sum: int): int =
  let
    fun aux (sum: int, n: int): int = 
      if sum > 0 then
        (if n >= 0 then aux (sum, n - 1) + aux (sum - theCoins[n], n) else 0)
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