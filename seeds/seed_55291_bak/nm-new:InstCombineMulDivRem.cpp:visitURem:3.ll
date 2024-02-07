target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.line_head = type { i64, i16, i64, i8, i8, i8, i32, i8, i8, ptr }

declare ptr @bfd_alloc()

declare i1 @read_section()

define internal i1 @comp_unit_maybe_decode_line_info() {
if.end6:
  %call1 = call ptr @decode_line_info(ptr undef, ptr undef, i8 undef, ptr undef, i32 undef)
  ret i1 false
}

define internal ptr @decode_line_info(ptr %lh, ptr %line_range278, i8 %0, ptr %line, i32 %1) {
entry:
  %lh1 = alloca %struct.line_head, align 8
  %adj_opcode = alloca i8, align 1
  %line2 = alloca i32, align 4
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.end7

if.end7:                                          ; preds = %if.end
  br label %if.end13

if.end13:                                         ; preds = %if.end7
  br label %if.else

if.else:                                          ; preds = %if.end13
  br label %if.end37

if.end37:                                         ; preds = %if.else
  br label %if.end38

if.end38:                                         ; preds = %if.end37
  br label %if.end48

if.end48:                                         ; preds = %if.end38
  br label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end48
  br label %if.end65

if.end65:                                         ; preds = %lor.lhs.false
  br label %cond.true

cond.true:                                        ; preds = %if.end65
  br label %cond.end

cond.end:                                         ; preds = %cond.true
  br label %if.end82

if.end82:                                         ; preds = %cond.end
  br label %if.end95

if.end95:                                         ; preds = %if.end82
  br label %if.then98

if.then98:                                        ; preds = %if.end95
  br label %if.end104

if.end104:                                        ; preds = %if.then98
  br label %if.then111

if.then111:                                       ; preds = %if.end104
  br label %if.end116

if.end116:                                        ; preds = %if.then111
  br label %if.end123

if.end123:                                        ; preds = %if.end116
  br label %if.end139

if.end139:                                        ; preds = %if.end123
  br label %for.cond

for.cond:                                         ; preds = %if.end139
  br label %for.end

for.end:                                          ; preds = %for.cond
  br label %if.end157

if.end157:                                        ; preds = %for.end
  br label %if.else171

if.else171:                                       ; preds = %if.end157
  br label %while.cond

while.cond:                                       ; preds = %if.else171
  br label %while.end

while.end:                                        ; preds = %while.cond
  br label %while.cond178

while.cond178:                                    ; preds = %while.end
  br label %while.end192

while.end192:                                     ; preds = %while.cond178
  br label %if.end194

if.end194:                                        ; preds = %while.end192
  br label %while.cond195

while.cond195:                                    ; preds = %if.end194
  br label %while.body198

while.body198:                                    ; preds = %while.cond195
  br label %if.end214

if.end214:                                        ; preds = %while.body198
  br label %while.cond215

while.cond215:                                    ; preds = %if.end214
  br label %land.end

land.end:                                         ; preds = %while.cond215
  br label %while.body219

while.body219:                                    ; preds = %land.end
  br label %if.then227

if.then227:                                       ; preds = %while.body219
  br label %if.end238

if.end238:                                        ; preds = %if.then227
  br label %if.then243

if.then243:                                       ; preds = %if.end238
  br label %if.end275

if.end275:                                        ; preds = %if.then243
  %2 = load i32, ptr undef, align 4
  %3 = load i8, ptr undef, align 1
  %conv277 = zext i8 1 to i32
  %line_range2783 = getelementptr inbounds %struct.line_head, ptr %lh, i32 0, i32 7
  %4 = load i8, ptr %lh, align 8
  %conv279 = zext i8 %0 to i32
  %rem280 = srem i32 1, %conv279
  %add281 = add nsw i32 0, 1
  %5 = load i32, ptr %lh, align 4
  %add282 = add i32 %1, 0
  store i32 %rem280, ptr %lh, align 4
  ret ptr null
}

declare i32 @read_1_byte()

declare i32 @read_4_bytes()

declare i32 @read_2_bytes()

declare ptr @read_string()

declare i32 @read_1_signed_byte()

declare i1 @add_line_info()

define i32 @_bfd_dwarf2_find_nearest_line_with_alt() {
land.rhs200:
  %call201 = call i1 @comp_unit_find_line()
  ret i32 0
}

define internal i1 @comp_unit_find_line() {
entry:
  %call = call i1 @comp_unit_maybe_decode_line_info()
  ret i1 false
}
