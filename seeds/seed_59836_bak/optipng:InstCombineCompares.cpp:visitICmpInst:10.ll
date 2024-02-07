target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @png_init_read_transformations() {
entry:
  br label %if.end

if.else:                                          ; No predecessors!
  call void @png_init_rgb_transformations(ptr null, i1 false)
  br label %if.end

if.end:                                           ; preds = %if.else, %entry
  ret void
}

define internal void @png_init_rgb_transformations(ptr %png_ptr.addr, i1 %cmp3) {
entry:
  %conv4 = zext i1 %cmp3 to i32
  %cmp7 = icmp eq i32 %conv4, 0
  br i1 %cmp7, label %if.then9, label %if.end

if.then9:                                         ; preds = %entry
  %0 = load ptr, ptr %png_ptr.addr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then9, %entry
  ret void
}
