target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

define internal i32 @display_debug_names(ptr %augmentation_string_size, i32 %0) {
entry:
  %augmentation_string_size1 = alloca i32, align 4
  br label %for.cond

for.cond:                                         ; preds = %entry
  br label %for.body

for.body:                                         ; preds = %for.cond
  br label %do.body

do.body:                                          ; preds = %for.body
  br label %if.end

if.end:                                           ; preds = %do.body
  br label %if.end7

if.end7:                                          ; preds = %if.end
  br label %if.end11

if.end11:                                         ; preds = %if.end7
  br label %if.then14

if.then14:                                        ; preds = %if.end11
  br label %if.end17

if.end17:                                         ; preds = %if.then14
  br label %do.end

do.end:                                           ; preds = %if.end17
  br label %if.else51

if.else51:                                        ; preds = %do.end
  br label %if.end52

if.end52:                                         ; preds = %if.else51
  br label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.end52
  br label %if.end66

if.end66:                                         ; preds = %lor.lhs.false
  br label %do.body68

do.body68:                                        ; preds = %if.end66
  br label %if.end75

if.end75:                                         ; preds = %do.body68
  br label %if.end83

if.end83:                                         ; preds = %if.end75
  br label %if.end87

if.end87:                                         ; preds = %if.end83
  br label %if.else91

if.else91:                                        ; preds = %if.end87
  br label %if.end95

if.end95:                                         ; preds = %if.else91
  br label %do.end97

do.end97:                                         ; preds = %if.end95
  br label %if.end106

if.end106:                                        ; preds = %do.end97
  br label %do.body107

do.body107:                                       ; preds = %if.end106
  br label %if.end114

if.end114:                                        ; preds = %do.body107
  br label %if.end122

if.end122:                                        ; preds = %if.end114
  br label %if.end126

if.end126:                                        ; preds = %if.end122
  br label %if.then129

if.then129:                                       ; preds = %if.end126
  br label %if.end134

if.end134:                                        ; preds = %if.then129
  br label %do.end136

do.end136:                                        ; preds = %if.end134
  br label %if.end143

if.end143:                                        ; preds = %do.end136
  br label %do.body144

do.body144:                                       ; preds = %if.end143
  br label %if.end151

if.end151:                                        ; preds = %do.body144
  br label %if.end159

if.end159:                                        ; preds = %if.end151
  br label %if.end163

if.end163:                                        ; preds = %if.end159
  br label %if.then166

if.then166:                                       ; preds = %if.end163
  br label %if.end171

if.end171:                                        ; preds = %if.then166
  br label %do.end173

do.end173:                                        ; preds = %if.end171
  br label %if.end178

if.end178:                                        ; preds = %do.end173
  br label %do.body179

do.body179:                                       ; preds = %if.end178
  br label %if.end186

if.end186:                                        ; preds = %do.body179
  br label %if.end194

if.end194:                                        ; preds = %if.end186
  br label %if.end198

if.end198:                                        ; preds = %if.end194
  br label %if.else202

if.else202:                                       ; preds = %if.end198
  br label %if.end206

if.end206:                                        ; preds = %if.else202
  br label %do.end208

do.end208:                                        ; preds = %if.end206
  br label %do.body209

do.body209:                                       ; preds = %do.end208
  br label %if.end216

if.end216:                                        ; preds = %do.body209
  br label %if.end224

if.end224:                                        ; preds = %if.end216
  br label %if.end228

if.end228:                                        ; preds = %if.end224
  br label %if.else232

if.else232:                                       ; preds = %if.end228
  br label %if.end236

if.end236:                                        ; preds = %if.else232
  br label %do.end238

do.end238:                                        ; preds = %if.end236
  br label %do.body239

do.body239:                                       ; preds = %do.end238
  br label %if.end246

if.end246:                                        ; preds = %do.body239
  br label %if.end254

if.end254:                                        ; preds = %if.end246
  br label %if.end258

if.end258:                                        ; preds = %if.end254
  br label %if.then261

if.then261:                                       ; preds = %if.end258
  br label %if.end265

if.end265:                                        ; preds = %if.then261
  br label %do.end267

do.end267:                                        ; preds = %if.end265
  br label %do.body268

do.body268:                                       ; preds = %do.end267
  br label %if.end275

if.end275:                                        ; preds = %do.body268
  br label %if.end283

if.end283:                                        ; preds = %if.end275
  br label %if.end287

if.end287:                                        ; preds = %if.end283
  br label %if.then290

if.then290:                                       ; preds = %if.end287
  br label %if.end294

if.end294:                                        ; preds = %if.then290
  br label %do.end296

do.end296:                                        ; preds = %if.end294
  br label %do.body297

do.body297:                                       ; preds = %do.end296
  br label %if.end304

if.end304:                                        ; preds = %do.body297
  br label %if.end312

if.end312:                                        ; preds = %if.end304
  br label %if.end316

if.end316:                                        ; preds = %if.end312
  br label %if.then319

if.then319:                                       ; preds = %if.end316
  br label %if.end323

if.end323:                                        ; preds = %if.then319
  br label %do.end325

do.end325:                                        ; preds = %if.end323
  br label %do.body326

do.body326:                                       ; preds = %do.end325
  br label %if.end333

if.end333:                                        ; preds = %do.body326
  br label %if.end341

if.end341:                                        ; preds = %if.end333
  br label %if.end345

if.end345:                                        ; preds = %if.end341
  br label %if.then348

if.then348:                                       ; preds = %if.end345
  br label %if.end353

if.end353:                                        ; preds = %if.then348
  br label %do.end355

do.end355:                                        ; preds = %if.end353
  %1 = load i32, ptr %augmentation_string_size, align 4
  %rem = urem i32 %0, 4
  %cmp356 = icmp ne i32 %rem, 0
  br i1 %cmp356, label %if.then358, label %if.end360

if.then358:                                       ; preds = %do.end355
  br label %if.end360

if.end360:                                        ; preds = %if.then358, %do.end355
  ret i32 0
}
