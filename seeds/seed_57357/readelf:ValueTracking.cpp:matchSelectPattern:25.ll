target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.ctf_funcinfo = type { i64, i32, i32 }

define i32 @ctf_func_type_args(ptr %argc.addr) {
entry:
  %argc.addr1 = alloca i32, align 4
  %f = alloca %struct.ctf_funcinfo, align 8
  %0 = load i32, ptr %argc.addr1, align 4
  %ctc_argc = getelementptr inbounds %struct.ctf_funcinfo, ptr %f, i64 0, i32 1
  %1 = load i32, ptr %ctc_argc, align 8
  %cmp14 = icmp ult i32 %0, %1
  %2 = load i32, ptr %argc.addr1, align 4
  %ctc_argc15 = getelementptr inbounds %struct.ctf_funcinfo, ptr %f, i64 0, i32 1
  %3 = load i32, ptr %ctc_argc15, align 8
  %cond = select i1 %cmp14, i32 %2, i32 %3
  store i32 %cond, ptr %argc.addr, align 4
  ret i32 0
}
