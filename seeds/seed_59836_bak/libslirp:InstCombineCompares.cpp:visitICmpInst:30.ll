target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.Slirp = type { i32, i32, i32, i8, i8, i8, %struct.in_addr, %struct.in_addr, %struct.in_addr, %struct.in6_addr, i8, %struct.in6_addr, i8, %struct.in_addr, %struct.in_addr, %struct.in6_addr, %struct.in_addr, [33 x i8], i32, ptr, i32, i32, i8, i32, [6 x i8], %struct.slirp_quehead, %struct.slirp_quehead, i32, %struct.slirp_quehead, %struct.slirp_quehead, i8, %struct.ipq, i16, [16 x %struct.BOOTPClient], ptr, i64, ptr, ptr, %struct.socket, ptr, i32, i32, %struct.socket, ptr, %struct.socket, ptr, ptr, [20 x %struct.tftp_session], ptr, %struct.ArpTable, %struct.NdpTable, ptr, ptr, i8, ptr, ptr, ptr, ptr, i8 }
%struct.in6_addr = type { %union.anon }
%union.anon = type { [4 x i32] }
%struct.in_addr = type { i32 }
%struct.slirp_quehead = type { ptr, ptr }
%struct.ipq = type { %struct.slirp_quehead, i8, i8, i16, %struct.in_addr, %struct.in_addr }
%struct.BOOTPClient = type { i16, [6 x i8] }
%struct.socket = type { ptr, ptr, i32, i32, ptr, i32, ptr, ptr, ptr, i32, %union.slirp_sockaddr, %union.slirp_sockaddr, i8, i8, i8, i32, ptr, i32, i32, i32, %struct.sbuf, %struct.sbuf }
%union.slirp_sockaddr = type { %struct.sockaddr_storage }
%struct.sockaddr_storage = type { i16, [118 x i8], i64 }
%struct.sbuf = type { i32, i32, ptr, ptr, ptr }
%struct.tftp_session = type { ptr, ptr, i32, i16, %struct.sockaddr_storage, i16, i32, i32 }
%struct.ArpTable = type { [16 x %struct.slirp_arphdr], i32 }
%struct.slirp_arphdr = type <{ i16, i16, i8, i8, i16, [6 x i8], i32, [6 x i8], i32 }>
%struct.NdpTable = type { [16 x %struct.ndpentry], %struct.in6_addr, i32 }
%struct.ndpentry = type { [6 x i8], %struct.in6_addr }

define void @if_output(ptr %ifq, ptr %0) {
entry:
  %1 = load ptr, ptr %ifq, align 8
  %if_batchq35 = getelementptr %struct.Slirp, ptr %0, i32 0, i32 29
  %cmp36 = icmp ne ptr %1, %if_batchq35
  br i1 %cmp36, label %for.body, label %common.ret

common.ret:                                       ; preds = %for.body, %entry
  ret void

for.body:                                         ; preds = %entry
  %2 = load ptr, ptr %ifq, align 8
  br label %common.ret
}
