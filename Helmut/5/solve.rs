use itertools::Itertools;

fn mk_stacks(a: &str) -> Vec<Vec<char>> {
    let v = a.lines().collect::<Vec<_>>();
    let n = (v.into_iter().last().unwrap().len() + 1) / 4;
    let mut stack = vec![vec![]; n];
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

fn solve(stack: Vec<Vec<char>>, b: &str)
{
    let mut ss = stack.clone();
    let mut s1 = stack.clone();
    for l in b.lines() {
        let ll = l.split(" ").collect::<Vec<_>>();
        let m = ll[1].parse::<usize>().unwrap();
        let i = ll[3].parse::<usize>().unwrap()-1;
        let j = ll[5].parse::<usize>().unwrap()-1;
        let mut v:Vec<char> = vec![];
        for _ in 0..m {
            let x = ss[i].pop().unwrap();
            ss[j].push(x);
            let x = s1[i].pop().unwrap();
            v.push(x);
        }
        for _ in 0..m {
            let x: char = v.pop().unwrap();
            s1[j].push(x);
        }
    }
    let part1 = ss.into_iter().map(|s| {s.last().cloned().unwrap()}).collect::<String>();
    let part2 = s1.into_iter().map(|s| {s.last().cloned().unwrap()}).collect::<String>();
    println!("{}", part1);
    println!("{}", part2);

}

fn main() {
    let (a, b) = include_str!("input.txt").split_once("\n\n").unwrap();
    let stack = mk_stacks(a);
    solve(stack, b);
}
