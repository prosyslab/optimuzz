target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.anon.1.554 = type { i32, i32, i32, i32, i32, i32 }

@adlibconfig_widgets = internal constant [26 x %struct.anon.1.554] [%struct.anon.1.554 { i32 4, i32 3, i32 1, i32 10, i32 0, i32 1 }, %struct.anon.1.554 { i32 4, i32 4, i32 0, i32 10, i32 1, i32 3 }, %struct.anon.1.554 { i32 0, i32 7, i32 0, i32 5, i32 4, i32 4 }, %struct.anon.1.554 { i32 0, i32 8, i32 0, i32 5, i32 0, i32 4 }, %struct.anon.1.554 { i32 0, i32 9, i32 0, i32 7, i32 4, i32 -4 }, %struct.anon.1.554 { i32 0, i32 10, i32 0, i32 7, i32 0, i32 4 }, %struct.anon.1.554 { i32 0, i32 11, i32 1, i32 1, i32 5, i32 1 }, %struct.anon.1.554 { i32 0, i32 12, i32 0, i32 3, i32 0, i32 -6 }, %struct.anon.1.554 { i32 1, i32 7, i32 0, i32 4, i32 4, i32 4 }, %struct.anon.1.554 { i32 1, i32 8, i32 0, i32 4, i32 0, i32 4 }, %struct.anon.1.554 { i32 1, i32 9, i32 0, i32 6, i32 4, i32 -4 }, %struct.anon.1.554 { i32 1, i32 10, i32 0, i32 6, i32 0, i32 4 }, %struct.anon.1.554 { i32 1, i32 11, i32 1, i32 0, i32 5, i32 1 }, %struct.anon.1.554 { i32 1, i32 12, i32 0, i32 2, i32 0, i32 -6 }, %struct.anon.1.554 { i32 2, i32 7, i32 1, i32 1, i32 4, i32 1 }, %struct.anon.1.554 { i32 2, i32 8, i32 0, i32 3, i32 6, i32 2 }, %struct.anon.1.554 { i32 2, i32 9, i32 0, i32 1, i32 0, i32 4 }, %struct.anon.1.554 { i32 2, i32 10, i32 0, i32 9, i32 0, i32 3 }, %struct.anon.1.554 { i32 2, i32 11, i32 1, i32 1, i32 6, i32 1 }, %struct.anon.1.554 { i32 2, i32 12, i32 1, i32 1, i32 7, i32 1 }, %struct.anon.1.554 { i32 3, i32 7, i32 1, i32 0, i32 4, i32 1 }, %struct.anon.1.554 { i32 3, i32 8, i32 0, i32 2, i32 6, i32 2 }, %struct.anon.1.554 { i32 3, i32 9, i32 0, i32 0, i32 0, i32 4 }, %struct.anon.1.554 { i32 3, i32 10, i32 0, i32 8, i32 0, i32 3 }, %struct.anon.1.554 { i32 3, i32 11, i32 1, i32 0, i32 6, i32 1 }, %struct.anon.1.554 { i32 3, i32 12, i32 1, i32 0, i32 7, i32 1 }]

define void @sample_set() {
entry:
  call void @sample_list_reposition()
  ret void
}

define internal void @sample_list_reposition() {
entry:
  call void @sample_adlibconfig_dialog(ptr null, i64 0)
  ret void
}

define internal void @sample_adlibconfig_dialog(ptr %a, i64 %idxprom3) {
entry:
  %arrayidx4 = getelementptr [26 x %struct.anon.1.554], ptr @adlibconfig_widgets, i64 0, i64 %idxprom3
  %nbits = getelementptr %struct.anon.1.554, ptr %arrayidx4, i32 0, i32 5
  %0 = load i32, ptr %nbits, align 4
  %cmp5 = icmp slt i32 %0, 0
  br i1 %cmp5, label %cond.true, label %sw.bb

cond.true:                                        ; preds = %entry
  %1 = load i32, ptr %a, align 4
  br label %sw.bb

sw.bb:                                            ; preds = %cond.true, %entry
  ret void
}
