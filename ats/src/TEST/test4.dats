#define ATS_DYNLOADFLAG 0
#define ATS_EXTERN_PREFIX "test"

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"


fn
  coin_change( sum: uint32, coins: &(@[uint32][4])): uint32 = result where {
  val sum_sz = g1ofg0($UN.cast{size_t} sum)
  val sz = sum_sz + i2sz 1
  val ( pf, fpf | v) = array_ptr_alloc<uint32>( sz)
  val () = array_initize_elt<uint32>( !v, sz, $UN.cast{uint32} 0)
  val () = array_set_at_gint(!v, 0, $UN.cast{uint32} 1)
  val () = with_array( pf | v, sz, coins) where {
    fn with_array {l:agz}{sz: nat} ( pf: !array_v(uint32, l, sz) | v: ptr l, sz: size_t sz, coins: &(@[uint32][4])): void = {
      var env1 with env1_pf = ( v, sz)
      vtypedef VT = ( array_v(uint32, l, sz) | ptr env1)
      var env2 = ( pf | addr@env1)
      val _ = array_foreach_funenv<uint32>{(ptr l, size_t sz) @ env1}{VT}( env1_pf | coins, i2sz 4, array_foreach, env2) where {
        fn array_foreach ( pf1: !(ptr l, size_t sz) @ env1 | coin_: &(uint32), env: !VT): void = {
          val coin = g1ofg0( $UN.cast{size_t} coin_)
          val ( pf | env1 ) = env
          val (v, sz) = !env1
          val () = assertloc( coin < sz)
          val () = loop( !v, coin, coin, sz) where {
            fun loop {j,coin,sz:nat | j >= coin; coin < sz; j <= sz }
              .<sz - j>.
              ( v: &(@[uint32][sz]), coin: size_t coin, j: size_t j, sz: size_t sz): void =
              if j = sz
              then ()
              else {
                val t = j - coin
                val () = v[j] := v[j] + v[t]
                val () = loop( v, coin, j + i2sz( 1), sz)
              }
          }
          prval () = env := ( pf | env1)
        }
      }
      val (pf1 | _) = env2
      prval () = pf := pf1
    }
  }
  val result = array_get_at_guint(!v, sum_sz)
  val () = array_ptr_free( pf, fpf | v)
}

implement 
main0 () = {
  var coins = @[uint32]( $UN.cast{uint32} 1, $UN.cast{uint32} 5, $UN.cast{uint32} 10, $UN.cast{uint32} 25)
  val () = println! ("coin_change (25) = ", coin_change ($UN.cast{uint32} 25, coins))
  val () = println! ("coin_change (100) = ", coin_change ($UN.cast{uint32} 100, coins))
  val () = println! ("coin_change (1000) = ", coin_change ($UN.cast{uint32} 1000, coins))
}