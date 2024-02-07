target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define void @midi_event_system() {
entry:
  %st = alloca [4 x i32], align 16
  %arrayinit.element = getelementptr i32, ptr %st, i64 1
  %arrayinit.end = getelementptr i32, ptr %st, i64 4
  br label %arrayinit.body

arrayinit.body:                                   ; preds = %arrayinit.body, %entry
  %arrayinit.cur = phi ptr [ %arrayinit.element, %entry ], [ %st, %arrayinit.body ]
  %arrayinit.next = getelementptr inbounds i32, ptr %arrayinit.cur, i64 1
  %arrayinit.done = icmp eq ptr %arrayinit.next, %arrayinit.end
  br i1 %arrayinit.done, label %arrayinit.end1, label %arrayinit.body

arrayinit.end1:                                   ; preds = %arrayinit.body
  ret void
}
