target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @re_search_internal() {
entry:
  br label %return

if.end181:                                        ; No predecessors!
  switch i32 0, label %for.cond266 [
    i32 8, label %return
    i32 1, label %while.cond
    i32 6, label %while.cond193
    i32 4, label %return
    i32 0, label %return
  ]

while.cond:                                       ; preds = %while.cond, %if.end181
  br label %while.cond

while.cond193:                                    ; preds = %while.cond193, %if.end181
  br label %while.cond193

for.cond266:                                      ; preds = %if.end181
  %call2761 = call i32 @re_string_reconstruct(ptr null, ptr null, i64 0, ptr null)
  br label %return

return:                                           ; preds = %for.cond266, %if.end181, %if.end181, %if.end181, %entry
  ret i32 0
}

define internal i32 @re_string_reconstruct(ptr %pstr.addr, ptr %0, i64 %1, ptr %raw) {
entry:
  %add.ptr203 = getelementptr i8, ptr %0, i64 %1
  store ptr %add.ptr203, ptr %raw, align 8
  %2 = load ptr, ptr %raw, align 8
  %cmp209 = icmp ult ptr %2, %pstr.addr
  br i1 %cmp209, label %if.then211, label %if.end213

if.then211:                                       ; preds = %entry
  %3 = load ptr, ptr %pstr.addr, align 8
  br label %if.end213

if.end213:                                        ; preds = %if.then211, %entry
  ret i32 0
}

define internal i64 @re_search_stub() {
entry:
  br label %return

land.rhs:                                         ; No predecessors!
  %call96 = call i32 @re_search_internal()
  br label %return

return:                                           ; preds = %land.rhs, %entry
  ret i64 0
}

define i64 @rpl_re_search() {
entry:
  %call = call i64 @re_search_stub()
  ret i64 0
}
