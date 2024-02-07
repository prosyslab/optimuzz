target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.5645 = private constant [5 x i8] c"*$!+\00"

define i32 @main() {
entry:
  %call9 = call i1 @process_file()
  ret i32 0
}

define internal i1 @process_file() {
entry:
  br label %return

if.then50:                                        ; No predecessors!
  %call54 = call i1 @process_object()
  br label %return

return:                                           ; preds = %if.then50, %entry
  ret i1 false
}

define internal i1 @process_object() {
entry:
  br label %for.cond

for.cond:                                         ; preds = %for.cond, %entry
  br label %for.cond

if.then10:                                        ; No predecessors!
  br label %for.cond59

for.cond59:                                       ; preds = %for.cond59, %if.then10
  %call110 = call i1 @process_notes()
  br label %for.cond59
}

define internal i1 @process_notes() {
entry:
  %call = call i1 @process_note_sections()
  ret i1 false
}

define internal i1 @process_note_sections() {
entry:
  %call = call i1 @process_notes_at()
  ret i1 false
}

define internal i1 @process_notes_at() {
entry:
  br label %return

if.end194:                                        ; No predecessors!
  %call2031 = call i1 @process_note(ptr null, i32 0)
  br label %return

return:                                           ; preds = %if.end194, %entry
  ret i1 false
}

define internal i1 @process_note(ptr %pnote.addr, i32 %conv92) {
entry:
  %call93 = call ptr @strchr(ptr @.str.5645, i32 %conv92)
  %cmp94 = icmp ne ptr %call93, null
  br i1 %cmp94, label %land.lhs.true102, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %0 = load ptr, ptr %pnote.addr, align 8
  br label %land.lhs.true102

land.lhs.true102:                                 ; preds = %lor.lhs.false, %entry
  ret i1 false
}

declare ptr @strchr(ptr, i32)
