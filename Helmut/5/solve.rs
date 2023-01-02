use itertools::Itertools;

fn mkStacks(a: &str) -> Vec<Vec<char>> {
    let v = a.lines().collect::<Vec<_>>();
    let n = (v.into_iter().last().unwrap().len() + 1) / 4;
    let mut stack: Vec<Vec<char>> = (0..n).map(|_| vec![]).collect();
    for l in a.lines().rev() {
        for i in 0..n {
            let p = 4 * i + 1;
            if let Some(c) = l.chars().nth(p) {
                if c.is_ascii_uppercase() {
                    stack[i].push(c);
                }
            }
        }
    }
    stack
}
fn main() {
    let (a, b) = include_str!("input.txt").split_once("\n\n").unwrap();
    let mut stack = mkStacks(a);
    for l in b.lines() {
        let ll = l.split(" ").collect::<Vec<_>>();
        let m = ll[1].parse::<usize>().unwrap();
        let i = ll[3].parse::<usize>().unwrap()-1;
        let j = ll[5].parse::<usize>().unwrap()-1;
        for _ in 0..m {
            let x = stack[i].pop().unwrap();
            stack[j].push(x);
        }
    }
    let lsg = stack.into_iter().map(|s| {s.last().cloned().unwrap()}).collect::<String>();
    println!("{}", lsg);
}
