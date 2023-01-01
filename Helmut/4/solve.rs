type Interval = (i64, i64);

fn contains(ab: Interval, cd: Interval) -> bool {
    let (a, b) = ab;
    let (c, d) = cd;
    (a <= c) && ( d <= b ) || ( c <= a ) && ( b <= d )
}

fn overlaps1(ab: Interval, cd: Interval) -> bool {
    let (a, b) = ab;
    let (c, d) = cd;
    (c <= a) && ( a <= d ) || ( c <= b ) && ( b <= d )
}

fn overlap(ab: Interval, cd: Interval) -> bool {
    overlaps1(ab,cd) || overlaps1(cd, ab)
}



fn pint(a: &str, b: &str) -> Interval {
    let aa = a.parse().unwrap();
    let bb = b.parse().unwrap();
    (aa, bb)
}

fn rdl(l: &str) -> (Interval, Interval) {
    let (x, y) = l.split_once(",").unwrap();
    let (a, b) = x.split_once("-").unwrap();
    let (c, d) = y.split_once("-").unwrap();
    (pint(a, b), pint(c, d))
}

fn main() {
    let lines = include_str!("input.txt").lines();
    let w = lines.map(rdl).collect::<Vec<(Interval, Interval)>>();
    let r1 = w.clone().into_iter().filter(|(ab,cd)| {contains(*ab, *cd)}).count();
    let r2 = w.into_iter().filter(|(ab,cd)| {overlap(*ab, *cd)}).count();
    println!("{:?}", r1);
    println!("{:?}", r2);
}
