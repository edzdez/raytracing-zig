//! This module provides some convenience functions for use with `Color`

const std = @import("std");

pub const Color = @import("vec3.zig");

/// Writes a color out to the given stream
pub fn writeColor(stream: *const std.fs.File, color: *const Color) !void {
    // by convention, r/g/b range from 0.0-1.0
    const ir = @floatToInt(i32, 255.999 * color.getX());
    const ig = @floatToInt(i32, 255.999 * color.getY());
    const ib = @floatToInt(i32, 255.999 * color.getZ());

    try stream.writer().print("{} {} {}\n", .{ ir, ig, ib });
}
