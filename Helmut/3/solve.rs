use itertools::Itertools;
use std::{collections::HashSet, hash::Hash};

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

fn intersect3(a: &str, b: &str, c: &str) -> i64 {
    let s1: HashSet<char> = a.chars().collect();
    let s2: HashSet<char> = b.chars().collect();
    let s3: HashSet<char> = c.chars().collect();
    let s4: HashSet<_> = s1.intersection(&s2).cloned().collect();
    let s5: HashSet<_> = s4.intersection(&s3).cloned().collect();
    if let Some(c) = s5.into_iter().next() {
        p(c)
    } else {
        0
    }
}

fn main() {
    let ss: i64 = include_str!("input.txt").lines().map(|s| f(s)).sum();

    let lines = include_str!("input.txt").lines().collect::<Vec<_>>();

    let s1: i64 = lines
        .iter()
        .tuples()
        .map(|(a, b, c)| intersect3(a, b, c))
        .sum();

    println!("part1: {}", ss);
    println!("part2: {}", s1);
}
