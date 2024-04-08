const std = @import("std");

const Node = struct { data: u8, next: ?*Node };

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    var item1 = try allocator.create(Node);
    var item2 = try allocator.create(Node);
    var item3 = try allocator.create(Node);
    var item4 = try allocator.create(Node);
    defer _ = allocator.destroy(item1);
    defer _ = allocator.destroy(item2);
    defer _ = allocator.destroy(item3);
    defer _ = allocator.destroy(item4);

    item1.* = .{ .data = 1, .next = item2 };
    item2.* = .{ .data = 2, .next = item3 };
    item3.* = .{ .data = 3, .next = item4 };
    item4.* = .{ .data = 4, .next = null };

    var list = item1;
    var current: ?*Node = item1;
    var prev: ?*Node = null;
    var next: ?*Node = null;

    std.debug.print("{}\n", .{list});

    while (current != null) {
        next = current.?.next;
        current.?.next = prev;
        prev = current;
        current = next;
    }
    list = prev orelse item1;

    std.debug.print("{}\n", .{list});
}
