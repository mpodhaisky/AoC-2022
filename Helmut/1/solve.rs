fn main() {
    let _input = include_str!("input.txt");

    let mut calories = _input
        .split("\n\n")
        .map(|cal| cal.lines().map(|x| x.parse::<i64>().unwrap()).sum())
        .collect::<Vec<i64>>();

    calories.sort();

    println!("{}", calories.last().unwrap());
    println!("{}", calories.iter().rev().take(3).sum::<i64>());
}
