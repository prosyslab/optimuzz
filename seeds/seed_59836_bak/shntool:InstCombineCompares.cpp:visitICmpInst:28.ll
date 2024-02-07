target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._mode_module = type { ptr, ptr, ptr, ptr, i32, ptr, ptr }

@mode_split = global %struct._mode_module { ptr null, ptr null, ptr null, ptr null, i32 1, ptr @split_main, ptr null }

define internal i32 @split_main() {
entry:
  %call = call i32 @process.599()
  ret i32 0
}

define internal i32 @process.599() {
entry:
  %call1 = call i32 @process_file.601()
  ret i32 0
}

define internal i32 @process_file.601() {
entry:
  br label %for.cond

if.else:                                          ; No predecessors!
  call void @read_split_points_file()
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %if.else, %entry
  br label %for.cond
}

define internal void @read_split_points_file() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then9:                                         ; No predecessors!
  %call17 = call i32 @get_length_token()
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %if.then9
  br label %while.cond
}

define internal i32 @get_length_token() {
entry:
  br label %return

if.end:                                           ; No predecessors!
  switch i32 0, label %return [
    i32 0, label %return
    i32 1, label %return
    i32 2, label %sw.bb87
  ]

sw.bb87:                                          ; preds = %if.end
  call void @extract(ptr null, ptr null)
  br label %return

return:                                           ; preds = %sw.bb87, %if.end, %if.end, %if.end, %entry
  ret i32 0
}

define internal void @extract(ptr %data.addr, ptr %.pn) {
entry:
  br label %while.cond

while.cond:                                       ; preds = %while.cond, %entry
  %storemerge = getelementptr i8, ptr %.pn, i64 -1
  %cmp9.not = icmp ult ptr %storemerge, %data.addr
  br i1 %cmp9.not, label %while.cond, label %land.rhs

land.rhs:                                         ; preds = %while.cond
  ret void
}
