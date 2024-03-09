#![allow(non_snake_case, clippy::upper_case_acronyms)]

use std::ffi::{c_char, c_int, c_long, c_short, c_uint, c_ulong, c_void};

use crate::library;

#[repr(C)]
pub struct WlDisplay([u8; 0]);

library! {
    [LibWaylandClient <-> "wayland-client"];

    pub fn wl_display_connect(name: *const c_char) -> *mut WlDisplay;
    pub fn wl_display_disconnect(display: *mut WlDisplay);
}
