target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.tagname = type { i16, ptr }

@tagnames = external constant [93 x %struct.tagname]

define i32 @main() {
entry:
  br label %sw.bb6

sw.bb6:                                           ; preds = %sw.bb6, %entry
  br label %sw.bb6

if.then22:                                        ; No predecessors!
  call void @dump()
  ret i32 0
}

define internal void @dump() {
entry:
  br label %for.cond81

for.cond81:                                       ; preds = %cond.true, %for.cond81, %entry
  br label %for.cond81

cond.true:                                        ; No predecessors!
  %call118 = call i64 @ReadDirectory()
  br label %for.cond81
}

define internal i64 @ReadDirectory() {
entry:
  ret i64 0

sw.epilog:                                        ; preds = %sw.epilog
  call void @PrintTag(ptr null)
  br label %sw.epilog
}

define internal void @PrintTag(ptr %tp) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  %cmp = icmp ult ptr %tp, getelementptr inbounds ([93 x %struct.tagname], ptr @tagnames, i64 1, i64 0)
  br i1 %cmp, label %for.cond, label %for.end

for.end:                                          ; preds = %for.cond
  ret void
}
