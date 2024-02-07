target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str.45 = external dso_local constant [6 x i8]
@.str.351 = external dso_local constant [11 x i8]

declare i32 @printf(ptr, ...)

declare i64 @strlen()

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

define i32 @main() {
if.then337:
  call void @display_file()
  ret i32 0
}

define internal void @display_file() {
if.end4:
  call void @display_any_bfd()
  ret void
}

define internal void @display_any_bfd() {
if.else37:
  call void @display_object_bfd()
  ret void
}

define internal void @display_object_bfd() {
if.then:
  call void @dump_bfd()
  ret void
}

define internal void @dump_bfd() {
if.then179:
  call void @disassemble_data()
  ret void
}

define internal void @disassemble_data() {
if.end77:
  call void undef(ptr null, ptr @disassemble_section, ptr null)
  ret void
}

define internal void @disassemble_section() {
if.end411:
  call void @disassemble_bytes()
  ret void
}

define internal void @disassemble_bytes() {
if.end495:
  call void @print_jump_visualisation(ptr undef, i8 undef)
  ret void
}

define internal void @print_jump_visualisation(ptr %color, i8 %0) {
entry:
  %color1 = alloca i8, align 1
  br label %if.end

if.end:                                           ; preds = %entry
  br label %for.cond

for.cond:                                         ; preds = %if.end
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %if.then2

if.then2:                                         ; preds = %for.body
  br label %cond.true

cond.true:                                        ; preds = %if.then2
  br label %cond.end

cond.end:                                         ; preds = %cond.true
  br label %if.then9

if.then9:                                         ; preds = %cond.end
  br label %if.then11

if.then11:                                        ; preds = %if.then9
  br label %if.then13

if.then13:                                        ; preds = %if.then11
  %1 = load i8, ptr %color, align 1
  %conv14 = zext i8 %0 to i32
  %rem = srem i32 %conv14, 108
  %add = add nsw i32 0, 108
  %call15 = call i32 (ptr, ...) @printf(ptr null, i32 %rem)
  ret void
}

declare void @jump_info_visualize_address()

attributes #0 = { argmemonly nofree nounwind willreturn }
