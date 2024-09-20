use std::process::Command;
// use rand::prelude::*;


fn main() 
{
    /*
    let mut n = 5;
    let mut s = fact(n);
    println!("fact({}) is {}!", n, s);

    n = rand::thread_rng().gen_range(0..12);
    s = fact(n);
    println!("fact({}) is {}!", n, s);
    */

    let output = if cfg!(target_os = "windows")
    {
        Command::new("cmd")
            .args(["/C", "echo hello"])
            .output()
            .expect("failed to execute process")
    } 
    else
    {
        Command::new("sh")
            .arg("-c")
            .arg("uname -m")
            .output()
            .expect("failed to execute process")
    };
    
    println!("uname -m was {}", String::from_utf8_lossy(&output.stdout));
}

/*
#[inline(never)]
fn fact(n: i32) -> i32
{
    let mut res: i32 = 1;
    let mut i: i32 = 1;
    while i <= n
    {
        res *= i;
        i   += 1;
    }
    res
}
*/