target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@compression = external dso_local global i16

define i32 @main() {
if.end204:
  %call2051 = call i32 @writeCroppedImage(ptr undef, i16 undef)
  ret i32 0
}

define internal i32 @writeCroppedImage(ptr %bps, i16 %0) {
entry:
  %bps1 = alloca i16, align 2
  br label %if.then

if.then:                                          ; preds = %entry
  br label %if.end22

if.end22:                                         ; preds = %if.then
  br label %if.then26

if.then26:                                        ; preds = %if.end22
  br label %lor.lhs.false

lor.lhs.false:                                    ; preds = %if.then26
  br label %if.end37

if.end37:                                         ; preds = %lor.lhs.false
  br label %if.else45

if.else45:                                        ; preds = %if.end37
  br label %if.end48

if.end48:                                         ; preds = %if.else45
  br label %if.end83

if.end83:                                         ; preds = %if.end48
  br label %lor.lhs.false87

lor.lhs.false87:                                  ; preds = %if.end83
  br label %if.end100

if.end100:                                        ; preds = %lor.lhs.false87
  br label %if.then104

if.then104:                                       ; preds = %if.end100
  br label %if.end108

if.end108:                                        ; preds = %if.then104
  br label %if.end115

if.end115:                                        ; preds = %if.end108
  br label %if.then117

if.then117:                                       ; preds = %if.end115
  br label %if.end122

if.end122:                                        ; preds = %if.then117
  br label %if.end127

if.end127:                                        ; preds = %if.end122
  br label %lor.lhs.false130

lor.lhs.false130:                                 ; preds = %if.end127
  br label %if.end134

if.end134:                                        ; preds = %lor.lhs.false130
  br label %if.end162

if.end162:                                        ; preds = %if.end134
  br label %if.then167

if.then167:                                       ; preds = %if.end162
  br label %if.end177

if.end177:                                        ; preds = %if.then167
  br label %if.end182

if.end182:                                        ; preds = %if.end177
  switch i32 0, label %sw.default [
    i32 0, label %sw.bb
  ]

sw.bb:                                            ; preds = %if.end182
  %1 = load i16, ptr %bps, align 2
  %conv184 = zext i16 %0 to i32
  %rem = srem i32 %conv184, 8
  %cmp185 = icmp eq i32 %rem, 0
  br i1 %cmp185, label %if.then192, label %lor.lhs.false187

lor.lhs.false187:                                 ; preds = %sw.bb
  %2 = load i16, ptr undef, align 2
  br label %if.then192

if.then192:                                       ; preds = %lor.lhs.false187, %sw.bb
  ret i32 0

sw.default:                                       ; preds = %if.end182
  ret i32 0
}

declare i32 @TIFFSetField(...)

declare void @cpTag()

declare i32 @TIFFGetFieldDefaulted(...)
