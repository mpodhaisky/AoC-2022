fn f(s: &str) -> i64 {
    println!("{:}\n", s);
    0
}

fn main() {
    let ss = include_str!("input.txt")
        .lines()
        .map(|s| f(s))
        .sum::<i64>();

    //    println!("part1: {}", ss);
}
