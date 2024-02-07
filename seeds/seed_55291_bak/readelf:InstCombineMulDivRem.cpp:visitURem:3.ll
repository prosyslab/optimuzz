target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.dwarf_section_display = type { %struct.dwarf_section, ptr, ptr, i8 }
%struct.dwarf_section = type { ptr, ptr, ptr, ptr, ptr, ptr, i64, i64, i32, ptr, i64 }
%struct.State_Machine_Registers = type { i64, i32, i32, i32, i32, i32, i32, i8, i8, i32 }
%struct.DWARF2_Internal_LineInfo = type { i64, i16, i8, i8, i64, i8, i8, i8, i8, i8, i8, i32 }

@debug_displays = global [47 x %struct.dwarf_section_display] [%struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr @display_debug_lines, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr null, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr null, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr null, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 27, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 30, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 30, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr @display_debug_lines, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 1 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr undef, i8 0 }, %struct.dwarf_section_display { %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, ptr undef, ptr null, i8 0 }]
@state_machine_regs = external dso_local global %struct.State_Machine_Registers

declare ptr @gettext()

declare i32 @strcmp()

declare i32 @printf(...)

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

define internal i32 @display_debug_lines() {
if.then1:
  %call1 = call i32 @display_debug_lines_raw(ptr undef, ptr undef, i8 undef, ptr undef, i32 undef, i32 undef, ptr undef)
  ret i32 0
}

declare void @introduce()

declare i1 @startswith.6827()

define internal i32 @display_debug_lines_raw(ptr %linfo, ptr %li_line_range328, i8 %0, ptr %adv, i32 %1, i32 %add334, ptr %2) {
entry:
  %linfo1 = alloca %struct.DWARF2_Internal_LineInfo, align 8
  %op_code = alloca i8, align 1
  %adv2 = alloca i32, align 4
  br label %while.cond

while.cond:                                       ; preds = %entry
  br label %while.body

while.body:                                       ; preds = %while.cond
  br label %land.lhs.true

land.lhs.true:                                    ; preds = %while.body
  br label %if.then

if.then:                                          ; preds = %land.lhs.true
  br label %if.end

if.end:                                           ; preds = %if.then
  br label %if.end245

if.end245:                                        ; preds = %if.end
  br label %if.else251

if.else251:                                       ; preds = %if.end245
  br label %while.cond254

while.cond254:                                    ; preds = %if.else251
  br label %while.body257

while.body257:                                    ; preds = %while.cond254
  br label %if.then268

if.then268:                                       ; preds = %while.body257
  br label %if.then282

if.then282:                                       ; preds = %if.then268
  br label %if.end286

if.end286:                                        ; preds = %if.then282
  br label %cond.false

cond.false:                                       ; preds = %if.end286
  br label %cond.end

cond.end:                                         ; preds = %cond.false
  br label %if.end326

if.end326:                                        ; preds = %cond.end
  %3 = load i8, ptr undef, align 1
  %conv327 = zext i8 1 to i32
  %li_line_range3283 = getelementptr inbounds %struct.DWARF2_Internal_LineInfo, ptr %linfo, i32 0, i32 9
  %4 = load i8, ptr %linfo, align 4
  %conv329 = zext i8 %0 to i32
  %rem330 = srem i32 1, %conv329
  %conv332 = sext i8 0 to i32
  %add333 = add nsw i32 1, 0
  store i32 %rem330, ptr %linfo, align 4
  %5 = load i32, ptr %linfo, align 4
  %6 = load i32, ptr undef, align 8
  %add3344 = add i32 0, %1
  store i32 %1, ptr %linfo, align 8
  ret i32 0
}

declare void @reset_state_machine()

; uselistorder directives
uselistorder ptr undef, { 0, 1, 2, 3, 4, 5, 19, 20, 12, 7, 8, 16, 21, 10, 11, 9, 22, 6, 17, 23, 18, 24, 13, 14, 15 }
uselistorder %struct.dwarf_section { ptr undef, ptr undef, ptr undef, ptr null, ptr null, ptr null, i64 0, i64 0, i32 0, ptr null, i64 0 }, { 1, 0, 2, 3 }
uselistorder i8 1, { 0, 2, 3, 1, 4 }

attributes #0 = { argmemonly nofree nounwind willreturn }
