fn main() {
    let _ss = include_str!("input.txt");

    let mut calories = _ss
        .split("\n\n")
        .map(|cal| cal.lines().map(|x| x.parse::<i64>().unwrap()).sum())
        .collect::<Vec<i64>>();

    calories.sort();
    calories.reverse();

    println!("{}", calories.first().unwrap());
    println!("{}", calories.iter().take(3).sum::<i64>());
}
