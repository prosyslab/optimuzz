target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define ptr @archive_acl_to_text_w() {
entry:
  call void @append_entry_w()
  ret ptr null
}

define internal void @append_entry_w() {
entry:
  call void @append_id_w(ptr null)
  ret void
}

define internal void @append_id_w(ptr %id.addr) {
entry:
  %0 = load i32, ptr %id.addr, align 4
  %cmp = icmp slt i32 %0, 0
  %spec.store.select = select i1 %cmp, i32 0, i32 %0
  store i32 %spec.store.select, ptr %id.addr, align 4
  ret void
}
