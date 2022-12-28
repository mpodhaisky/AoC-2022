fn f(s: &str) -> i64 {
    match s {
        "A Y" => 6 + 2,
        "B Z" => 6 + 3,
        "C X" => 6 + 1,
        "A X" => 3 + 1,
        "B Y" => 3 + 2,
        "C Z" => 3 + 3,
        "A Z" => 0 + 3,
        "B X" => 0 + 1,
        "C Y" => 0 + 2,
        _ => unreachable!(),
    }
}

fn main() {
    let ss = include_str!("input.txt").lines().map(|s| f(s)).sum::<i64>();

    println!("{}", ss);
}
