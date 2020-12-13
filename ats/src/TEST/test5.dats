#define ATS_DYNLOADFLAG 0
#define ATS_EXTERN_PREFIX "test"

#include "share/atspre_staload.hats"
#include "share/atspre_define.hats"

staload UN = "prelude/SATS/unsafe.sats"

fn
  {a:viewt0ype}
  array_foreach_funenv1
  {v:view}
  {env:viewt0ype}
  {fe:eff}
  {n:nat}
  ( pf: !v
  | A: &(@[a][n]) >> _
  , sz: size_t n
  , env: &env
  , f: (!v | &a, &env) -<fun,fe> void
  ):<fe> void = {
  prval a_pf = view@A
  val a_ptr = addr@A
  fun
    loop
    {i:nat | i <= n}{l:addr}
    .<n-i>.
    ( pf: !v
    , a_pf: !array_v(a, l, n)
    | i: size_t i
    , a_ptr: ptr (l + i*sizeof(a))
    , sz: size_t n
    , env: &env
    , f: (!v | &a >> _, &env) -<fun,fe> void
    ):<fe> void =
    if i = sz
    then ()
    else loop(pf, a_pf | i + i2sz 1, ptr_succ<a> a_ptr, sz, env, f) where {
      prval (a_pf1, a_pf2) = array_v_split_at( a_pf | i)
      prval (head_pf, rest_pf) = array_v_uncons( a_pf2)
      val () = f( pf | !a_ptr, env)
      prval () = a_pf2 := array_v_cons( head_pf, rest_pf)
      prval () = a_pf := array_v_unsplit( a_pf1, a_pf2)
    }
  val () = loop( pf, a_pf | i2sz 0, a_ptr, sz, env, f)
  prval () = view@A := a_pf
}
  
  

fn
  coin_change( sum: uint32, coins: &(@[uint32][4])): uint32 = result where {
  val sum_sz = g1ofg0($UN.cast{size_t} sum)
  val sz = sum_sz + i2sz 1
  val ( pf, fpf | v) = array_ptr_alloc<uint32>( sz)
  val () = array_initize_elt<uint32>( !v, sz, $UN.cast{uint32} 0)
  val () = array_set_at_gint(!v, 0, $UN.cast{uint32} 1)
  val () = with_array( pf | v, sz, coins) where {
    fn with_array {l:agz}{sz: nat} ( pf: !array_v(uint32, l, sz) | v: ptr l, sz: size_t sz, coins: &(@[uint32][4])): void = {
      var env1 = ( v, sz)
      vtypedef VT = ( ptr l, size_t sz)
      val _ = array_foreach_funenv1<uint32>{array_v(uint32, l, sz)}{VT}( pf | coins, i2sz 4, env1, array_foreach) where {
        fn array_foreach ( pf1: !array_v(uint32,l,sz) | coin_: &(uint32), env: &VT): void = {
          val coin = g1ofg0( $UN.cast{size_t} coin_)
          val ( v,sz ) = env
          val () = assertloc( coin < sz)
          val () = loop( !v, coin, coin, sz) where {
            fun loop {j,coin,sz:nat | j >= coin; coin < sz; j <= sz }
              .<sz - j>.
              ( v: &(@[uint32][sz]), coin: size_t coin, j: size_t j, sz: size_t sz): void = ifcase
              | j = sz => ()
              | _ => {
                val t = j - coin
                val () = v[j] := v[j] + v[t]
                val () = loop( v, coin, j + i2sz( 1), sz)
              }
          }
        }
      }
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