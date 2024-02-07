target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define i32 @main() {
for.body104:
  %call108 = call i1 @head_file()
  ret i32 0
}

define internal i1 @head_file() {
if.end10:
  %call13 = call i1 @head()
  ret i1 false
}

define internal i1 @head() {
if.else:
  %call20 = call i1 @elide_tail_bytes_file()
  ret i1 false
}

define internal i1 @elide_tail_bytes_file() {
if.then:
  %call1 = call i1 @elide_tail_bytes_pipe(ptr undef, i64 undef, ptr undef, ptr undef, i64 undef, i64 undef, i64 undef)
  ret i1 false
}

declare void @xwrite_stdout()

define internal i1 @elide_tail_bytes_pipe(ptr %n_elide, i64 %0, ptr %rem, ptr %desired_pos, i64 %1, i64 %2, i64 %add115) {
entry:
  %n_elide1 = alloca i64, align 8
  %desired_pos2 = alloca i64, align 8
  %rem3 = alloca i64, align 8
  br label %if.end

if.end:                                           ; preds = %entry
  br label %if.else51

if.else51:                                        ; preds = %if.end
  %3 = load i64, ptr %n_elide, align 8
  %rem56 = urem i64 %0, 8192
  %sub57 = sub i64 0, 8192
  store i64 %rem56, ptr %n_elide, align 8
  br label %for.cond60

for.cond60:                                       ; preds = %if.else51
  br label %for.end109

for.end109:                                       ; preds = %for.cond60
  br label %if.then111

if.then111:                                       ; preds = %for.end109
  br label %if.then113

if.then113:                                       ; preds = %if.then111
  %4 = load i64, ptr %n_elide, align 8
  %5 = load i64, ptr %n_elide, align 8
  %add1154 = add i64 %0, %0
  store i64 %0, ptr %n_elide, align 8
  ret i1 false
}
