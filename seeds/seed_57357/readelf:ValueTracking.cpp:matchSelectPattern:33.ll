target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @ctf_link() {
entry:
  call void @ctf_link_deduplicating()
  ret i32 0
}

define internal void @ctf_link_deduplicating() {
entry:
  %call21 = call i32 @ctf_link_deduplicating_per_cu(ptr null, i64 0)
  ret void
}

define internal i32 @ctf_link_deduplicating_per_cu(ptr %ninputs, i64 %0) {
entry:
  %call6 = call i64 @labs(i64 %0)
  %cmp7 = icmp sgt i64 %call6, 0
  br i1 %cmp7, label %if.then8, label %if.end11

if.then8:                                         ; preds = %entry
  %1 = load ptr, ptr %ninputs, align 8
  br label %if.end11

if.end11:                                         ; preds = %if.then8, %entry
  ret i32 0
}

declare i64 @labs(i64)
