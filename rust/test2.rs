//https://www.reddit.com/r/rust/comments/i1ayyj/the_coin_change_problem_in_ats_rust_and_zig_a/fzwl6nr/
const COINS: [u32; 4] = [1, 5, 10, 25];

fn coin_change(sum: u32) -> u32 {
    let sum = sum as usize;
    let mut v = vec![0; sum + 1];
    v[0] = 1;
    for &coin in &COINS {
        let coin = coin as usize;
        for j in coin..=sum {
            let t = j - coin;
            v[j] += v[t as usize]
        }
    }
    v[sum]
}

fn main() {
    println!("coin_change(25) = {}", coin_change(25));
    println!("coin_change(100) = {}", coin_change(100));
    println!("coin_change(1000) = {}", coin_change(1000));
}
