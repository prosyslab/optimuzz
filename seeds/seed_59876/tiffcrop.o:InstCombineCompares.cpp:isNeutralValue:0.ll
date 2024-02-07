target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
entry:
  ret i32 0

if.end229:                                        ; No predecessors!
  %call231 = call i32 @writeImageSections()
  unreachable
}

define internal i32 @writeImageSections() {
entry:
  ret i32 0

if.end27:                                         ; No predecessors!
  %call28 = call i32 @writeSingleSection()
  unreachable
}

define internal i32 @writeSingleSection() {
entry:
  br label %return

if.then276:                                       ; No predecessors!
  %call2771 = call i32 @writeBufferToContigTiles(ptr null, i32 0)
  br label %return

return:                                           ; preds = %if.then276, %entry
  ret i32 0
}

define internal i32 @writeBufferToContigTiles(ptr %bps, i32 %conv32) {
entry:
  %div35 = udiv i32 -1, %conv32
  %cmp36 = icmp ugt i32 %conv32, %div35
  br i1 %cmp36, label %if.then45, label %lor.lhs.false38

lor.lhs.false38:                                  ; preds = %entry
  %0 = load i16, ptr %bps, align 2
  br label %if.then45

if.then45:                                        ; preds = %lor.lhs.false38, %entry
  ret i32 0
}
