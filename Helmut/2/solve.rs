use itertools::Itertools;

fn f(s : &str) -> i64 {
    return 123;
}

fn main() {
    let ss : &str = include_str!("input.txt")
    .lines()
    .map(|x| {f(x)})
    .sum();

    println!("{:?}", ss);
}
