use std::ptr::null;

use loki_linux::wayland::LibWaylandClient;

fn main() {
    unsafe {
        let wayland = LibWaylandClient::new().unwrap();
        let display = (wayland.wl_display_connect)(null());

        println!("Connection established.");

        (wayland.wl_display_disconnect)(display);

        println!("Connection closed.");
    }
}
