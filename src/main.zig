const std = @import("std");

const Color = @import("vec3.zig");
const color = @import("color.zig");

pub fn main() !void {
    // image
    const IMAGE_WIDTH = 256;
    const IMAGE_HEIGHT = 256;

    // render
    const stream = std.io.getStdOut();
    const out = stream.writer();
    try out.print("P3\n{} {}\n255\n", .{ IMAGE_WIDTH, IMAGE_HEIGHT });

    // rows are written out top to bottom
    var j: isize = IMAGE_HEIGHT - 1;
    while (j >= 0) : (j -= 1) {
        std.debug.print("\rScanlines remaining: {} ", .{j});

        // pixels are written out left to right
        var i: isize = 0;
        while (i < IMAGE_WIDTH) : (i += 1) {
            const r = @intToFloat(f64, i) / (IMAGE_WIDTH - 1);
            const g = @intToFloat(f64, j) / (IMAGE_HEIGHT - 1);
            const b: f64 = 0.25;

            try color.writeColor(&stream, &Color.init(r, g, b));
        }
    }

    std.debug.print("\nDone.\n", .{});
}
