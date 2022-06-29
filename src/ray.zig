//! This module provides a struct representing a 'ray'

const Self = @This();

const std = @import("std");

const Vec3 = @import("vec3.zig");
pub const Point3 = Vec3;

orig: Point3,
dir: Vec3,

/// Creates a `Ray` given a `Point` and a `Direction`
pub fn init(origin: Point3, direction: Vec3) Self {
    return Self{
        .orig = origin,
        .dir = direction,
    };
}

/// Returns the `origin` of a `Ray`
pub fn getOrigin(self: *const Self) Point3 {
    return self.orig;
}

/// Returns the `direction` of a `Ray`
pub fn getDirection(self: *const Self) Vec3 {
    return self.dir;
}

/// Returns the point at `t` on a `Ray`
pub fn at(self: *const Self, t: f64) Point3 {
    return self.getOrigin().add(&self.getDirection().scalarMultiply(t));
}

test "ray/ray.accessors" {
    const origin = Point3.init(0.0, 0.0, 0.0);
    const direction = Vec3.init(1.0, 1.0, 1.0);
    const ray = Self.init(origin, direction);

    try std.testing.expectEqual(origin, ray.getOrigin());
    try std.testing.expectEqual(direction, ray.getDirection());
}

test "ray/ray.at" {
    const origin = Point3.init(1.0, 1.0, 0.0);
    const direction = Vec3.init(1.0, 1.0, 1.0);
    const ray = Self.init(origin, direction);

    try std.testing.expectEqual(origin, ray.at(0.0));
    try std.testing.expectEqual(direction.scalarMultiply(5.0).add(&origin), ray.at(5.0));
    try std.testing.expectEqual(direction.scalarMultiply(-3.0).add(&origin), ray.at(-3.0));
    try std.testing.expectEqual(direction.scalarMultiply(1.0).add(&origin), ray.at(1.0));
    try std.testing.expectEqual(direction.scalarMultiply(-0.3).add(&origin), ray.at(-0.3));
    try std.testing.expectEqual(direction.scalarMultiply(0.8).add(&origin), ray.at(0.8));
}
