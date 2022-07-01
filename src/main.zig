const std = @import("std");

const Vec3 = @import("vec3.zig");
const color = @import("color.zig");
const Color = color.Color;
const Ray = @import("ray.zig");
const Point3 = Ray.Point3;

fn rayColor(r: *const Ray) Color {
    // scale the ray direction to unit length (-1.0 < y < 1.0)
    const unit_direction = Vec3.normalize(&r.getDirection());

    // scale t to 0.0 <= t <= 1.0. When t = 0, we get blue. When it's 1, we get white. Everything in between is a blend.
    // This performs a linear interpolation (or lerp for short)
    const t = 0.5 * (unit_direction.getY() + 1.0);

    // a lerp is always in the form $\text{blendedValue} = \left( 1 - t \right) \cdot \text{startValue} + t \cdot \text{endValue}$,
    // where t ranges from 0 to 1
    return Color.init(1.0, 1.0, 1.0).scalarMultiply(1.0 - t).add(&Color.init(0.5, 0.7, 1.0).scalarMultiply(t));
}

pub fn main() !void {
    // image
    const ASPECT_RATIO = 16.0 / 9.0;
    const IMAGE_WIDTH = 400;
    const IMAGE_HEIGHT = @floatToInt(comptime_int, IMAGE_WIDTH / ASPECT_RATIO);

    // camera
    const viewport_height = 2.0;
    const viewport_width = ASPECT_RATIO * viewport_height;
    const focal_length = 1.0;

    const origin = Point3.init(0.0, 0.0, 0.0);
    const horizontal = Vec3.init(viewport_width, 0.0, 0.0);
    const vertical = Vec3.init(0.0, viewport_height, 0.0);
    const lower_left_corner = origin.subtract(&horizontal.scalarDivide(2)).subtract(&vertical.scalarDivide(2)).subtract(&Vec3.init(0.0, 0.0, focal_length));

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
            const u = @intToFloat(f64, i) / (IMAGE_WIDTH - 1);
            const v = @intToFloat(f64, j) / (IMAGE_HEIGHT - 1);

            const ray = Ray.init(origin, lower_left_corner.add(&horizontal.scalarMultiply(u)).add(&vertical.scalarMultiply(v)).subtract(&origin));
            const pixel_color = rayColor(&ray);
            try color.writeColor(&stream, &pixel_color);
        }
    }

    std.debug.print("\nDone.\n", .{});
}
