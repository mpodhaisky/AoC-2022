
fn f(s: &str) -> i64 {
    match s {
        "B Z" => 6 + 3,
        "C X" => 6 + 1,
        "A X" => 3 + 1,
        "B Y" => 3 + 2,
        "C Z" => 3 + 3,
        "A Z" => 0 + 3,
        "B X" => 0 + 1,
        "C Y" => 0 + 2,
        _ => {println!("unexpected {:}",s); panic!("raus hier!");}
    }
}

fn g(s: &str) -> i64{
    let a = s.chars().nth(0).unwrap();
    let b = s.chars().nth(2).unwrap();
    if b == 'Y'{
        f(&format!("{} {}", a, (a as u8 +23) as char))
    } else if b == 'X' {
        let bb = match a {
            'A' => 'Z',
            'B' => 'X',
            'C' => 'Y',
            _ => panic!("unexpected input")
        };
        f(&format!("{} {}", a, bb))
    }
    else {
        let bb = match a {
            'A' => 'Y',
            'B' => 'Z',
            'C' => 'X',
            _ => panic!("unexpected input")
        };
        f(&format!("{} {}", a, bb))
    }
}

fn main() {
    let ss = include_str!("input.txt").lines().map(|s| f(s)).sum::<i64>();
    let s1 = include_str!("input.txt").lines().map(|s| g(s)).sum::<i64>();

    println!("part1: {}", ss);
    println!("part2: {}", s1);
}
