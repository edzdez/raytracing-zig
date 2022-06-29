const std = @import("std");

pub fn main() !void {
    // image
    const IMAGE_WIDTH = 256;
    const IMAGE_HEIGHT = 256;

    // render
    const out = std.io.getStdOut().writer();
    try out.print("P3\n{} {}\n255\n", .{ IMAGE_WIDTH, IMAGE_HEIGHT });

    // rows are written out top to bottom
    var j: isize = IMAGE_HEIGHT - 1;
    while (j >= 0) : (j -= 1) {
        std.debug.print("\rScanlines remaining: {} ", .{j});

        // pixels are written out left to right
        var i: isize = 0;
        while (i < IMAGE_WIDTH) : (i += 1) {
            // by convention, r/g/b range from 0.0-1.0
            const r = @intToFloat(f64, i) / (IMAGE_WIDTH - 1);
            const g = @intToFloat(f64, j) / (IMAGE_HEIGHT - 1);
            const b: f64 = 0.25;

            const ir = @floatToInt(i32, 255.999 * r);
            const ig = @floatToInt(i32, 255.999 * g);
            const ib = @floatToInt(i32, 255.999 * b);

            try out.print("{} {} {}\n", .{ ir, ig, ib });
        }
    }

    std.debug.print("\nDone.\n", .{});
}
