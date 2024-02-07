target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  br label %sw.bb8

sw.bb8:                                           ; preds = %sw.bb8, %entry
  br label %sw.bb8

if.then22:                                        ; No predecessors!
  call void @dump(ptr null)
  ret i32 0
}

define internal void @dump(ptr %visited_diroff) {
entry:
  %tobool101 = icmp ne ptr %visited_diroff, null
  br i1 %tobool101, label %if.then102, label %if.end103

if.then102:                                       ; preds = %entry
  %0 = load ptr, ptr %visited_diroff, align 8
  br label %if.end103

if.end103:                                        ; preds = %if.then102, %entry
  ret void
}
