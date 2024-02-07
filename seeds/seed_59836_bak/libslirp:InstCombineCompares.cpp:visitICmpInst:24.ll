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

define ptr @m_get(ptr %mbuf_alloced, i32 %0) {
entry:
  %mbuf_alloced2 = getelementptr %struct.Slirp, ptr undef, i32 0, i32 27
  %inc = add nsw i32 %0, 1
  store i32 %inc, ptr %mbuf_alloced2, align 8
  %1 = load i32, ptr undef, align 8
  %cmp4 = icmp sgt i32 %1, 0
  br i1 %cmp4, label %if.then6, label %if.end7

if.then6:                                         ; preds = %entry
  store i32 0, ptr %mbuf_alloced, align 4
  br label %if.end7

if.end7:                                          ; preds = %if.then6, %entry
  ret ptr null
}
