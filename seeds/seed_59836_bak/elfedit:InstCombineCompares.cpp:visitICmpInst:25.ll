target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.elf_internal_ehdr = type { [16 x i8], i64, i64, i64, i64, i64, i16, i16, i32, i32, i32, i32, i32, i32 }

@elf_header = external global %struct.elf_internal_ehdr

define i32 @main() {
entry:
  br label %sw.bb81

sw.bb81:                                          ; preds = %sw.bb81, %entry
  br label %sw.bb81

if.end99:                                         ; No predecessors!
  br label %while.cond100

while.cond100:                                    ; preds = %while.cond100, %if.end99
  %call1041 = call i32 @process_file(ptr null)
  br label %while.cond100
}

define internal i32 @process_file(ptr %file_name.addr) {
entry:
  %0 = load i16, ptr getelementptr inbounds (%struct.elf_internal_ehdr, ptr @elf_header, i32 0, i32 6), align 8
  %conv = zext i16 %0 to i32
  %cmp24 = icmp eq i32 %conv, 2
  br i1 %cmp24, label %if.then29, label %lor.lhs.false

lor.lhs.false:                                    ; preds = %entry
  %1 = load i16, ptr getelementptr inbounds (%struct.elf_internal_ehdr, ptr @elf_header, i32 0, i32 6), align 8
  %conv26 = zext i16 %1 to i32
  %cmp27 = icmp eq i32 %conv26, 3
  br i1 %cmp27, label %if.then29, label %if.end31

if.then29:                                        ; preds = %lor.lhs.false, %entry
  %2 = load ptr, ptr %file_name.addr, align 8
  br label %if.end31

if.end31:                                         ; preds = %if.then29, %lor.lhs.false
  ret i32 0
}
