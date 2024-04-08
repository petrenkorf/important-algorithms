const std = @import("std");
const Allocator = std.mem.Allocator;

const SinglyLinkedList = struct {
    head: ?*Node,
    allocator: Allocator,
    const Node = struct { data: u32, next: ?*Node };

    pub fn init(allocator: Allocator) SinglyLinkedList {
        return .{
            .head = null,
            .allocator = allocator,
        };
    }

    pub fn deinit(self: *SinglyLinkedList) void {
        var current = self.head;
        while (current) |cur| {
            current = cur.next;
            self.allocator.destroy(cur);
        }
        self.head = undefined;
    }

    pub fn add(self: *SinglyLinkedList, data: u32) !void {
        const node = try self.allocator.create(Node);
        node.* = .{
            .next = null,
            .data = data,
        };
        if (self.head == null) {
            self.head = node;
        } else {
            var aux: ?*Node = self.head;
            while (aux) |auxNode| {
                if (auxNode.next == null) {
                    auxNode.next = node;
                    break;
                }
                aux = auxNode.next;
            }
        }
    }

    pub fn reverse(self: *SinglyLinkedList) void {
        var current: ?*Node = self.head;
        var prev: ?*Node = null;
        var next: ?*Node = null;

        while (current != null) {
            next = current.?.next;
            current.?.next = prev;
            prev = current;
            current = next;
        }
        self.head = prev orelse null;
    }

    pub fn printList(self: *SinglyLinkedList) void {
        var current = self.head;
        while (current) |c| {
            if (c.next == null) {
                std.debug.print("{}. \n", .{c.data});
            } else {
                std.debug.print("{}, ", .{c.data});
            }
            current = c.next;
        }
    }
};

pub fn main() !void {
    var gpa = std.heap.GeneralPurposeAllocator(.{}){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();
    var list = SinglyLinkedList.init(allocator);
    defer list.deinit();

    try list.add(10);
    try list.add(5);
    try list.add(7);
    try list.add(1);
    try list.add(8);

    list.printList();
    list.reverse();
    list.printList();
}
