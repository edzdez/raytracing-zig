# Raytracing in One Weekend

A simple raytracer written in [Zig](https://ziglang.org), adapted from the book [_Ray Tracing in One Weekend_](https://raytracing.github.io/books/RayTracingInOneWeekend.html).

## Build

Zig is still an unstable language (pre 1.0), so this program may not build on versions of zig other than 0.9.1.

```shell
# Clone the repo
$ git clone https://github.com/edzdez/raytracing-zig.git

# Build with zig
$ zig build -Drelease-safe
$ ./zig-out/bin/raytracing-zig

# Alternatively, build and run in one step
$ zig build run -Drelease-safe
```
