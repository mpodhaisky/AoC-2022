fn main() {
    let (a, b) = include_str!("input.txt").split_once("\n\n").unwrap();
    let v = a.lines().collect::<Vec<_>>();
    let n = (v.into_iter().last().unwrap().len()+1) / 4;

    eprint!("{}",n);
}
