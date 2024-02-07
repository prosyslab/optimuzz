target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: argmemonly nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #0

declare i64 @_ZNK7libzpaq5ArrayIcE4sizeEv()

declare ptr @_ZN7libzpaq5ArrayIcEixEm()

declare ptr @_ZN7libzpaq5ArrayIhEixEm()

define i32 @_ZN7libzpaq5ZPAQL8assembleEv(ptr %i660, i32 %0, ptr %hcomp, ptr %1, ptr %arrayidx1598, i8 %2, i32 %add1596) personality ptr undef {
entry:
  %hcomp1 = alloca ptr, align 8
  %i6602 = alloca i32, align 4
  br label %if.end

if.end:                                           ; preds = %entry
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %if.end
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont12 unwind label %lpad

invoke.cont12:                                    ; preds = %invoke.cont
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont17 unwind label %lpad

invoke.cont17:                                    ; preds = %invoke.cont12
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont20 unwind label %lpad

invoke.cont20:                                    ; preds = %invoke.cont17
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont23 unwind label %lpad

invoke.cont23:                                    ; preds = %invoke.cont20
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont27 unwind label %lpad

invoke.cont27:                                    ; preds = %invoke.cont23
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont33 unwind label %lpad

invoke.cont33:                                    ; preds = %invoke.cont27
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont36 unwind label %lpad

invoke.cont36:                                    ; preds = %invoke.cont33
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont39 unwind label %lpad

invoke.cont39:                                    ; preds = %invoke.cont36
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont43 unwind label %lpad

invoke.cont43:                                    ; preds = %invoke.cont39
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont49 unwind label %lpad

invoke.cont49:                                    ; preds = %invoke.cont43
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont52 unwind label %lpad

invoke.cont52:                                    ; preds = %invoke.cont49
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont55 unwind label %lpad

invoke.cont55:                                    ; preds = %invoke.cont52
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont59 unwind label %lpad

invoke.cont59:                                    ; preds = %invoke.cont55
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont65 unwind label %lpad

invoke.cont65:                                    ; preds = %invoke.cont59
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont68 unwind label %lpad

invoke.cont68:                                    ; preds = %invoke.cont65
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont71 unwind label %lpad

invoke.cont71:                                    ; preds = %invoke.cont68
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont75 unwind label %lpad

invoke.cont75:                                    ; preds = %invoke.cont71
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont81 unwind label %lpad

invoke.cont81:                                    ; preds = %invoke.cont75
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont84 unwind label %lpad

invoke.cont84:                                    ; preds = %invoke.cont81
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont87 unwind label %lpad

invoke.cont87:                                    ; preds = %invoke.cont84
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont90 unwind label %lpad

invoke.cont90:                                    ; preds = %invoke.cont87
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont93 unwind label %lpad

invoke.cont93:                                    ; preds = %invoke.cont90
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont96 unwind label %lpad

invoke.cont96:                                    ; preds = %invoke.cont93
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont99 unwind label %lpad

invoke.cont99:                                    ; preds = %invoke.cont96
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont102 unwind label %lpad

invoke.cont102:                                   ; preds = %invoke.cont99
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont105 unwind label %lpad

invoke.cont105:                                   ; preds = %invoke.cont102
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont108 unwind label %lpad

invoke.cont108:                                   ; preds = %invoke.cont105
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont111 unwind label %lpad

invoke.cont111:                                   ; preds = %invoke.cont108
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont114 unwind label %lpad

invoke.cont114:                                   ; preds = %invoke.cont111
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont117 unwind label %lpad

invoke.cont117:                                   ; preds = %invoke.cont114
  %call119 = invoke ptr @_ZN7libzpaq5ArrayIcEixEm(ptr null, i64 0)
          to label %invoke.cont118 unwind label %lpad

invoke.cont118:                                   ; preds = %invoke.cont117
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont123 unwind label %lpad

invoke.cont123:                                   ; preds = %invoke.cont118
  %call126 = invoke ptr @_ZN7libzpaq5ArrayIcEixEm(ptr null, i64 0)
          to label %invoke.cont125 unwind label %lpad

invoke.cont125:                                   ; preds = %invoke.cont123
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont131 unwind label %lpad

invoke.cont131:                                   ; preds = %invoke.cont125
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont134 unwind label %lpad

invoke.cont134:                                   ; preds = %invoke.cont131
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont138 unwind label %lpad

invoke.cont138:                                   ; preds = %invoke.cont134
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont144 unwind label %lpad

invoke.cont144:                                   ; preds = %invoke.cont138
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont147 unwind label %lpad

invoke.cont147:                                   ; preds = %invoke.cont144
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont150 unwind label %lpad

invoke.cont150:                                   ; preds = %invoke.cont147
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont153 unwind label %lpad

invoke.cont153:                                   ; preds = %invoke.cont150
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont156 unwind label %lpad

invoke.cont156:                                   ; preds = %invoke.cont153
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont159 unwind label %lpad

invoke.cont159:                                   ; preds = %invoke.cont156
  %call162 = invoke i64 @_ZNK7libzpaq5ArrayIcE4sizeEv(ptr null)
          to label %invoke.cont161 unwind label %lpad

invoke.cont161:                                   ; preds = %invoke.cont159
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont166 unwind label %lpad

invoke.cont166:                                   ; preds = %invoke.cont161
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont169 unwind label %lpad

invoke.cont169:                                   ; preds = %invoke.cont166
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont172 unwind label %lpad

invoke.cont172:                                   ; preds = %invoke.cont169
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont175 unwind label %lpad

invoke.cont175:                                   ; preds = %invoke.cont172
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont178 unwind label %lpad

invoke.cont178:                                   ; preds = %invoke.cont175
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont181 unwind label %lpad

invoke.cont181:                                   ; preds = %invoke.cont178
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont184 unwind label %lpad

invoke.cont184:                                   ; preds = %invoke.cont181
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont187 unwind label %lpad

invoke.cont187:                                   ; preds = %invoke.cont184
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont190 unwind label %lpad

invoke.cont190:                                   ; preds = %invoke.cont187
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont193 unwind label %lpad

invoke.cont193:                                   ; preds = %invoke.cont190
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont196 unwind label %lpad

invoke.cont196:                                   ; preds = %invoke.cont193
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont199 unwind label %lpad

invoke.cont199:                                   ; preds = %invoke.cont196
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont203 unwind label %lpad

invoke.cont203:                                   ; preds = %invoke.cont199
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont208 unwind label %lpad

invoke.cont208:                                   ; preds = %invoke.cont203
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont211 unwind label %lpad

invoke.cont211:                                   ; preds = %invoke.cont208
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont214 unwind label %lpad

invoke.cont214:                                   ; preds = %invoke.cont211
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont217 unwind label %lpad

invoke.cont217:                                   ; preds = %invoke.cont214
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont220 unwind label %lpad

invoke.cont220:                                   ; preds = %invoke.cont217
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont223 unwind label %lpad

invoke.cont223:                                   ; preds = %invoke.cont220
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont226 unwind label %lpad

invoke.cont226:                                   ; preds = %invoke.cont223
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont229 unwind label %lpad

invoke.cont229:                                   ; preds = %invoke.cont226
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont232 unwind label %lpad

invoke.cont232:                                   ; preds = %invoke.cont229
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont235 unwind label %lpad

invoke.cont235:                                   ; preds = %invoke.cont232
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont238 unwind label %lpad

invoke.cont238:                                   ; preds = %invoke.cont235
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont241 unwind label %lpad

invoke.cont241:                                   ; preds = %invoke.cont238
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont244 unwind label %lpad

invoke.cont244:                                   ; preds = %invoke.cont241
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont247 unwind label %lpad

invoke.cont247:                                   ; preds = %invoke.cont244
  %call249 = invoke ptr @_ZN7libzpaq5ArrayIiEixEm(ptr null, i64 0)
          to label %invoke.cont248 unwind label %lpad

invoke.cont248:                                   ; preds = %invoke.cont247
  br label %do.body

do.body:                                          ; preds = %do.cond, %invoke.cont248
  br label %for.cond

for.cond:                                         ; preds = %do.body
  br label %for.end

lpad:                                             ; preds = %invoke.cont734, %invoke.cont731, %if.then728, %cond.end, %if.else703, %for.body669, %invoke.cont650, %invoke.cont648, %invoke.cont643, %invoke.cont641, %invoke.cont638, %invoke.cont632, %invoke.cont630, %invoke.cont625, %invoke.cont624, %invoke.cont621, %invoke.cont615, %invoke.cont613, %invoke.cont608, %invoke.cont606, %invoke.cont603, %invoke.cont597, %invoke.cont595, %invoke.cont590, %invoke.cont588, %invoke.cont585, %invoke.cont582, %invoke.cont576, %invoke.cont571, %invoke.cont568, %invoke.cont565, %invoke.cont559, %invoke.cont554, %invoke.cont551, %invoke.cont548, %invoke.cont542, %invoke.cont537, %invoke.cont534, %invoke.cont531, %invoke.cont525, %invoke.cont520, %invoke.cont517, %invoke.cont514, %invoke.cont508, %invoke.cont503, %invoke.cont500, %invoke.cont497, %invoke.cont494, %invoke.cont491, %invoke.cont488, %invoke.cont485, %invoke.cont482, %invoke.cont479, %invoke.cont476, %for.end473, %invoke.cont247, %invoke.cont244, %invoke.cont241, %invoke.cont238, %invoke.cont235, %invoke.cont232, %invoke.cont229, %invoke.cont226, %invoke.cont223, %invoke.cont220, %invoke.cont217, %invoke.cont214, %invoke.cont211, %invoke.cont208, %invoke.cont203, %invoke.cont199, %invoke.cont196, %invoke.cont193, %invoke.cont190, %invoke.cont187, %invoke.cont184, %invoke.cont181, %invoke.cont178, %invoke.cont175, %invoke.cont172, %invoke.cont169, %invoke.cont166, %invoke.cont161, %invoke.cont159, %invoke.cont156, %invoke.cont153, %invoke.cont150, %invoke.cont147, %invoke.cont144, %invoke.cont138, %invoke.cont134, %invoke.cont131, %invoke.cont125, %invoke.cont123, %invoke.cont118, %invoke.cont117, %invoke.cont114, %invoke.cont111, %invoke.cont108, %invoke.cont105, %invoke.cont102, %invoke.cont99, %invoke.cont96, %invoke.cont93, %invoke.cont90, %invoke.cont87, %invoke.cont84, %invoke.cont81, %invoke.cont75, %invoke.cont71, %invoke.cont68, %invoke.cont65, %invoke.cont59, %invoke.cont55, %invoke.cont52, %invoke.cont49, %invoke.cont43, %invoke.cont39, %invoke.cont36, %invoke.cont33, %invoke.cont27, %invoke.cont23, %invoke.cont20, %invoke.cont17, %invoke.cont12, %invoke.cont, %if.end
  %3 = landingpad { ptr, i32 }
          cleanup
  ret i32 0

for.end:                                          ; preds = %for.cond
  br label %do.cond

do.cond:                                          ; preds = %for.end
  br i1 false, label %do.body, label %do.end

do.end:                                           ; preds = %do.cond
  br label %for.cond331

for.cond331:                                      ; preds = %do.end
  br label %for.end473

for.end473:                                       ; preds = %for.cond331
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont476 unwind label %lpad

invoke.cont476:                                   ; preds = %for.end473
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont479 unwind label %lpad

invoke.cont479:                                   ; preds = %invoke.cont476
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont482 unwind label %lpad

invoke.cont482:                                   ; preds = %invoke.cont479
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont485 unwind label %lpad

invoke.cont485:                                   ; preds = %invoke.cont482
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont488 unwind label %lpad

invoke.cont488:                                   ; preds = %invoke.cont485
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont491 unwind label %lpad

invoke.cont491:                                   ; preds = %invoke.cont488
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont494 unwind label %lpad

invoke.cont494:                                   ; preds = %invoke.cont491
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont497 unwind label %lpad

invoke.cont497:                                   ; preds = %invoke.cont494
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont500 unwind label %lpad

invoke.cont500:                                   ; preds = %invoke.cont497
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont503 unwind label %lpad

invoke.cont503:                                   ; preds = %invoke.cont500
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont508 unwind label %lpad

invoke.cont508:                                   ; preds = %invoke.cont503
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont514 unwind label %lpad

invoke.cont514:                                   ; preds = %invoke.cont508
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont517 unwind label %lpad

invoke.cont517:                                   ; preds = %invoke.cont514
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont520 unwind label %lpad

invoke.cont520:                                   ; preds = %invoke.cont517
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont525 unwind label %lpad

invoke.cont525:                                   ; preds = %invoke.cont520
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont531 unwind label %lpad

invoke.cont531:                                   ; preds = %invoke.cont525
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont534 unwind label %lpad

invoke.cont534:                                   ; preds = %invoke.cont531
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont537 unwind label %lpad

invoke.cont537:                                   ; preds = %invoke.cont534
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont542 unwind label %lpad

invoke.cont542:                                   ; preds = %invoke.cont537
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont548 unwind label %lpad

invoke.cont548:                                   ; preds = %invoke.cont542
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont551 unwind label %lpad

invoke.cont551:                                   ; preds = %invoke.cont548
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont554 unwind label %lpad

invoke.cont554:                                   ; preds = %invoke.cont551
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont559 unwind label %lpad

invoke.cont559:                                   ; preds = %invoke.cont554
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont565 unwind label %lpad

invoke.cont565:                                   ; preds = %invoke.cont559
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont568 unwind label %lpad

invoke.cont568:                                   ; preds = %invoke.cont565
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont571 unwind label %lpad

invoke.cont571:                                   ; preds = %invoke.cont568
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont576 unwind label %lpad

invoke.cont576:                                   ; preds = %invoke.cont571
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont582 unwind label %lpad

invoke.cont582:                                   ; preds = %invoke.cont576
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont585 unwind label %lpad

invoke.cont585:                                   ; preds = %invoke.cont582
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont588 unwind label %lpad

invoke.cont588:                                   ; preds = %invoke.cont585
  %call591 = invoke ptr @_ZN7libzpaq5ArrayIjEixEm(ptr null, i64 0)
          to label %invoke.cont590 unwind label %lpad

invoke.cont590:                                   ; preds = %invoke.cont588
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont595 unwind label %lpad

invoke.cont595:                                   ; preds = %invoke.cont590
  %call598 = invoke ptr @_ZN7libzpaq5ArrayIjEixEm(ptr null, i64 0)
          to label %invoke.cont597 unwind label %lpad

invoke.cont597:                                   ; preds = %invoke.cont595
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont603 unwind label %lpad

invoke.cont603:                                   ; preds = %invoke.cont597
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont606 unwind label %lpad

invoke.cont606:                                   ; preds = %invoke.cont603
  %call609 = invoke ptr @_ZN7libzpaq5ArrayIcEixEm(ptr null, i64 0)
          to label %invoke.cont608 unwind label %lpad

invoke.cont608:                                   ; preds = %invoke.cont606
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont613 unwind label %lpad

invoke.cont613:                                   ; preds = %invoke.cont608
  %call616 = invoke ptr @_ZN7libzpaq5ArrayIcEixEm(ptr null, i64 0)
          to label %invoke.cont615 unwind label %lpad

invoke.cont615:                                   ; preds = %invoke.cont613
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont621 unwind label %lpad

invoke.cont621:                                   ; preds = %invoke.cont615
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont624 unwind label %lpad

invoke.cont624:                                   ; preds = %invoke.cont621
  %call626 = invoke ptr @_ZN7libzpaq5ArrayIjEixEm(ptr null, i64 0)
          to label %invoke.cont625 unwind label %lpad

invoke.cont625:                                   ; preds = %invoke.cont624
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont630 unwind label %lpad

invoke.cont630:                                   ; preds = %invoke.cont625
  %call633 = invoke ptr @_ZN7libzpaq5ArrayIjEixEm(ptr null, i64 0)
          to label %invoke.cont632 unwind label %lpad

invoke.cont632:                                   ; preds = %invoke.cont630
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont638 unwind label %lpad

invoke.cont638:                                   ; preds = %invoke.cont632
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont641 unwind label %lpad

invoke.cont641:                                   ; preds = %invoke.cont638
  %call644 = invoke ptr @_ZN7libzpaq5ArrayIhEixEm(ptr null, i64 0)
          to label %invoke.cont643 unwind label %lpad

invoke.cont643:                                   ; preds = %invoke.cont641
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont648 unwind label %lpad

invoke.cont648:                                   ; preds = %invoke.cont643
  %call651 = invoke ptr @_ZN7libzpaq5ArrayIhEixEm(ptr null, i64 0)
          to label %invoke.cont650 unwind label %lpad

invoke.cont650:                                   ; preds = %invoke.cont648
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont656 unwind label %lpad

invoke.cont656:                                   ; preds = %invoke.cont650
  br label %for.cond657

for.cond657:                                      ; preds = %invoke.cont656
  br label %for.body659

for.body659:                                      ; preds = %for.cond657
  br label %for.cond661

for.cond661:                                      ; preds = %for.inc1595, %for.body659
  br label %land.end668

land.end668:                                      ; preds = %for.cond661
  br label %for.body669

for.body669:                                      ; preds = %land.end668
  %call673 = invoke ptr @_ZN7libzpaq5ArrayIiEixEm(ptr null, i64 0)
          to label %invoke.cont672 unwind label %lpad

invoke.cont672:                                   ; preds = %for.body669
  br label %if.else703

if.else703:                                       ; preds = %invoke.cont672
  %call706 = invoke ptr @_ZN7libzpaq5ArrayIiEixEm(ptr null, i64 0)
          to label %invoke.cont705 unwind label %lpad

invoke.cont705:                                   ; preds = %if.else703
  br label %cond.false

cond.false:                                       ; preds = %invoke.cont705
  br label %cond.end

cond.end:                                         ; preds = %cond.false
  %call727 = invoke i1 @_ZN7libzpaqL5iserrEi(i32 0)
          to label %invoke.cont726 unwind label %lpad

invoke.cont726:                                   ; preds = %cond.end
  br label %if.then728

if.then728:                                       ; preds = %invoke.cont726
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont731 unwind label %lpad

invoke.cont731:                                   ; preds = %if.then728
  invoke void @_ZN7libzpaqL3putEPhiRiji(ptr null, i32 0, ptr null, i32 0, i32 0)
          to label %invoke.cont734 unwind label %lpad

invoke.cont734:                                   ; preds = %invoke.cont731
  invoke void @_ZN7libzpaqL7put4lsbEPhiRij(ptr null, i32 0, ptr null, i32 0)
          to label %invoke.cont741 unwind label %lpad

invoke.cont741:                                   ; preds = %invoke.cont734
  br label %for.inc1595

for.inc1595:                                      ; preds = %invoke.cont741
  %4 = load i32, ptr %i660, align 4
  %add15963 = add nsw i32 %0, 0
  %5 = load ptr, ptr %i660, align 8
  %arrayidx15984 = getelementptr inbounds i8, ptr %1, i64 undef
  %6 = load i8, ptr %i660, align 1
  %conv1599 = zext i8 %2 to i32
  %rem1600 = srem i32 %conv1599, 8
  %cmp1601 = icmp eq i32 8, 0
  %conv1602 = zext i1 %cmp1601 to i32
  %add1603 = add nsw i32 %0, 0
  %conv1608 = zext i1 false to i32
  %add1609 = add nsw i32 0, 0
  store i32 %rem1600, ptr %i660, align 4
  br label %for.cond661
}

declare i64 @_ZNK7libzpaq5ArrayIhE4sizeEv()

declare i64 @_ZNK7libzpaq5ArrayIjE4sizeEv()

declare void @_ZN7libzpaq5ArrayIiEC2Emi()

declare void @_ZN7libzpaqL3putEPhiRiji()

declare void @_ZN7libzpaqL7put4lsbEPhiRij()

declare ptr @_ZN7libzpaq5ArrayIiEixEm()

declare i1 @_ZN7libzpaqL5iserrEi()

declare ptr @_ZN7libzpaq5ArrayIjEixEm()

; uselistorder directives
uselistorder ptr @_ZN7libzpaqL3putEPhiRiji, { 73, 72, 71, 70, 69, 68, 67, 66, 65, 64, 63, 62, 61, 60, 59, 58, 57, 56, 55, 54, 53, 52, 51, 50, 49, 48, 47, 46, 45, 44, 43, 42, 41, 40, 39, 38, 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
uselistorder ptr @_ZN7libzpaqL7put4lsbEPhiRij, { 37, 36, 35, 34, 33, 32, 31, 30, 29, 28, 27, 26, 25, 24, 23, 22, 21, 20, 19, 18, 17, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1, 0 }
uselistorder ptr @_ZN7libzpaq5ArrayIiEixEm, { 2, 1, 0 }
uselistorder ptr @_ZN7libzpaq5ArrayIjEixEm, { 3, 2, 1, 0 }

attributes #0 = { argmemonly nofree nounwind willreturn }
