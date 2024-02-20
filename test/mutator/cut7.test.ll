define i1 @0(ptr %val0, i64 %val1, i64 %0, i64 %1) {
entry:
  %val2 = alloca i64, align 8
  br label %do.body
do.body:                                          ; preds = %entry
  br label %if.end
if.end:                                           ; preds = %do.body
  br label %do.end
do.end:                                           ; preds = %if.end
  br label %while.cond
while.cond:                                       ; preds = %do.end
  br label %while.body
while.body:                                    ; preds = %while.cond
  br label %for.cond
for.cond:                                         ; preds = %while.body
  br label %do.body7
do.body7:                                         ; preds = %for.cond
  %val3 = load i64, ptr %val0, align 8
  %val4 = urem i64 %val1, 32
  %val5 = icmp eq i64 %val4, %1
  br i1 %val5, label %if.then24, label %if.end34
if.then24:                                        ; preds = %do.body7
  %2 = srem i64 %0, %val1
  ret i1 %val5
if.end34:                                         ; preds = %do.body7
  ret i1 %val5
}

