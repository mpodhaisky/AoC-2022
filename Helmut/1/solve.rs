use itertools::Itertools;

fn main() {
    let _ss = include_str!("input.txt");

    let calories = _ss
        .split("\n\n")
        .map(|cal| cal.lines().map(|x| x.parse::<i64>().unwrap()).sum())
        .sorted()
        .rev()
        .collect::<Vec<i64>>();

    println!("{}", calories.first().unwrap());
    println!("{}", calories.iter().take(3).sum::<i64>());
}
