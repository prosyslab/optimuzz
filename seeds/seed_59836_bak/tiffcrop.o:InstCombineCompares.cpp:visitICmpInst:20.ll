target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end137:                                        ; No predecessors!
  %call147 = call i32 @loadImage()
  unreachable
}

define internal i32 @loadImage() {
entry:
  ret i32 0

sw.bb248:                                         ; No predecessors!
  %call258 = call i32 @readSeparateTilesIntoBuffer()
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %sw.bb248
  br label %for.cond
}

define internal i32 @readSeparateTilesIntoBuffer() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

for.cond30:                                       ; preds = %sw.bb132, %if.then110, %if.then110, %if.then110, %if.then110, %for.cond30
  br label %for.cond30

if.then110:                                       ; No predecessors!
  switch i32 0, label %for.cond30 [
    i32 1, label %for.cond30
    i32 2, label %for.cond30
    i32 3, label %for.cond30
    i32 4, label %sw.bb132
    i32 5, label %sw.bb132
    i32 6, label %sw.bb132
    i32 7, label %sw.bb132
    i32 0, label %sw.bb132
  ]

sw.bb132:                                         ; preds = %if.then110, %if.then110, %if.then110, %if.then110, %if.then110
  %call134 = call i32 @combineSeparateTileSamples32bits()
  br label %for.cond30
}

define internal i32 @combineSeparateTileSamples32bits() {
entry:
  ret i32 0

for.cond13:                                       ; No predecessors!
  br label %for.cond24

for.cond24:                                       ; preds = %for.cond24, %for.cond13
  %call1091 = call i32 @dump_wide(ptr null, i32 0)
  br label %for.cond24
}

define internal i32 @dump_wide(ptr %k, i32 %0) {
entry:
  br label %for.cond

for.cond:                                         ; preds = %if.then10, %for.cond, %entry
  %rem = srem i32 %0, 8
  %cmp8 = icmp eq i32 %rem, 0
  br i1 %cmp8, label %if.then10, label %for.cond

if.then10:                                        ; preds = %for.cond
  %1 = load i32, ptr %k, align 4
  br label %for.cond
}
