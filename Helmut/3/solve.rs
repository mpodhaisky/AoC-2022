use itertools::Itertools;
use std::collections::HashSet;

fn p(c: char) -> i64 {
    match c {
        'a'..='z' => c as i64 - 'a' as i64 + 1,
        'A'..='Z' => c as i64 - 'A' as i64 + 27,
        _ => unreachable!(),
    }
}

fn f(s: &str) -> i64 {
    let m = s.len() / 2;
    let a: HashSet<char> = s[0..m].chars().collect();
    let b: HashSet<char> = s[m..].chars().collect();
    if let Some(c) = a.intersection(&b).next() {
        p(*c)
    } else {
        0
    }
}

fn same_chars(a: &[char], b: &[char]) -> Vec<char> {
    a.iter().copied().filter(|c| b.contains(c)).collect()
}

fn main() {
    let ss: i64 = include_str!("input.txt").lines().map(|s| f(s)).sum();

    let lines = include_str!("input.txt")
        .lines()
        .collect::<Vec<_>>();

    let s1: i64 = lines
        .iter()
        .tuples()
        .map(|(a, b, c)| same_chars(&a.chars(), &same_chars(&b.chars(), &c.chars())))
        .map(|c| p(c[0]))
        .sum();

    println!("part1: {}", ss);
    println!("part2: {}", s1);
}
