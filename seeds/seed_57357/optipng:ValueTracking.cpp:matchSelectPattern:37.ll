target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.config_s = type { i16, i16, i16, i16, ptr }

@configuration_table = internal constant [10 x %struct.config_s] [%struct.config_s { i16 0, i16 0, i16 0, i16 0, ptr @deflate_stored }, %struct.config_s { i16 4, i16 4, i16 8, i16 4, ptr null }, %struct.config_s { i16 4, i16 5, i16 16, i16 8, ptr null }, %struct.config_s { i16 4, i16 6, i16 32, i16 32, ptr null }, %struct.config_s { i16 4, i16 4, i16 16, i16 16, ptr null }, %struct.config_s { i16 8, i16 16, i16 32, i16 32, ptr null }, %struct.config_s { i16 8, i16 16, i16 128, i16 128, ptr null }, %struct.config_s { i16 8, i16 32, i16 128, i16 256, ptr null }, %struct.config_s { i16 32, i16 128, i16 258, i16 1024, ptr null }, %struct.config_s { i16 32, i16 258, i16 258, i16 4096, ptr null }]

define i32 @deflateReset() {
entry:
  call void @lm_init()
  ret i32 0
}

define internal void @lm_init() {
entry:
  %arrayidx7 = getelementptr inbounds [10 x %struct.config_s], ptr @configuration_table, i64 0, i64 0
  ret void
}

define internal i32 @deflate_stored() {
entry:
  %len = alloca i32, align 4
  %left = alloca i32, align 4
  %0 = load i32, ptr %left, align 4
  %cmp340 = icmp ugt i32 %0, 0
  %cond345 = select i1 %cmp340, i32 1, i32 0
  store i32 %cond345, ptr %len, align 4
  ret i32 0
}

; uselistorder directives
uselistorder ptr null, { 5, 4, 3, 2, 1, 0, 8, 7, 6 }
