; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_55291/firejail.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.declare(metadata, metadata, metadata) #0

; Function Attrs: noreturn nounwind
declare void @__assert_fail() #1

; Function Attrs: nounwind readonly willreturn
declare i64 @strlen() #2

; Function Attrs: nounwind readonly willreturn
declare ptr @strrchr() #2

declare i32 @printf(...) #3

declare ptr @fopen() #3

declare i32 @fprintf(...) #3

; Function Attrs: noreturn nounwind
declare void @exit() #1

declare ptr @fgets() #3

; Function Attrs: nounwind readonly willreturn
declare ptr @strchr() #2

declare i32 @fclose() #3

; Function Attrs: nounwind
declare i32 @getuid() #4

; Function Attrs: nounwind
declare i32 @geteuid() #4

declare i32 @open(...) #3

; Function Attrs: nounwind
declare i32 @fstat() #4

; Function Attrs: nounwind
declare i32 @snprintf(...) #4

declare void @perror() #3

declare i32 @sleep() #3

; Function Attrs: nounwind
declare i32 @ioctl(...) #4

declare i32 @close() #3

; Function Attrs: nounwind
declare i32 @asprintf(...) #4

; Function Attrs: argmemonly nocallback nofree nounwind willreturn writeonly
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #5

; Function Attrs: nounwind
declare ptr @realpath() #4

; Function Attrs: nounwind
declare void @free() #4

; Function Attrs: nounwind
declare i32 @seteuid() #4

; Function Attrs: nounwind
declare i32 @setegid() #4

; Function Attrs: nounwind
declare i32 @getgid() #4

; Function Attrs: nounwind readonly willreturn
declare i32 @memcmp() #2

; Function Attrs: nounwind
declare i32 @socket() #4

; Function Attrs: nounwind
declare ptr @strncpy() #4

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #6

declare i32 @fflush() #3

; Function Attrs: nounwind
declare i32 @rand() #4

; Function Attrs: nounwind readonly willreturn
declare i32 @strncmp() #2

; Function Attrs: nounwind
declare i32 @fileno() #4

; Function Attrs: nounwind
declare i32 @fchmod() #4

; Function Attrs: nounwind
declare i32 @fchown() #4

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare void @llvm.dbg.label(metadata) #0

; Function Attrs: nounwind allocsize(0)
declare noalias ptr @malloc(i64 noundef) #7

; Function Attrs: nounwind
declare noalias ptr @strdup() #4

; Function Attrs: nounwind readnone willreturn
declare ptr @__errno_location() #8

; Function Attrs: nounwind readnone willreturn
declare ptr @__ctype_b_loc() #8

; Function Attrs: nounwind readonly willreturn
declare i32 @strcmp() #2

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @caps_check_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @caps_find_name() #9

; Function Attrs: nounwind
declare i32 @prctl(...) #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @caps_drop_dac_override() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @caps_drop_all() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @caps_set() #9

; Function Attrs: nounwind
declare i32 @__isoc99_sscanf(...) #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @checkcfg() #9

; Function Attrs: nounwind
declare i32 @access() #4

; Function Attrs: nounwind readonly willreturn
declare i32 @atoi() #2

; Function Attrs: nounwind
declare i64 @strtoul() #4

; Function Attrs: nounwind
declare ptr @strtok() #4

; Function Attrs: nounwind allocsize(1)
declare ptr @realloc(ptr noundef, i64 noundef) #10

declare i32 @openat(...) #3

; Function Attrs: nounwind
declare i32 @stat() #4

; Function Attrs: nounwind
declare i32 @lstat() #4

; Function Attrs: nounwind
declare i32 @mkdir() #4

; Function Attrs: nounwind
declare i32 @chroot() #4

; Function Attrs: nounwind
declare i32 @fstatat() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @build_cmdline() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @cmdline_length() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @quote_cmdline() #9

; Function Attrs: nounwind
declare i32 @sprintf(...) #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @read_cpu_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_cpu() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_cpu_affinity() #9

; Function Attrs: nounwind
declare i32 @sched_setaffinity() #4

; Function Attrs: nounwind
declare i32 @sched_getaffinity() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @dbus_check_name() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @check_bus_or_interface_name() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @dbus_check_call_rule() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @check_object_path() #9

; Function Attrs: nounwind
declare i32 @fork() #4

; Function Attrs: nounwind
declare i32 @dup2() #4

; Function Attrs: nounwind
declare i32 @getpid() #4

declare i64 @read() #3

declare i32 @waitpid() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #11

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #11

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @dbus_set_session_bus_env() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @dbus_set_system_bus_env() #9

; Function Attrs: nounwind readonly willreturn
declare ptr @strstr() #2

declare i32 @usleep() #3

declare i32 @__isoc99_fscanf(...) #3

declare ptr @opendir() #3

declare ptr @readdir() #3

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare ptr @llvm.stacksave() #11

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @env_store() #9

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.stackrestore(ptr) #11

declare i32 @closedir() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @env_add() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @env_defaults() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @env_store_name_val() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @env_get() #9

; Function Attrs: nounwind
declare i32 @isatty() #4

; Function Attrs: nounwind allocsize(0,1)
declare noalias ptr @calloc(i64 noundef, i64 noundef) #12

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @env_apply_all() #9

; Function Attrs: nounwind
declare i32 @setenv() #4

; Function Attrs: nounwind
declare i32 @unsetenv() #4

; Function Attrs: nounwind
declare ptr @strerror() #4

; Function Attrs: nounwind
declare i32 @chown() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fs_check_private_dir() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fs_check_private_cwd() #9

; Function Attrs: nounwind
declare ptr @strcpy() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @fs_check_hosts_file() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fs_mkdir() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @mkdir_recursive() #9

; Function Attrs: noreturn
declare void @_exit() #13

; Function Attrs: nounwind
declare i32 @chdir() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fs_mkfile() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pin_sandbox_process() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @find_pidns_parent() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_firejail_comm() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_firejail_credentials() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @switch_to_sandbox() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_joinable() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare zeroext i1 @has_join_file() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @read_sandbox_pidfile() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.1360() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.1361() #9

declare i32 @fcntl(...) #3

; Function Attrs: nounwind
declare ptr @fdopen() #4

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @join() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_x11_display() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_nonewprivs() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_caps.1379() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_cpu() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_nogroups() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_user_namespace() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_umask() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @extract_command() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @install_handler() #9

; Function Attrs: nounwind
declare ptr @signal() #4

; Function Attrs: nounwind
declare i32 @sigemptyset() #4

; Function Attrs: nounwind
declare i32 @sigaction() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @macro_id() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @resolve_macro() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @resolve_xdg() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @resolve_hardcoded() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @expand_macros() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.1531() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.1536() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @invalid_filename() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_user_namespace() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @filter_add_errno() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @filter_add_blacklist_override() #9

; Function Attrs: nounwind
declare i32 @umask() #4

; Function Attrs: nounwind
declare i32 @setreuid() #4

; Function Attrs: nounwind
declare i32 @setregid() #4

; Function Attrs: nounwind
declare i32 @setresgid() #4

; Function Attrs: nounwind
declare i32 @setresuid() #4

; Function Attrs: nounwind
declare i32 @execvp() #4

; Function Attrs: nounwind
declare i32 @kill() #4

; Function Attrs: nounwind
declare ptr @getenv() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_netfilter_file() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_netns() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @netns_control_file() #9

; Function Attrs: nounwind
declare i64 @syscall(...) #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @check_ip46_address() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @atoip.1932() #9

; Function Attrs: nounwind
declare i32 @inet_pton() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @init_paths() #9

; Function Attrs: nounwind
declare ptr @strsep() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @program_in_path() #9

; Function Attrs: nounwind
declare i64 @strtol() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pin_process() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.2202() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.2203() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @unpin_process() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_get_pid() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_get_fd() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_stat_nofail() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_stat() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_open_nofail() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_open() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @process_fopen() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_join_namespace() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pin_parent_process() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_parent_pid() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pin_process_relative_to() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pin_child_process() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @process_rootfs_chroot() #9

; Function Attrs: nounwind
declare i32 @fchdir() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_rootfs_stat() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @process_rootfs_open() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @profile_find_firejail() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @profile_find() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @profile_read() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @profile_add() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @is_in_ignore_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @profile_check_line() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @profile_check_conditional() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @profile_add_ignore() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @profile_list_augment() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @warning_feature_disabled() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @last_bridge_configured.2383() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @atoip.2389() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @mac_not_zero.2391() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @atomac.2393() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.2493() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.2494() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @profile_list_compress() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @profile_list_normalize() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_rlimits() #9

; Function Attrs: nounwind
declare i32 @getrlimit() #4

; Function Attrs: nounwind
declare i32 @setrlimit() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_x11_run_file() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_profile_run_file() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.2718() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.2719() #9

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @start_application() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @close_file_descriptors() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @print_time() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ok_to_run() #9

; Function Attrs: nounwind
declare i32 @fexecve() #4

; Function Attrs: nounwind
declare ptr @mmap() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @sbox_run(...) #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @sbox_run_v() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.2926() #9

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare i32 @sbox_do_exec_v() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @seccomp_check_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @seccomp_install_filters() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @seccomp_load_file_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @seccomp_load() #9

; Function Attrs: nounwind
declare i64 @lseek() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @seccomp_save_file_list() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i64 @parse_arg_size() #9

declare void @openlog() #3

declare void @syslog(...) #3

declare void @closelog() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @check_can_drop_all_groups() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fwarning(...) #9

declare i32 @vfprintf() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @drop_privs() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_ROOT.3078() #9

; Function Attrs: nounwind
declare i32 @setgroups() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @clean_supplementary_groups() #9

declare i32 @getgrouplist() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @copy_group_ifcont() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @get_group_id() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @find_group() #9

declare ptr @getgrnam() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @fmessage(...) #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @logmsg() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @set_nice() #9

; Function Attrs: nounwind
declare i32 @nice() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @touch_file_as_user() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @is_dir() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @stat_as_user() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @EUID_USER.3153() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @is_link() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @trim_trailing_slash_or_dot() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i64 @readlink_as_user() #9

; Function Attrs: nounwind
declare i64 @readlink() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @line_remove_spaces() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @split_comma() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @check_unsigned() #9

declare i32 @wait() #3

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @flush_stdin() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @extract_timeout() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @close_all() #9

; Function Attrs: nounwind
declare i32 @dirfd() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ascii_isalnum() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ascii_isalpha() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ascii_isdigit() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ascii_islower() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @ascii_isupper() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @invalid_name() #9

declare i32 @fputs() #3

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start_xvfb() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @random_display_number() #9

declare i32 @connect() #3

; Function Attrs: argmemonly nocallback nofree nounwind willreturn
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #6

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start_xephyr() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @extract_setting() #9

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start_xpra() #14

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start_xpra_new() #14

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start_xpra_old() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @get_title_arg_str() #9

; Function Attrs: nounwind
declare ptr @strcat() #4

; Function Attrs: noinline noreturn nounwind sspstrong uwtable
declare void @x11_start() #14

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @join_namespace_by_fd() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @name2pid() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @pid_proc_comm() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @gnu_basename() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @do_replace_cntrl_chars() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @replace_cntrl_chars() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @has_cntrl_chars() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @reject_cntrl_chars() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @reject_meta_chars() #9

; Function Attrs: nounwind readonly willreturn
declare ptr @strpbrk() #2

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @str_to_int_array() #9

; Function Attrs: nounwind
declare i32 @clock_gettime() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare float @timetrace_end() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare float @msdelta() #9

; Function Attrs: nocallback nofree nosync nounwind readnone speculatable willreturn
declare float @llvm.fmuladd.f32(float, float, float) #0

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @errno_find_name() #9

; Function Attrs: nounwind readonly willreturn
declare i32 @strcasecmp() #2

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @errno_find_nr() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @syscall_find_nr() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @syscall_find_nr_32() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @syscall_check_list(ptr noundef) #9

; Function Attrs: nounwind
declare ptr @strtok_r() #4

; Function Attrs: noinline nounwind sspstrong uwtable
declare ptr @syscall_find_group() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare void @syscall_process_name() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @syscall_find_name() #9

; Function Attrs: noinline nounwind sspstrong uwtable
declare i32 @syscall_find_name_32() #9

; Function Attrs: noinline nounwind sspstrong uwtable
define void @syscalls_in_list() #9 {
entry:
  %call = call i32 @syscall_check_list(ptr nonnull @syscall_in_list)
  ret void
}

; Function Attrs: noinline nounwind sspstrong uwtable
define internal void @syscall_in_list() #9 {
entry:
  %call = call i32 @syscall_check_list(ptr nonnull @find_syscall)
  ret void
}

; Function Attrs: noinline nounwind sspstrong uwtable
define internal void @find_syscall() #9 {
entry:
  %syscall.addr = alloca i32, align 4
  %ptr = alloca ptr, align 8
  %0 = load i32, ptr %syscall.addr, align 4
  %call = call i32 @abs(i32 noundef %0) #15
  %cmp = icmp eq i32 %call, 0
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %1 = load ptr, ptr %ptr, align 8
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: nounwind readnone willreturn
declare i32 @abs(i32 noundef) #8

attributes #0 = { nocallback nofree nosync nounwind readnone speculatable willreturn }
attributes #1 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #2 = { nounwind readonly willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #3 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { argmemonly nocallback nofree nounwind willreturn writeonly }
attributes #6 = { argmemonly nocallback nofree nounwind willreturn }
attributes #7 = { nounwind allocsize(0) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { nounwind readnone willreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #9 = { noinline nounwind sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="inline-asm" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { nounwind allocsize(1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { nocallback nofree nosync nounwind willreturn }
attributes #12 = { nounwind allocsize(0,1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { noreturn "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #14 = { noinline noreturn nounwind sspstrong uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "probe-stack"="inline-asm" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #15 = { nounwind readnone willreturn }

!llvm.dbg.cu = !{!0, !49, !92, !196, !225, !242, !279, !282, !285, !291, !315, !340, !366, !391, !402, !429, !457, !459, !461, !463, !465, !483, !485, !487, !490, !525, !547, !549, !566, !582, !594, !942, !959, !962, !964, !985, !987, !997, !999, !1001, !1012, !1017, !1019, !1037, !1039, !1042, !1055, !1060, !1088, !1094, !1096, !1103, !1106, !1141, !1143, !1145, !1150, !1164, !1173, !1194, !1196, !1203, !1216}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !39, globals: !41, splitDebugInlining: false, nameTableKind: None)
!1 = !DIFile(filename: "appimage.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "67638c51c519f7db60a373130fd5a153")
!2 = !{!3, !9}
!3 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 721, baseType: !5, size: 32, elements: !6)
!4 = !DIFile(filename: "./firejail.h", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "df61749d30184eadd16d8870c2be281c")
!5 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!6 = !{!7, !8}
!7 = !DIEnumerator(name: "SETENV", value: 0)
!8 = !DIEnumerator(name: "RMENV", value: 1)
!9 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !10, line: 33, baseType: !11, size: 32, elements: !12)
!10 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/mount.h", directory: "", checksumkind: CSK_MD5, checksum: "5a699b33e7dac65bb3af799509f9886e")
!11 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!12 = !{!13, !14, !15, !16, !17, !18, !19, !20, !21, !22, !23, !24, !25, !26, !27, !28, !29, !30, !31, !32, !33, !34, !35, !36, !37, !38}
!13 = !DIEnumerator(name: "MS_RDONLY", value: 1)
!14 = !DIEnumerator(name: "MS_NOSUID", value: 2)
!15 = !DIEnumerator(name: "MS_NODEV", value: 4)
!16 = !DIEnumerator(name: "MS_NOEXEC", value: 8)
!17 = !DIEnumerator(name: "MS_SYNCHRONOUS", value: 16)
!18 = !DIEnumerator(name: "MS_REMOUNT", value: 32)
!19 = !DIEnumerator(name: "MS_MANDLOCK", value: 64)
!20 = !DIEnumerator(name: "MS_DIRSYNC", value: 128)
!21 = !DIEnumerator(name: "MS_NOATIME", value: 1024)
!22 = !DIEnumerator(name: "MS_NODIRATIME", value: 2048)
!23 = !DIEnumerator(name: "MS_BIND", value: 4096)
!24 = !DIEnumerator(name: "MS_MOVE", value: 8192)
!25 = !DIEnumerator(name: "MS_REC", value: 16384)
!26 = !DIEnumerator(name: "MS_SILENT", value: 32768)
!27 = !DIEnumerator(name: "MS_POSIXACL", value: 65536)
!28 = !DIEnumerator(name: "MS_UNBINDABLE", value: 131072)
!29 = !DIEnumerator(name: "MS_PRIVATE", value: 262144)
!30 = !DIEnumerator(name: "MS_SLAVE", value: 524288)
!31 = !DIEnumerator(name: "MS_SHARED", value: 1048576)
!32 = !DIEnumerator(name: "MS_RELATIME", value: 2097152)
!33 = !DIEnumerator(name: "MS_KERNMOUNT", value: 4194304)
!34 = !DIEnumerator(name: "MS_I_VERSION", value: 8388608)
!35 = !DIEnumerator(name: "MS_STRICTATIME", value: 16777216)
!36 = !DIEnumerator(name: "MS_LAZYTIME", value: 33554432)
!37 = !DIEnumerator(name: "MS_ACTIVE", value: 1073741824)
!38 = !DIEnumerator(name: "MS_NOUSER", value: -2147483648)
!39 = !{!40}
!40 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!41 = !{!42, !46}
!42 = !DIGlobalVariableExpression(var: !43, expr: !DIExpression())
!43 = distinct !DIGlobalVariable(name: "devloop", scope: !0, file: !1, line: 32, type: !44, isLocal: true, isDefinition: true)
!44 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !DIGlobalVariableExpression(var: !47, expr: !DIExpression())
!47 = distinct !DIGlobalVariable(name: "size", scope: !0, file: !1, line: 33, type: !48, isLocal: true, isDefinition: true)
!48 = !DIBasicType(name: "unsigned long", size: 64, encoding: DW_ATE_unsigned)
!49 = distinct !DICompileUnit(language: DW_LANG_C99, file: !50, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !51, globals: !57, splitDebugInlining: false, nameTableKind: None)
!50 = !DIFile(filename: "appimage_size.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "19357df70cf7267f05c0ac51fc73d5ce")
!51 = !{!52, !54}
!52 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !53, line: 46, baseType: !48)
!53 = !DIFile(filename: "55291/build/lib/clang/15.0.0/include/stddef.h", directory: "/home/doitman", checksumkind: CSK_MD5, checksum: "2499dd2361b915724b073282bea3a7bc")
!54 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint16_t", file: !55, line: 40, baseType: !56)
!55 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types.h", directory: "", checksumkind: CSK_MD5, checksum: "f6304b1a6dcfc6bee76e9a51043b5090")
!56 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!57 = !{!58}
!58 = !DIGlobalVariableExpression(var: !59, expr: !DIExpression())
!59 = distinct !DIGlobalVariable(name: "ehdr", scope: !49, file: !50, line: 47, type: !60, isLocal: true, isDefinition: true)
!60 = !DIDerivedType(tag: DW_TAG_typedef, name: "Elf64_Ehdr", file: !61, line: 101, baseType: !62)
!61 = !DIFile(filename: "/usr/include/elf.h", directory: "", checksumkind: CSK_MD5, checksum: "356ef265ec8d7cfc15cf6615f0ae43b1")
!62 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !61, line: 85, size: 512, elements: !63)
!63 = !{!64, !69, !73, !74, !78, !82, !84, !85, !86, !87, !88, !89, !90, !91}
!64 = !DIDerivedType(tag: DW_TAG_member, name: "e_ident", scope: !62, file: !61, line: 87, baseType: !65, size: 128)
!65 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 128, elements: !67)
!66 = !DIBasicType(name: "unsigned char", size: 8, encoding: DW_ATE_unsigned_char)
!67 = !{!68}
!68 = !DISubrange(count: 16)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "e_type", scope: !62, file: !61, line: 88, baseType: !70, size: 16, offset: 128)
!70 = !DIDerivedType(tag: DW_TAG_typedef, name: "Elf64_Half", file: !61, line: 32, baseType: !71)
!71 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint16_t", file: !72, line: 25, baseType: !54)
!72 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/stdint-uintn.h", directory: "", checksumkind: CSK_MD5, checksum: "d3ea318a915682aaf6645ec16ac9f991")
!73 = !DIDerivedType(tag: DW_TAG_member, name: "e_machine", scope: !62, file: !61, line: 89, baseType: !70, size: 16, offset: 144)
!74 = !DIDerivedType(tag: DW_TAG_member, name: "e_version", scope: !62, file: !61, line: 90, baseType: !75, size: 32, offset: 160)
!75 = !DIDerivedType(tag: DW_TAG_typedef, name: "Elf64_Word", file: !61, line: 37, baseType: !76)
!76 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint32_t", file: !72, line: 26, baseType: !77)
!77 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint32_t", file: !55, line: 42, baseType: !5)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "e_entry", scope: !62, file: !61, line: 91, baseType: !79, size: 64, offset: 192)
!79 = !DIDerivedType(tag: DW_TAG_typedef, name: "Elf64_Addr", file: !61, line: 48, baseType: !80)
!80 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint64_t", file: !72, line: 27, baseType: !81)
!81 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint64_t", file: !55, line: 45, baseType: !48)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "e_phoff", scope: !62, file: !61, line: 92, baseType: !83, size: 64, offset: 256)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "Elf64_Off", file: !61, line: 52, baseType: !80)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "e_shoff", scope: !62, file: !61, line: 93, baseType: !83, size: 64, offset: 320)
!85 = !DIDerivedType(tag: DW_TAG_member, name: "e_flags", scope: !62, file: !61, line: 94, baseType: !75, size: 32, offset: 384)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "e_ehsize", scope: !62, file: !61, line: 95, baseType: !70, size: 16, offset: 416)
!87 = !DIDerivedType(tag: DW_TAG_member, name: "e_phentsize", scope: !62, file: !61, line: 96, baseType: !70, size: 16, offset: 432)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "e_phnum", scope: !62, file: !61, line: 97, baseType: !70, size: 16, offset: 448)
!89 = !DIDerivedType(tag: DW_TAG_member, name: "e_shentsize", scope: !62, file: !61, line: 98, baseType: !70, size: 16, offset: 464)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "e_shnum", scope: !62, file: !61, line: 99, baseType: !70, size: 16, offset: 480)
!91 = !DIDerivedType(tag: DW_TAG_member, name: "e_shstrndx", scope: !62, file: !61, line: 100, baseType: !70, size: 16, offset: 496)
!92 = distinct !DICompileUnit(language: DW_LANG_C99, file: !93, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !94, retainedTypes: !172, splitDebugInlining: false, nameTableKind: None)
!93 = !DIFile(filename: "arp.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "c551dceefe0382612892d5db24406fef")
!94 = !{!95, !107, !136}
!95 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "__socket_type", file: !96, line: 24, baseType: !5, size: 32, elements: !97)
!96 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/socket_type.h", directory: "", checksumkind: CSK_MD5, checksum: "630d972ab4324a8e936ce28b39a40b01")
!97 = !{!98, !99, !100, !101, !102, !103, !104, !105, !106}
!98 = !DIEnumerator(name: "SOCK_STREAM", value: 1)
!99 = !DIEnumerator(name: "SOCK_DGRAM", value: 2)
!100 = !DIEnumerator(name: "SOCK_RAW", value: 3)
!101 = !DIEnumerator(name: "SOCK_RDM", value: 4)
!102 = !DIEnumerator(name: "SOCK_SEQPACKET", value: 5)
!103 = !DIEnumerator(name: "SOCK_DCCP", value: 6)
!104 = !DIEnumerator(name: "SOCK_PACKET", value: 10)
!105 = !DIEnumerator(name: "SOCK_CLOEXEC", value: 524288)
!106 = !DIEnumerator(name: "SOCK_NONBLOCK", value: 2048)
!107 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !108, line: 40, baseType: !5, size: 32, elements: !109)
!108 = !DIFile(filename: "/usr/include/netinet/in.h", directory: "", checksumkind: CSK_MD5, checksum: "6a5254a491bcdb8c3253de75bf3571c1")
!109 = !{!110, !111, !112, !113, !114, !115, !116, !117, !118, !119, !120, !121, !122, !123, !124, !125, !126, !127, !128, !129, !130, !131, !132, !133, !134, !135}
!110 = !DIEnumerator(name: "IPPROTO_IP", value: 0)
!111 = !DIEnumerator(name: "IPPROTO_ICMP", value: 1)
!112 = !DIEnumerator(name: "IPPROTO_IGMP", value: 2)
!113 = !DIEnumerator(name: "IPPROTO_IPIP", value: 4)
!114 = !DIEnumerator(name: "IPPROTO_TCP", value: 6)
!115 = !DIEnumerator(name: "IPPROTO_EGP", value: 8)
!116 = !DIEnumerator(name: "IPPROTO_PUP", value: 12)
!117 = !DIEnumerator(name: "IPPROTO_UDP", value: 17)
!118 = !DIEnumerator(name: "IPPROTO_IDP", value: 22)
!119 = !DIEnumerator(name: "IPPROTO_TP", value: 29)
!120 = !DIEnumerator(name: "IPPROTO_DCCP", value: 33)
!121 = !DIEnumerator(name: "IPPROTO_IPV6", value: 41)
!122 = !DIEnumerator(name: "IPPROTO_RSVP", value: 46)
!123 = !DIEnumerator(name: "IPPROTO_GRE", value: 47)
!124 = !DIEnumerator(name: "IPPROTO_ESP", value: 50)
!125 = !DIEnumerator(name: "IPPROTO_AH", value: 51)
!126 = !DIEnumerator(name: "IPPROTO_MTP", value: 92)
!127 = !DIEnumerator(name: "IPPROTO_BEETPH", value: 94)
!128 = !DIEnumerator(name: "IPPROTO_ENCAP", value: 98)
!129 = !DIEnumerator(name: "IPPROTO_PIM", value: 103)
!130 = !DIEnumerator(name: "IPPROTO_COMP", value: 108)
!131 = !DIEnumerator(name: "IPPROTO_SCTP", value: 132)
!132 = !DIEnumerator(name: "IPPROTO_UDPLITE", value: 136)
!133 = !DIEnumerator(name: "IPPROTO_MPLS", value: 137)
!134 = !DIEnumerator(name: "IPPROTO_RAW", value: 255)
!135 = !DIEnumerator(name: "IPPROTO_MAX", value: 256)
!136 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 813, baseType: !5, size: 32, elements: !137)
!137 = !{!138, !139, !140, !141, !142, !143, !144, !145, !146, !147, !148, !149, !150, !151, !152, !153, !154, !155, !156, !157, !158, !159, !160, !161, !162, !163, !164, !165, !166, !167, !168, !169, !170, !171}
!138 = !DIEnumerator(name: "CFG_FILE_TRANSFER", value: 0)
!139 = !DIEnumerator(name: "CFG_X11", value: 1)
!140 = !DIEnumerator(name: "CFG_BIND", value: 2)
!141 = !DIEnumerator(name: "CFG_USERNS", value: 3)
!142 = !DIEnumerator(name: "CFG_CHROOT", value: 4)
!143 = !DIEnumerator(name: "CFG_SECCOMP", value: 5)
!144 = !DIEnumerator(name: "CFG_NETWORK", value: 6)
!145 = !DIEnumerator(name: "CFG_RESTRICTED_NETWORK", value: 7)
!146 = !DIEnumerator(name: "CFG_FORCE_NONEWPRIVS", value: 8)
!147 = !DIEnumerator(name: "CFG_XEPHYR_WINDOW_TITLE", value: 9)
!148 = !DIEnumerator(name: "CFG_OVERLAYFS", value: 10)
!149 = !DIEnumerator(name: "CFG_PRIVATE_BIN", value: 11)
!150 = !DIEnumerator(name: "CFG_PRIVATE_BIN_NO_LOCAL", value: 12)
!151 = !DIEnumerator(name: "CFG_PRIVATE_CACHE", value: 13)
!152 = !DIEnumerator(name: "CFG_PRIVATE_ETC", value: 14)
!153 = !DIEnumerator(name: "CFG_PRIVATE_HOME", value: 15)
!154 = !DIEnumerator(name: "CFG_PRIVATE_LIB", value: 16)
!155 = !DIEnumerator(name: "CFG_PRIVATE_OPT", value: 17)
!156 = !DIEnumerator(name: "CFG_PRIVATE_SRV", value: 18)
!157 = !DIEnumerator(name: "CFG_FIREJAIL_PROMPT", value: 19)
!158 = !DIEnumerator(name: "CFG_DISABLE_MNT", value: 20)
!159 = !DIEnumerator(name: "CFG_JOIN", value: 21)
!160 = !DIEnumerator(name: "CFG_ARP_PROBES", value: 22)
!161 = !DIEnumerator(name: "CFG_XPRA_ATTACH", value: 23)
!162 = !DIEnumerator(name: "CFG_BROWSER_DISABLE_U2F", value: 24)
!163 = !DIEnumerator(name: "CFG_BROWSER_ALLOW_DRM", value: 25)
!164 = !DIEnumerator(name: "CFG_APPARMOR", value: 26)
!165 = !DIEnumerator(name: "CFG_DBUS", value: 27)
!166 = !DIEnumerator(name: "CFG_NAME_CHANGE", value: 28)
!167 = !DIEnumerator(name: "CFG_SECCOMP_ERROR_ACTION", value: 29)
!168 = !DIEnumerator(name: "CFG_ALLOW_TRAY", value: 30)
!169 = !DIEnumerator(name: "CFG_SECCOMP_LOG", value: 31)
!170 = !DIEnumerator(name: "CFG_TRACELOG", value: 32)
!171 = !DIEnumerator(name: "CFG_MAX", value: 33)
!172 = !{!11, !173, !176, !187, !40, !190, !5, !76}
!173 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !174, size: 64)
!174 = !DIDerivedType(tag: DW_TAG_typedef, name: "uint8_t", file: !72, line: 24, baseType: !175)
!175 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uint8_t", file: !55, line: 38, baseType: !66)
!176 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !177, size: 64)
!177 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sockaddr", file: !178, line: 178, size: 128, elements: !179)
!178 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/socket.h", directory: "", checksumkind: CSK_MD5, checksum: "b1d3343a573cbf39b225111209e02966")
!179 = !{!180, !183}
!180 = !DIDerivedType(tag: DW_TAG_member, name: "sa_family", scope: !177, file: !178, line: 180, baseType: !181, size: 16)
!181 = !DIDerivedType(tag: DW_TAG_typedef, name: "sa_family_t", file: !182, line: 28, baseType: !56)
!182 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/sockaddr.h", directory: "", checksumkind: CSK_MD5, checksum: "b70cbaf07ffb7e8bf11ee98d9a21e2fc")
!183 = !DIDerivedType(tag: DW_TAG_member, name: "sa_data", scope: !177, file: !178, line: 181, baseType: !184, size: 112, offset: 16)
!184 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 112, elements: !185)
!185 = !{!186}
!186 = !DISubrange(count: 14)
!187 = !DIDerivedType(tag: DW_TAG_typedef, name: "__fd_mask", file: !188, line: 49, baseType: !189)
!188 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/select.h", directory: "", checksumkind: CSK_MD5, checksum: "d9544b6ca50e028622009bf667961f34")
!189 = !DIBasicType(name: "long", size: 64, encoding: DW_ATE_signed)
!190 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !191, size: 64)
!191 = !DIDerivedType(tag: DW_TAG_typedef, name: "fd_set", file: !188, line: 70, baseType: !192)
!192 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !188, line: 59, size: 1024, elements: !193)
!193 = !{!194}
!194 = !DIDerivedType(tag: DW_TAG_member, name: "fds_bits", scope: !192, file: !188, line: 64, baseType: !195, size: 1024)
!195 = !DICompositeType(tag: DW_TAG_array_type, baseType: !187, size: 1024, elements: !67)
!196 = distinct !DICompileUnit(language: DW_LANG_C99, file: !197, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !198, retainedTypes: !214, globals: !215, splitDebugInlining: false, nameTableKind: None)
!197 = !DIFile(filename: "bandwidth.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "7c54b57e67cba9519b10a7d24b49ae99")
!198 = !{!199}
!199 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !200, line: 46, baseType: !5, size: 32, elements: !201)
!200 = !DIFile(filename: "/usr/include/ctype.h", directory: "", checksumkind: CSK_MD5, checksum: "36575f934ef4fe7e9d50a3cb17bd5c66")
!201 = !{!202, !203, !204, !205, !206, !207, !208, !209, !210, !211, !212, !213}
!202 = !DIEnumerator(name: "_ISupper", value: 256)
!203 = !DIEnumerator(name: "_ISlower", value: 512)
!204 = !DIEnumerator(name: "_ISalpha", value: 1024)
!205 = !DIEnumerator(name: "_ISdigit", value: 2048)
!206 = !DIEnumerator(name: "_ISxdigit", value: 4096)
!207 = !DIEnumerator(name: "_ISspace", value: 8192)
!208 = !DIEnumerator(name: "_ISprint", value: 16384)
!209 = !DIEnumerator(name: "_ISgraph", value: 32768)
!210 = !DIEnumerator(name: "_ISblank", value: 1)
!211 = !DIEnumerator(name: "_IScntrl", value: 2)
!212 = !DIEnumerator(name: "_ISpunct", value: 4)
!213 = !DIEnumerator(name: "_ISalnum", value: 8)
!214 = !{!40, !11, !66, !56}
!215 = !{!216}
!216 = !DIGlobalVariableExpression(var: !217, expr: !DIExpression())
!217 = distinct !DIGlobalVariable(name: "ifbw", scope: !196, file: !197, line: 36, type: !218, isLocal: false, isDefinition: true)
!218 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !219, size: 64)
!219 = !DIDerivedType(tag: DW_TAG_typedef, name: "IFBW", file: !197, line: 35, baseType: !220)
!220 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "ifbw_t", file: !197, line: 32, size: 128, elements: !221)
!221 = !{!222, !224}
!222 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !220, file: !197, line: 33, baseType: !223, size: 64)
!223 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !220, size: 64)
!224 = !DIDerivedType(tag: DW_TAG_member, name: "txt", scope: !220, file: !197, line: 34, baseType: !44, size: 64, offset: 64)
!225 = distinct !DICompileUnit(language: DW_LANG_C99, file: !226, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !198, retainedTypes: !227, globals: !229, splitDebugInlining: false, nameTableKind: None)
!226 = !DIFile(filename: "caps.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "bd5e000fb6e2fb5e57df22f67dcf4c17")
!227 = !{!40, !11, !56, !228}
!228 = !DIBasicType(name: "unsigned long long", size: 64, encoding: DW_ATE_unsigned)
!229 = !{!230, !232}
!230 = !DIGlobalVariableExpression(var: !231, expr: !DIExpression())
!231 = distinct !DIGlobalVariable(name: "filter", scope: !225, file: !226, line: 360, type: !80, isLocal: true, isDefinition: true)
!232 = !DIGlobalVariableExpression(var: !233, expr: !DIExpression())
!233 = distinct !DIGlobalVariable(name: "capslist", scope: !225, file: !226, line: 42, type: !234, isLocal: true, isDefinition: true)
!234 = !DICompositeType(tag: DW_TAG_array_type, baseType: !235, size: 5248, elements: !240)
!235 = !DIDerivedType(tag: DW_TAG_typedef, name: "CapsEntry", file: !226, line: 40, baseType: !236)
!236 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !226, line: 37, size: 128, elements: !237)
!237 = !{!238, !239}
!238 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !236, file: !226, line: 38, baseType: !44, size: 64)
!239 = !DIDerivedType(tag: DW_TAG_member, name: "nr", scope: !236, file: !226, line: 39, baseType: !11, size: 32, offset: 64)
!240 = !{!241}
!241 = !DISubrange(count: 41)
!242 = distinct !DICompileUnit(language: DW_LANG_C99, file: !243, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !244, globals: !245, splitDebugInlining: false, nameTableKind: None)
!243 = !DIFile(filename: "checkcfg.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "3a16777f8b4464fbb48debb3fc971000")
!244 = !{!136, !3}
!245 = !{!246, !248, !250, !252, !254, !256, !258, !260, !262, !264, !267, !272, !277}
!246 = !DIGlobalVariableExpression(var: !247, expr: !DIExpression())
!247 = distinct !DIGlobalVariable(name: "xephyr_screen", scope: !242, file: !243, line: 30, type: !44, isLocal: false, isDefinition: true)
!248 = !DIGlobalVariableExpression(var: !249, expr: !DIExpression())
!249 = distinct !DIGlobalVariable(name: "xephyr_extra_params", scope: !242, file: !243, line: 31, type: !44, isLocal: false, isDefinition: true)
!250 = !DIGlobalVariableExpression(var: !251, expr: !DIExpression())
!251 = distinct !DIGlobalVariable(name: "xpra_extra_params", scope: !242, file: !243, line: 32, type: !44, isLocal: false, isDefinition: true)
!252 = !DIGlobalVariableExpression(var: !253, expr: !DIExpression())
!253 = distinct !DIGlobalVariable(name: "xvfb_screen", scope: !242, file: !243, line: 33, type: !44, isLocal: false, isDefinition: true)
!254 = !DIGlobalVariableExpression(var: !255, expr: !DIExpression())
!255 = distinct !DIGlobalVariable(name: "xvfb_extra_params", scope: !242, file: !243, line: 34, type: !44, isLocal: false, isDefinition: true)
!256 = !DIGlobalVariableExpression(var: !257, expr: !DIExpression())
!257 = distinct !DIGlobalVariable(name: "netfilter_default", scope: !242, file: !243, line: 35, type: !44, isLocal: false, isDefinition: true)
!258 = !DIGlobalVariableExpression(var: !259, expr: !DIExpression())
!259 = distinct !DIGlobalVariable(name: "join_timeout", scope: !242, file: !243, line: 36, type: !48, isLocal: false, isDefinition: true)
!260 = !DIGlobalVariableExpression(var: !261, expr: !DIExpression())
!261 = distinct !DIGlobalVariable(name: "config_seccomp_error_action_str", scope: !242, file: !243, line: 37, type: !44, isLocal: false, isDefinition: true)
!262 = !DIGlobalVariableExpression(var: !263, expr: !DIExpression())
!263 = distinct !DIGlobalVariable(name: "config_seccomp_filter_add", scope: !242, file: !243, line: 38, type: !44, isLocal: false, isDefinition: true)
!264 = !DIGlobalVariableExpression(var: !265, expr: !DIExpression())
!265 = distinct !DIGlobalVariable(name: "whitelist_reject_topdirs", scope: !242, file: !243, line: 39, type: !266, isLocal: false, isDefinition: true)
!266 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !44, size: 64)
!267 = !DIGlobalVariableExpression(var: !268, expr: !DIExpression())
!268 = distinct !DIGlobalVariable(name: "compiletime_support", scope: !242, file: !243, line: 308, type: !269, isLocal: true, isDefinition: true)
!269 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !270)
!270 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !271, size: 64)
!271 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !45)
!272 = !DIGlobalVariableExpression(var: !273, expr: !DIExpression())
!273 = distinct !DIGlobalVariable(name: "cfg_val", scope: !242, file: !243, line: 29, type: !274, isLocal: true, isDefinition: true)
!274 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 1056, elements: !275)
!275 = !{!276}
!276 = !DISubrange(count: 33)
!277 = !DIGlobalVariableExpression(var: !278, expr: !DIExpression())
!278 = distinct !DIGlobalVariable(name: "initialized", scope: !242, file: !243, line: 28, type: !11, isLocal: true, isDefinition: true)
!279 = distinct !DICompileUnit(language: DW_LANG_C99, file: !280, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, retainedTypes: !39, splitDebugInlining: false, nameTableKind: None)
!280 = !DIFile(filename: "chroot.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "68e753182a5e16b0398937f350b5f282")
!281 = !{!9}
!282 = distinct !DICompileUnit(language: DW_LANG_C99, file: !283, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !284, splitDebugInlining: false, nameTableKind: None)
!283 = !DIFile(filename: "cmdline.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "24f422a7e2439d02b1c935b41a2bad5c")
!284 = !{!5}
!285 = distinct !DICompileUnit(language: DW_LANG_C99, file: !286, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !198, retainedTypes: !287, splitDebugInlining: false, nameTableKind: None)
!286 = !DIFile(filename: "cpu.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "fc98c2fb682237ca208d9905d54a25ba")
!287 = !{!40, !11, !56, !288, !290}
!288 = !DIDerivedType(tag: DW_TAG_typedef, name: "__cpu_mask", file: !289, line: 32, baseType: !48)
!289 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/cpu-set.h", directory: "", checksumkind: CSK_MD5, checksum: "f73af5e9cc2411157f5653d3d0ced471")
!290 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !288, size: 64)
!291 = distinct !DICompileUnit(language: DW_LANG_C99, file: !292, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !293, retainedTypes: !299, globals: !303, splitDebugInlining: false, nameTableKind: None)
!292 = !DIFile(filename: "dbus.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "8f66e149b8e5d7750af13adddd8e2ff1")
!293 = !{!294, !3, !136}
!294 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 362, baseType: !5, size: 32, elements: !295)
!295 = !{!296, !297, !298}
!296 = !DIEnumerator(name: "DBUS_POLICY_ALLOW", value: 0)
!297 = !DIEnumerator(name: "DBUS_POLICY_FILTER", value: 1)
!298 = !DIEnumerator(name: "DBUS_POLICY_BLOCK", value: 2)
!299 = !{!40, !52, !11, !300}
!300 = !DIDerivedType(tag: DW_TAG_typedef, name: "ssize_t", file: !301, line: 77, baseType: !302)
!301 = !DIFile(filename: "/usr/include/stdio.h", directory: "", checksumkind: CSK_MD5, checksum: "5b917eded35ce2507d1e294bf8cb74d7")
!302 = !DIDerivedType(tag: DW_TAG_typedef, name: "__ssize_t", file: !55, line: 193, baseType: !189)
!303 = !{!304, !306, !311, !313}
!304 = !DIGlobalVariableExpression(var: !305, expr: !DIExpression())
!305 = distinct !DIGlobalVariable(name: "dbus_proxy_status_fd", scope: !291, file: !292, line: 48, type: !11, isLocal: true, isDefinition: true)
!306 = !DIGlobalVariableExpression(var: !307, expr: !DIExpression())
!307 = distinct !DIGlobalVariable(name: "dbus_proxy_pid", scope: !291, file: !292, line: 47, type: !308, isLocal: true, isDefinition: true)
!308 = !DIDerivedType(tag: DW_TAG_typedef, name: "pid_t", file: !309, line: 97, baseType: !310)
!309 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/sys/types.h", directory: "", checksumkind: CSK_MD5, checksum: "20e2108af45064f5c7b77fc9416f0cce")
!310 = !DIDerivedType(tag: DW_TAG_typedef, name: "__pid_t", file: !55, line: 154, baseType: !11)
!311 = !DIGlobalVariableExpression(var: !312, expr: !DIExpression())
!312 = distinct !DIGlobalVariable(name: "dbus_user_proxy_socket", scope: !291, file: !292, line: 49, type: !44, isLocal: true, isDefinition: true)
!313 = !DIGlobalVariableExpression(var: !314, expr: !DIExpression())
!314 = distinct !DIGlobalVariable(name: "dbus_system_proxy_socket", scope: !291, file: !292, line: 50, type: !44, isLocal: true, isDefinition: true)
!315 = distinct !DICompileUnit(language: DW_LANG_C99, file: !316, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !317, globals: !318, splitDebugInlining: false, nameTableKind: None)
!316 = !DIFile(filename: "dhcp.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "10ca8f453ccf40fbfe85cf9df8349dcd")
!317 = !{!189, !173, !44, !308}
!318 = !{!319, !321, !323, !338}
!319 = !DIGlobalVariableExpression(var: !320, expr: !DIExpression())
!320 = distinct !DIGlobalVariable(name: "dhclient4_pid", scope: !315, file: !316, line: 29, type: !308, isLocal: false, isDefinition: true)
!321 = !DIGlobalVariableExpression(var: !322, expr: !DIExpression())
!322 = distinct !DIGlobalVariable(name: "dhclient6_pid", scope: !315, file: !316, line: 30, type: !308, isLocal: false, isDefinition: true)
!323 = !DIGlobalVariableExpression(var: !324, expr: !DIExpression())
!324 = distinct !DIGlobalVariable(name: "dhclient4", scope: !315, file: !316, line: 42, type: !325, isLocal: true, isDefinition: true)
!325 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !326)
!326 = !DIDerivedType(tag: DW_TAG_typedef, name: "Dhclient", file: !316, line: 40, baseType: !327)
!327 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !316, line: 32, size: 448, elements: !328)
!328 = !{!329, !330, !331, !332, !333, !334, !336}
!329 = !DIDerivedType(tag: DW_TAG_member, name: "version_arg", scope: !327, file: !316, line: 33, baseType: !44, size: 64)
!330 = !DIDerivedType(tag: DW_TAG_member, name: "pid_file", scope: !327, file: !316, line: 34, baseType: !44, size: 64, offset: 64)
!331 = !DIDerivedType(tag: DW_TAG_member, name: "leases_file", scope: !327, file: !316, line: 35, baseType: !44, size: 64, offset: 128)
!332 = !DIDerivedType(tag: DW_TAG_member, name: "generate_duid", scope: !327, file: !316, line: 36, baseType: !174, size: 8, offset: 192)
!333 = !DIDerivedType(tag: DW_TAG_member, name: "duid_leases_file", scope: !327, file: !316, line: 37, baseType: !44, size: 64, offset: 256)
!334 = !DIDerivedType(tag: DW_TAG_member, name: "pid", scope: !327, file: !316, line: 38, baseType: !335, size: 64, offset: 320)
!335 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !308, size: 64)
!336 = !DIDerivedType(tag: DW_TAG_member, name: "arg_offset", scope: !327, file: !316, line: 39, baseType: !337, size: 64, offset: 384)
!337 = !DIDerivedType(tag: DW_TAG_typedef, name: "ptrdiff_t", file: !53, line: 35, baseType: !189)
!338 = !DIGlobalVariableExpression(var: !339, expr: !DIExpression())
!339 = distinct !DIGlobalVariable(name: "dhclient6", scope: !315, file: !316, line: 51, type: !325, isLocal: true, isDefinition: true)
!340 = distinct !DICompileUnit(language: DW_LANG_C99, file: !341, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !342, retainedTypes: !39, globals: !343, splitDebugInlining: false, nameTableKind: None)
!341 = !DIFile(filename: "env.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "3a5bccfc9e130fe0e10b50cb96387c38")
!342 = !{!3, !136}
!343 = !{!344, !356, !361}
!344 = !DIGlobalVariableExpression(var: !345, expr: !DIExpression())
!345 = distinct !DIGlobalVariable(name: "envlist", scope: !340, file: !341, line: 33, type: !346, isLocal: true, isDefinition: true)
!346 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !347, size: 64)
!347 = !DIDerivedType(tag: DW_TAG_typedef, name: "Env", file: !341, line: 32, baseType: !348)
!348 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "env_t", file: !341, line: 27, size: 256, elements: !349)
!349 = !{!350, !352, !353, !354}
!350 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !348, file: !341, line: 28, baseType: !351, size: 64)
!351 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !348, size: 64)
!352 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !348, file: !341, line: 29, baseType: !270, size: 64, offset: 64)
!353 = !DIDerivedType(tag: DW_TAG_member, name: "value", scope: !348, file: !341, line: 30, baseType: !270, size: 64, offset: 128)
!354 = !DIDerivedType(tag: DW_TAG_member, name: "op", scope: !348, file: !341, line: 31, baseType: !355, size: 32, offset: 192)
!355 = !DIDerivedType(tag: DW_TAG_typedef, name: "ENV_OP", file: !4, line: 724, baseType: !3)
!356 = !DIGlobalVariableExpression(var: !357, expr: !DIExpression())
!357 = distinct !DIGlobalVariable(name: "env_whitelist", scope: !340, file: !341, line: 259, type: !358, isLocal: true, isDefinition: true)
!358 = !DICompositeType(tag: DW_TAG_array_type, baseType: !269, size: 256, elements: !359)
!359 = !{!360}
!360 = !DISubrange(count: 4)
!361 = !DIGlobalVariableExpression(var: !362, expr: !DIExpression())
!362 = distinct !DIGlobalVariable(name: "env_whitelist_sbox", scope: !340, file: !341, line: 267, type: !363, isLocal: true, isDefinition: true)
!363 = !DICompositeType(tag: DW_TAG_array_type, baseType: !269, size: 448, elements: !364)
!364 = !{!365}
!365 = !DISubrange(count: 7)
!366 = distinct !DICompileUnit(language: DW_LANG_C99, file: !367, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !368, retainedTypes: !385, globals: !387, splitDebugInlining: false, nameTableKind: None)
!367 = !DIFile(filename: "fs.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a652c57224411ee21cd0b073b61af829")
!368 = !{!369, !9, !379}
!369 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 422, baseType: !5, size: 32, elements: !370)
!370 = !{!371, !372, !373, !374, !375, !376, !377, !378}
!371 = !DIEnumerator(name: "BLACKLIST_FILE", value: 0)
!372 = !DIEnumerator(name: "BLACKLIST_NOLOG", value: 1)
!373 = !DIEnumerator(name: "MOUNT_READONLY", value: 2)
!374 = !DIEnumerator(name: "MOUNT_TMPFS", value: 3)
!375 = !DIEnumerator(name: "MOUNT_NOEXEC", value: 4)
!376 = !DIEnumerator(name: "MOUNT_RDWR", value: 5)
!377 = !DIEnumerator(name: "MOUNT_RDWR_NOCHECK", value: 6)
!378 = !DIEnumerator(name: "OPERATION_MAX", value: 7)
!379 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !10, line: 122, baseType: !5, size: 32, elements: !380)
!380 = !{!381, !382, !383, !384}
!381 = !DIEnumerator(name: "MNT_FORCE", value: 1)
!382 = !DIEnumerator(name: "MNT_DETACH", value: 2)
!383 = !DIEnumerator(name: "MNT_EXPIRE", value: 4)
!384 = !DIEnumerator(name: "UMOUNT_NOFOLLOW", value: 8)
!385 = !{!40, !386}
!386 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !270, size: 64)
!387 = !{!388}
!388 = !DIGlobalVariableExpression(var: !389, expr: !DIExpression())
!389 = distinct !DIGlobalVariable(name: "opstr", scope: !366, file: !367, line: 45, type: !390, isLocal: true, isDefinition: true)
!390 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 448, elements: !364)
!391 = distinct !DICompileUnit(language: DW_LANG_C99, file: !392, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !393, retainedTypes: !39, globals: !394, splitDebugInlining: false, nameTableKind: None)
!392 = !DIFile(filename: "fs_bin.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a3b6075c0d0e34a7321cb4a772a9be4c")
!393 = !{!9, !136}
!394 = !{!395, !400}
!395 = !DIGlobalVariableExpression(var: !396, expr: !DIExpression())
!396 = distinct !DIGlobalVariable(name: "paths", scope: !391, file: !392, line: 30, type: !397, isLocal: true, isDefinition: true)
!397 = !DICompositeType(tag: DW_TAG_array_type, baseType: !269, size: 576, elements: !398)
!398 = !{!399}
!399 = !DISubrange(count: 9)
!400 = !DIGlobalVariableExpression(var: !401, expr: !DIExpression())
!401 = distinct !DIGlobalVariable(name: "prog_cnt", scope: !391, file: !392, line: 28, type: !11, isLocal: true, isDefinition: true)
!402 = distinct !DICompileUnit(language: DW_LANG_C99, file: !403, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !404, retainedTypes: !415, globals: !416, splitDebugInlining: false, nameTableKind: None)
!403 = !DIFile(filename: "fs_dev.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "b46180bb6025398645813f1c2d98f6a9")
!404 = !{!9, !405}
!405 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !403, line: 35, baseType: !5, size: 32, elements: !406)
!406 = !{!407, !408, !409, !410, !411, !412, !413, !414}
!407 = !DIEnumerator(name: "DEV_NONE", value: 0)
!408 = !DIEnumerator(name: "DEV_SOUND", value: 1)
!409 = !DIEnumerator(name: "DEV_3D", value: 2)
!410 = !DIEnumerator(name: "DEV_VIDEO", value: 3)
!411 = !DIEnumerator(name: "DEV_TV", value: 4)
!412 = !DIEnumerator(name: "DEV_DVD", value: 5)
!413 = !DIEnumerator(name: "DEV_U2F", value: 6)
!414 = !DIEnumerator(name: "DEV_INPUT", value: 7)
!415 = !{!11, !40}
!416 = !{!417}
!417 = !DIGlobalVariableExpression(var: !418, expr: !DIExpression())
!418 = distinct !DIGlobalVariable(name: "dev", scope: !402, file: !403, line: 53, type: !419, isLocal: true, isDefinition: true)
!419 = !DICompositeType(tag: DW_TAG_array_type, baseType: !420, size: 7680, elements: !427)
!420 = !DIDerivedType(tag: DW_TAG_typedef, name: "DevEntry", file: !403, line: 51, baseType: !421)
!421 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !403, line: 47, size: 192, elements: !422)
!422 = !{!423, !424, !425}
!423 = !DIDerivedType(tag: DW_TAG_member, name: "dev_fname", scope: !421, file: !403, line: 48, baseType: !270, size: 64)
!424 = !DIDerivedType(tag: DW_TAG_member, name: "run_fname", scope: !421, file: !403, line: 49, baseType: !270, size: 64, offset: 64)
!425 = !DIDerivedType(tag: DW_TAG_member, name: "type", scope: !421, file: !403, line: 50, baseType: !426, size: 32, offset: 128)
!426 = !DIDerivedType(tag: DW_TAG_typedef, name: "DEV_TYPE", file: !403, line: 44, baseType: !405)
!427 = !{!428}
!428 = !DISubrange(count: 40)
!429 = distinct !DICompileUnit(language: DW_LANG_C99, file: !430, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, retainedTypes: !39, globals: !431, splitDebugInlining: false, nameTableKind: None)
!430 = !DIFile(filename: "fs_etc.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "7bdb2327eedb4c5327eb1f61d8fa642c")
!431 = !{!432, !438, !440, !445, !447, !449, !454}
!432 = !DIGlobalVariableExpression(var: !433, expr: !DIExpression())
!433 = distinct !DIGlobalVariable(name: "etc_list", scope: !429, file: !434, line: 28, type: !435, isLocal: true, isDefinition: true)
!434 = !DIFile(filename: "./../include/etc_groups.h", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a0b7a3f66139952137c1eedb482f5e8e")
!435 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 16448, elements: !436)
!436 = !{!437}
!437 = !DISubrange(count: 257)
!438 = !DIGlobalVariableExpression(var: !439, expr: !DIExpression())
!439 = distinct !DIGlobalVariable(name: "etc_cnt", scope: !429, file: !430, line: 30, type: !11, isLocal: true, isDefinition: true)
!440 = !DIGlobalVariableExpression(var: !441, expr: !DIExpression())
!441 = distinct !DIGlobalVariable(name: "etc_group_network", scope: !429, file: !434, line: 60, type: !442, isLocal: true, isDefinition: true)
!442 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 320, elements: !443)
!443 = !{!444}
!444 = !DISubrange(count: 5)
!445 = !DIGlobalVariableExpression(var: !446, expr: !DIExpression())
!446 = distinct !DIGlobalVariable(name: "etc_group_sound", scope: !429, file: !434, line: 69, type: !442, isLocal: true, isDefinition: true)
!447 = !DIGlobalVariableExpression(var: !448, expr: !DIExpression())
!448 = distinct !DIGlobalVariable(name: "etc_group_tls_ca", scope: !429, file: !434, line: 78, type: !442, isLocal: true, isDefinition: true)
!449 = !DIGlobalVariableExpression(var: !450, expr: !DIExpression())
!450 = distinct !DIGlobalVariable(name: "etc_group_x11", scope: !429, file: !434, line: 87, type: !451, isLocal: true, isDefinition: true)
!451 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 960, elements: !452)
!452 = !{!453}
!453 = !DISubrange(count: 15)
!454 = !DIGlobalVariableExpression(var: !455, expr: !DIExpression())
!455 = distinct !DIGlobalVariable(name: "etc_group_games", scope: !429, file: !434, line: 52, type: !456, isLocal: true, isDefinition: true)
!456 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 256, elements: !359)
!457 = distinct !DICompileUnit(language: DW_LANG_C99, file: !458, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, retainedTypes: !39, splitDebugInlining: false, nameTableKind: None)
!458 = !DIFile(filename: "fs_home.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "661fab75e0341a3e0d2b7efdaf9dff7c")
!459 = distinct !DICompileUnit(language: DW_LANG_C99, file: !460, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, splitDebugInlining: false, nameTableKind: None)
!460 = !DIFile(filename: "fs_hostname.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "4b7087e03e6a0766bd16e53730c867e0")
!461 = distinct !DICompileUnit(language: DW_LANG_C99, file: !462, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!462 = !DIFile(filename: "fs_lib.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "ea56d1d1b82f09aef0eb1a69cba3d4c0")
!463 = distinct !DICompileUnit(language: DW_LANG_C99, file: !464, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!464 = !DIFile(filename: "fs_lib2.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "69dc0a0f1b3bcd6f307975f4fae46eb2")
!465 = distinct !DICompileUnit(language: DW_LANG_C99, file: !466, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !467, splitDebugInlining: false, nameTableKind: None)
!466 = !DIFile(filename: "fs_logger.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "17ef04c64c79bd2b2109d84d202f1f0d")
!467 = !{!468, !481}
!468 = !DIGlobalVariableExpression(var: !469, expr: !DIExpression())
!469 = distinct !DIGlobalVariable(name: "last", scope: !470, file: !466, line: 45, type: !473, isLocal: true, isDefinition: true)
!470 = distinct !DISubprogram(name: "insertmsg", scope: !466, file: !466, line: 44, type: !471, scopeLine: 44, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !465, retainedNodes: !480)
!471 = !DISubroutineType(types: !472)
!472 = !{null, !473}
!473 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !474, size: 64)
!474 = !DIDerivedType(tag: DW_TAG_typedef, name: "FsMsg", file: !466, line: 32, baseType: !475)
!475 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "fs_msg_t", file: !466, line: 29, size: 128, elements: !476)
!476 = !{!477, !479}
!477 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !475, file: !466, line: 30, baseType: !478, size: 64)
!478 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !475, size: 64)
!479 = !DIDerivedType(tag: DW_TAG_member, name: "msg", scope: !475, file: !466, line: 31, baseType: !44, size: 64, offset: 64)
!480 = !{}
!481 = !DIGlobalVariableExpression(var: !482, expr: !DIExpression())
!482 = distinct !DIGlobalVariable(name: "head", scope: !465, file: !466, line: 34, type: !473, isLocal: true, isDefinition: true)
!483 = distinct !DICompileUnit(language: DW_LANG_C99, file: !484, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!484 = !DIFile(filename: "fs_mkdir.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "4e275d46d05a6159ac01350ce1f48c84")
!485 = distinct !DICompileUnit(language: DW_LANG_C99, file: !486, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!486 = !DIFile(filename: "fs_overlayfs.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "b19302f954e8989eea43dd85bfd6796e")
!487 = distinct !DICompileUnit(language: DW_LANG_C99, file: !488, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !489, splitDebugInlining: false, nameTableKind: None)
!488 = !DIFile(filename: "fs_trace.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "7c0129fc392faf0649ca7021a7ef7b76")
!489 = !{!369, !9}
!490 = distinct !DICompileUnit(language: DW_LANG_C99, file: !491, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !492, retainedTypes: !505, globals: !506, splitDebugInlining: false, nameTableKind: None)
!491 = !DIFile(filename: "fs_var.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "4e7aea782631c53027bd26baf695c383")
!492 = !{!9, !493}
!493 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !494, line: 97, baseType: !5, size: 32, elements: !495)
!494 = !DIFile(filename: "/usr/include/dirent.h", directory: "", checksumkind: CSK_MD5, checksum: "33c45a2c20a17fc93667c8d9aa922ab0")
!495 = !{!496, !497, !498, !499, !500, !501, !502, !503, !504}
!496 = !DIEnumerator(name: "DT_UNKNOWN", value: 0)
!497 = !DIEnumerator(name: "DT_FIFO", value: 1)
!498 = !DIEnumerator(name: "DT_CHR", value: 2)
!499 = !DIEnumerator(name: "DT_DIR", value: 4)
!500 = !DIEnumerator(name: "DT_BLK", value: 6)
!501 = !DIEnumerator(name: "DT_REG", value: 8)
!502 = !DIEnumerator(name: "DT_LNK", value: 10)
!503 = !DIEnumerator(name: "DT_SOCK", value: 12)
!504 = !DIEnumerator(name: "DT_WHT", value: 14)
!505 = !{!40, !5}
!506 = !{!507}
!507 = !DIGlobalVariableExpression(var: !508, expr: !DIExpression())
!508 = distinct !DIGlobalVariable(name: "dirlist", scope: !490, file: !491, line: 38, type: !509, isLocal: true, isDefinition: true)
!509 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !510, size: 64)
!510 = !DIDerivedType(tag: DW_TAG_typedef, name: "DirData", file: !491, line: 36, baseType: !511)
!511 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "dirdata_t", file: !491, line: 30, size: 256, elements: !512)
!512 = !{!513, !515, !516, !519, !522}
!513 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !511, file: !491, line: 31, baseType: !514, size: 64)
!514 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !511, size: 64)
!515 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !511, file: !491, line: 32, baseType: !44, size: 64, offset: 64)
!516 = !DIDerivedType(tag: DW_TAG_member, name: "st_mode", scope: !511, file: !491, line: 33, baseType: !517, size: 32, offset: 128)
!517 = !DIDerivedType(tag: DW_TAG_typedef, name: "mode_t", file: !309, line: 69, baseType: !518)
!518 = !DIDerivedType(tag: DW_TAG_typedef, name: "__mode_t", file: !55, line: 150, baseType: !5)
!519 = !DIDerivedType(tag: DW_TAG_member, name: "st_uid", scope: !511, file: !491, line: 34, baseType: !520, size: 32, offset: 160)
!520 = !DIDerivedType(tag: DW_TAG_typedef, name: "uid_t", file: !309, line: 79, baseType: !521)
!521 = !DIDerivedType(tag: DW_TAG_typedef, name: "__uid_t", file: !55, line: 146, baseType: !5)
!522 = !DIDerivedType(tag: DW_TAG_member, name: "st_gid", scope: !511, file: !491, line: 35, baseType: !523, size: 32, offset: 192)
!523 = !DIDerivedType(tag: DW_TAG_typedef, name: "gid_t", file: !309, line: 64, baseType: !524)
!524 = !DIDerivedType(tag: DW_TAG_typedef, name: "__gid_t", file: !55, line: 147, baseType: !5)
!525 = distinct !DICompileUnit(language: DW_LANG_C99, file: !526, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !527, splitDebugInlining: false, nameTableKind: None)
!526 = !DIFile(filename: "fs_whitelist.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "cb48389ec5a9bd236533392caff272a0")
!527 = !{!528, !530, !534, !536}
!528 = !DIGlobalVariableExpression(var: !529, expr: !DIExpression())
!529 = distinct !DIGlobalVariable(name: "runuser", scope: !525, file: !526, line: 41, type: !44, isLocal: true, isDefinition: true)
!530 = !DIGlobalVariableExpression(var: !531, expr: !DIExpression())
!531 = distinct !DIGlobalVariable(name: "runuser_len", scope: !525, file: !526, line: 40, type: !532, isLocal: true, isDefinition: true)
!532 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !533, line: 29, baseType: !48)
!533 = !DIFile(filename: "/usr/include/glob.h", directory: "", checksumkind: CSK_MD5, checksum: "2eb9a705d5721143a3036fa1f94bfe19")
!534 = !DIGlobalVariableExpression(var: !535, expr: !DIExpression())
!535 = distinct !DIGlobalVariable(name: "homedir_len", scope: !525, file: !526, line: 39, type: !532, isLocal: true, isDefinition: true)
!536 = !DIGlobalVariableExpression(var: !537, expr: !DIExpression())
!537 = distinct !DIGlobalVariable(name: "cnt", scope: !538, file: !526, line: 478, type: !11, isLocal: true, isDefinition: true)
!538 = distinct !DISubprogram(name: "add_topdir", scope: !526, file: !526, line: 437, type: !539, scopeLine: 437, flags: DIFlagPrototyped, spFlags: DISPFlagLocalToUnit | DISPFlagDefinition, unit: !525, retainedNodes: !480)
!539 = !DISubroutineType(types: !540)
!540 = !{!541, !270, !541, !270}
!541 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !542, size: 64)
!542 = !DIDerivedType(tag: DW_TAG_typedef, name: "TopDir", file: !4, line: 138, baseType: !543)
!543 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "topdir_t", file: !4, line: 135, size: 128, elements: !544)
!544 = !{!545, !546}
!545 = !DIDerivedType(tag: DW_TAG_member, name: "path", scope: !543, file: !4, line: 136, baseType: !44, size: 64)
!546 = !DIDerivedType(tag: DW_TAG_member, name: "fd", scope: !543, file: !4, line: 137, baseType: !11, size: 32, offset: 64)
!547 = distinct !DICompileUnit(language: DW_LANG_C99, file: !548, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!548 = !DIFile(filename: "ids.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "c64563594b289cb3caf301b97620232e")
!549 = distinct !DICompileUnit(language: DW_LANG_C99, file: !550, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !551, retainedTypes: !552, globals: !559, splitDebugInlining: false, nameTableKind: None)
!550 = !DIFile(filename: "join.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "18672b34bc2930ea2e3fff1f2d3eb810")
!551 = !{!3}
!552 = !{!40, !553, !558, !76}
!553 = !DIDerivedType(tag: DW_TAG_typedef, name: "__sighandler_t", file: !554, line: 72, baseType: !555)
!554 = !DIFile(filename: "/usr/include/signal.h", directory: "", checksumkind: CSK_MD5, checksum: "f0ccc98b488c777571beae1a47763d91")
!555 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !556, size: 64)
!556 = !DISubroutineType(types: !557)
!557 = !{null, !11}
!558 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!559 = !{!560, !562, !564}
!560 = !DIGlobalVariableExpression(var: !561, expr: !DIExpression())
!561 = distinct !DIGlobalVariable(name: "apply_caps", scope: !549, file: !550, line: 36, type: !11, isLocal: true, isDefinition: true)
!562 = !DIGlobalVariableExpression(var: !563, expr: !DIExpression())
!563 = distinct !DIGlobalVariable(name: "caps", scope: !549, file: !550, line: 37, type: !80, isLocal: true, isDefinition: true)
!564 = !DIGlobalVariableExpression(var: !565, expr: !DIExpression())
!565 = distinct !DIGlobalVariable(name: "display", scope: !549, file: !550, line: 38, type: !5, isLocal: true, isDefinition: true)
!566 = distinct !DICompileUnit(language: DW_LANG_C99, file: !567, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !568, retainedTypes: !576, globals: !577, splitDebugInlining: false, nameTableKind: None)
!567 = !DIFile(filename: "ls.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "7a3137c9f89e240ab906435dccfa51de")
!568 = !{!199, !569}
!569 = !DICompositeType(tag: DW_TAG_enumeration_type, file: !4, line: 800, baseType: !5, size: 32, elements: !570)
!570 = !{!571, !572, !573, !574, !575}
!571 = !DIEnumerator(name: "SANDBOX_FS_LS", value: 0)
!572 = !DIEnumerator(name: "SANDBOX_FS_CAT", value: 1)
!573 = !DIEnumerator(name: "SANDBOX_FS_GET", value: 2)
!574 = !DIEnumerator(name: "SANDBOX_FS_PUT", value: 3)
!575 = !DIEnumerator(name: "SANDBOX_FS_MAX", value: 4)
!576 = !{!11, !66, !56, !40}
!577 = !{!578, !580}
!578 = !DIGlobalVariableExpression(var: !579, expr: !DIExpression())
!579 = distinct !DIGlobalVariable(name: "c_uid", scope: !566, file: !567, line: 36, type: !520, isLocal: true, isDefinition: true)
!580 = !DIGlobalVariableExpression(var: !581, expr: !DIExpression())
!581 = distinct !DIGlobalVariable(name: "c_uid_name", scope: !566, file: !567, line: 37, type: !44, isLocal: true, isDefinition: true)
!582 = distinct !DICompileUnit(language: DW_LANG_C99, file: !583, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !584, splitDebugInlining: false, nameTableKind: None)
!583 = !DIFile(filename: "macros.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "1c4098662da7edd6b1cf35f26574e756")
!584 = !{!585}
!585 = !DIGlobalVariableExpression(var: !586, expr: !DIExpression())
!586 = distinct !DIGlobalVariable(name: "macro", scope: !582, file: !583, line: 33, type: !587, isLocal: false, isDefinition: true)
!587 = !DICompositeType(tag: DW_TAG_array_type, baseType: !588, size: 4032, elements: !364)
!588 = !DIDerivedType(tag: DW_TAG_typedef, name: "Macro", file: !583, line: 31, baseType: !589)
!589 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "macro_t", file: !583, line: 24, size: 576, elements: !590)
!590 = !{!591, !592, !593}
!591 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !589, file: !583, line: 25, baseType: !44, size: 64)
!592 = !DIDerivedType(tag: DW_TAG_member, name: "xdg", scope: !589, file: !583, line: 26, baseType: !44, size: 64, offset: 64)
!593 = !DIDerivedType(tag: DW_TAG_member, name: "translation", scope: !589, file: !583, line: 30, baseType: !390, size: 448, offset: 128)
!594 = distinct !DICompileUnit(language: DW_LANG_C99, file: !595, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !596, retainedTypes: !597, globals: !598, splitDebugInlining: false, nameTableKind: None)
!595 = !DIFile(filename: "main.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "3dcc36692dbaa45590cfb26c891adf9e")
!596 = !{!294, !3, !136, !569}
!597 = !{!40, !553, !558, !66}
!598 = !{!599, !601, !603, !605, !607, !609, !611, !613, !615, !617, !619, !621, !623, !625, !627, !629, !631, !633, !635, !637, !639, !641, !643, !645, !647, !649, !651, !653, !655, !657, !659, !661, !663, !665, !667, !669, !671, !673, !675, !677, !679, !681, !683, !685, !687, !689, !691, !693, !695, !697, !699, !701, !703, !705, !707, !709, !711, !713, !715, !717, !719, !721, !723, !725, !727, !729, !731, !733, !735, !738, !740, !742, !744, !746, !748, !750, !752, !754, !756, !758, !760, !762, !764, !766, !768, !770, !773, !775, !777, !779, !781, !783, !785, !787, !789, !791, !793, !795, !800, !920, !922, !924, !926, !931, !933, !938, !940}
!599 = !DIGlobalVariableExpression(var: !600, expr: !DIExpression())
!600 = distinct !DIGlobalVariable(name: "firejail_uid", scope: !594, file: !595, line: 58, type: !520, isLocal: false, isDefinition: true)
!601 = !DIGlobalVariableExpression(var: !602, expr: !DIExpression())
!602 = distinct !DIGlobalVariable(name: "firejail_gid", scope: !594, file: !595, line: 59, type: !523, isLocal: false, isDefinition: true)
!603 = !DIGlobalVariableExpression(var: !604, expr: !DIExpression())
!604 = distinct !DIGlobalVariable(name: "arg_private", scope: !594, file: !595, line: 66, type: !11, isLocal: false, isDefinition: true)
!605 = !DIGlobalVariableExpression(var: !606, expr: !DIExpression())
!606 = distinct !DIGlobalVariable(name: "arg_private_cache", scope: !594, file: !595, line: 67, type: !11, isLocal: false, isDefinition: true)
!607 = !DIGlobalVariableExpression(var: !608, expr: !DIExpression())
!608 = distinct !DIGlobalVariable(name: "arg_debug", scope: !594, file: !595, line: 68, type: !11, isLocal: false, isDefinition: true)
!609 = !DIGlobalVariableExpression(var: !610, expr: !DIExpression())
!610 = distinct !DIGlobalVariable(name: "arg_debug_blacklists", scope: !594, file: !595, line: 69, type: !11, isLocal: false, isDefinition: true)
!611 = !DIGlobalVariableExpression(var: !612, expr: !DIExpression())
!612 = distinct !DIGlobalVariable(name: "arg_debug_whitelists", scope: !594, file: !595, line: 70, type: !11, isLocal: false, isDefinition: true)
!613 = !DIGlobalVariableExpression(var: !614, expr: !DIExpression())
!614 = distinct !DIGlobalVariable(name: "arg_debug_private_lib", scope: !594, file: !595, line: 71, type: !11, isLocal: false, isDefinition: true)
!615 = !DIGlobalVariableExpression(var: !616, expr: !DIExpression())
!616 = distinct !DIGlobalVariable(name: "arg_nonetwork", scope: !594, file: !595, line: 72, type: !11, isLocal: false, isDefinition: true)
!617 = !DIGlobalVariableExpression(var: !618, expr: !DIExpression())
!618 = distinct !DIGlobalVariable(name: "arg_command", scope: !594, file: !595, line: 73, type: !11, isLocal: false, isDefinition: true)
!619 = !DIGlobalVariableExpression(var: !620, expr: !DIExpression())
!620 = distinct !DIGlobalVariable(name: "arg_overlay", scope: !594, file: !595, line: 74, type: !11, isLocal: false, isDefinition: true)
!621 = !DIGlobalVariableExpression(var: !622, expr: !DIExpression())
!622 = distinct !DIGlobalVariable(name: "arg_overlay_keep", scope: !594, file: !595, line: 75, type: !11, isLocal: false, isDefinition: true)
!623 = !DIGlobalVariableExpression(var: !624, expr: !DIExpression())
!624 = distinct !DIGlobalVariable(name: "arg_overlay_reuse", scope: !594, file: !595, line: 76, type: !11, isLocal: false, isDefinition: true)
!625 = !DIGlobalVariableExpression(var: !626, expr: !DIExpression())
!626 = distinct !DIGlobalVariable(name: "arg_seccomp", scope: !594, file: !595, line: 78, type: !11, isLocal: false, isDefinition: true)
!627 = !DIGlobalVariableExpression(var: !628, expr: !DIExpression())
!628 = distinct !DIGlobalVariable(name: "arg_seccomp32", scope: !594, file: !595, line: 79, type: !11, isLocal: false, isDefinition: true)
!629 = !DIGlobalVariableExpression(var: !630, expr: !DIExpression())
!630 = distinct !DIGlobalVariable(name: "arg_seccomp_postexec", scope: !594, file: !595, line: 80, type: !11, isLocal: false, isDefinition: true)
!631 = !DIGlobalVariableExpression(var: !632, expr: !DIExpression())
!632 = distinct !DIGlobalVariable(name: "arg_seccomp_block_secondary", scope: !594, file: !595, line: 81, type: !11, isLocal: false, isDefinition: true)
!633 = !DIGlobalVariableExpression(var: !634, expr: !DIExpression())
!634 = distinct !DIGlobalVariable(name: "arg_seccomp_error_action", scope: !594, file: !595, line: 82, type: !11, isLocal: false, isDefinition: true)
!635 = !DIGlobalVariableExpression(var: !636, expr: !DIExpression())
!636 = distinct !DIGlobalVariable(name: "arg_caps_default_filter", scope: !594, file: !595, line: 84, type: !11, isLocal: false, isDefinition: true)
!637 = !DIGlobalVariableExpression(var: !638, expr: !DIExpression())
!638 = distinct !DIGlobalVariable(name: "arg_caps_drop", scope: !594, file: !595, line: 85, type: !11, isLocal: false, isDefinition: true)
!639 = !DIGlobalVariableExpression(var: !640, expr: !DIExpression())
!640 = distinct !DIGlobalVariable(name: "arg_caps_drop_all", scope: !594, file: !595, line: 86, type: !11, isLocal: false, isDefinition: true)
!641 = !DIGlobalVariableExpression(var: !642, expr: !DIExpression())
!642 = distinct !DIGlobalVariable(name: "arg_caps_keep", scope: !594, file: !595, line: 87, type: !11, isLocal: false, isDefinition: true)
!643 = !DIGlobalVariableExpression(var: !644, expr: !DIExpression())
!644 = distinct !DIGlobalVariable(name: "arg_caps_list", scope: !594, file: !595, line: 88, type: !44, isLocal: false, isDefinition: true)
!645 = !DIGlobalVariableExpression(var: !646, expr: !DIExpression())
!646 = distinct !DIGlobalVariable(name: "arg_trace", scope: !594, file: !595, line: 90, type: !11, isLocal: false, isDefinition: true)
!647 = !DIGlobalVariableExpression(var: !648, expr: !DIExpression())
!648 = distinct !DIGlobalVariable(name: "arg_tracefile", scope: !594, file: !595, line: 91, type: !44, isLocal: false, isDefinition: true)
!649 = !DIGlobalVariableExpression(var: !650, expr: !DIExpression())
!650 = distinct !DIGlobalVariable(name: "arg_tracelog", scope: !594, file: !595, line: 92, type: !11, isLocal: false, isDefinition: true)
!651 = !DIGlobalVariableExpression(var: !652, expr: !DIExpression())
!652 = distinct !DIGlobalVariable(name: "arg_rlimit_cpu", scope: !594, file: !595, line: 93, type: !11, isLocal: false, isDefinition: true)
!653 = !DIGlobalVariableExpression(var: !654, expr: !DIExpression())
!654 = distinct !DIGlobalVariable(name: "arg_rlimit_nofile", scope: !594, file: !595, line: 94, type: !11, isLocal: false, isDefinition: true)
!655 = !DIGlobalVariableExpression(var: !656, expr: !DIExpression())
!656 = distinct !DIGlobalVariable(name: "arg_rlimit_nproc", scope: !594, file: !595, line: 95, type: !11, isLocal: false, isDefinition: true)
!657 = !DIGlobalVariableExpression(var: !658, expr: !DIExpression())
!658 = distinct !DIGlobalVariable(name: "arg_rlimit_fsize", scope: !594, file: !595, line: 96, type: !11, isLocal: false, isDefinition: true)
!659 = !DIGlobalVariableExpression(var: !660, expr: !DIExpression())
!660 = distinct !DIGlobalVariable(name: "arg_rlimit_sigpending", scope: !594, file: !595, line: 97, type: !11, isLocal: false, isDefinition: true)
!661 = !DIGlobalVariableExpression(var: !662, expr: !DIExpression())
!662 = distinct !DIGlobalVariable(name: "arg_rlimit_as", scope: !594, file: !595, line: 98, type: !11, isLocal: false, isDefinition: true)
!663 = !DIGlobalVariableExpression(var: !664, expr: !DIExpression())
!664 = distinct !DIGlobalVariable(name: "arg_nogroups", scope: !594, file: !595, line: 99, type: !11, isLocal: false, isDefinition: true)
!665 = !DIGlobalVariableExpression(var: !666, expr: !DIExpression())
!666 = distinct !DIGlobalVariable(name: "arg_nonewprivs", scope: !594, file: !595, line: 103, type: !11, isLocal: false, isDefinition: true)
!667 = !DIGlobalVariableExpression(var: !668, expr: !DIExpression())
!668 = distinct !DIGlobalVariable(name: "arg_noroot", scope: !594, file: !595, line: 105, type: !11, isLocal: false, isDefinition: true)
!669 = !DIGlobalVariableExpression(var: !670, expr: !DIExpression())
!670 = distinct !DIGlobalVariable(name: "arg_netfilter_file", scope: !594, file: !595, line: 108, type: !44, isLocal: false, isDefinition: true)
!671 = !DIGlobalVariableExpression(var: !672, expr: !DIExpression())
!672 = distinct !DIGlobalVariable(name: "arg_netfilter6_file", scope: !594, file: !595, line: 109, type: !44, isLocal: false, isDefinition: true)
!673 = !DIGlobalVariableExpression(var: !674, expr: !DIExpression())
!674 = distinct !DIGlobalVariable(name: "arg_netns", scope: !594, file: !595, line: 110, type: !44, isLocal: false, isDefinition: true)
!675 = !DIGlobalVariableExpression(var: !676, expr: !DIExpression())
!676 = distinct !DIGlobalVariable(name: "arg_doubledash", scope: !594, file: !595, line: 111, type: !11, isLocal: false, isDefinition: true)
!677 = !DIGlobalVariableExpression(var: !678, expr: !DIExpression())
!678 = distinct !DIGlobalVariable(name: "arg_private_dev", scope: !594, file: !595, line: 112, type: !11, isLocal: false, isDefinition: true)
!679 = !DIGlobalVariableExpression(var: !680, expr: !DIExpression())
!680 = distinct !DIGlobalVariable(name: "arg_keep_dev_shm", scope: !594, file: !595, line: 113, type: !11, isLocal: false, isDefinition: true)
!681 = !DIGlobalVariableExpression(var: !682, expr: !DIExpression())
!682 = distinct !DIGlobalVariable(name: "arg_private_etc", scope: !594, file: !595, line: 114, type: !11, isLocal: false, isDefinition: true)
!683 = !DIGlobalVariableExpression(var: !684, expr: !DIExpression())
!684 = distinct !DIGlobalVariable(name: "arg_private_opt", scope: !594, file: !595, line: 115, type: !11, isLocal: false, isDefinition: true)
!685 = !DIGlobalVariableExpression(var: !686, expr: !DIExpression())
!686 = distinct !DIGlobalVariable(name: "arg_private_srv", scope: !594, file: !595, line: 116, type: !11, isLocal: false, isDefinition: true)
!687 = !DIGlobalVariableExpression(var: !688, expr: !DIExpression())
!688 = distinct !DIGlobalVariable(name: "arg_private_bin", scope: !594, file: !595, line: 117, type: !11, isLocal: false, isDefinition: true)
!689 = !DIGlobalVariableExpression(var: !690, expr: !DIExpression())
!690 = distinct !DIGlobalVariable(name: "arg_private_tmp", scope: !594, file: !595, line: 118, type: !11, isLocal: false, isDefinition: true)
!691 = !DIGlobalVariableExpression(var: !692, expr: !DIExpression())
!692 = distinct !DIGlobalVariable(name: "arg_private_lib", scope: !594, file: !595, line: 119, type: !11, isLocal: false, isDefinition: true)
!693 = !DIGlobalVariableExpression(var: !694, expr: !DIExpression())
!694 = distinct !DIGlobalVariable(name: "arg_private_cwd", scope: !594, file: !595, line: 120, type: !11, isLocal: false, isDefinition: true)
!695 = !DIGlobalVariableExpression(var: !696, expr: !DIExpression())
!696 = distinct !DIGlobalVariable(name: "arg_scan", scope: !594, file: !595, line: 121, type: !11, isLocal: false, isDefinition: true)
!697 = !DIGlobalVariableExpression(var: !698, expr: !DIExpression())
!698 = distinct !DIGlobalVariable(name: "arg_whitelist", scope: !594, file: !595, line: 122, type: !11, isLocal: false, isDefinition: true)
!699 = !DIGlobalVariableExpression(var: !700, expr: !DIExpression())
!700 = distinct !DIGlobalVariable(name: "arg_nosound", scope: !594, file: !595, line: 123, type: !11, isLocal: false, isDefinition: true)
!701 = !DIGlobalVariableExpression(var: !702, expr: !DIExpression())
!702 = distinct !DIGlobalVariable(name: "arg_novideo", scope: !594, file: !595, line: 124, type: !11, isLocal: false, isDefinition: true)
!703 = !DIGlobalVariableExpression(var: !704, expr: !DIExpression())
!704 = distinct !DIGlobalVariable(name: "arg_noprinters", scope: !594, file: !595, line: 126, type: !11, isLocal: false, isDefinition: true)
!705 = !DIGlobalVariableExpression(var: !706, expr: !DIExpression())
!706 = distinct !DIGlobalVariable(name: "arg_quiet", scope: !594, file: !595, line: 127, type: !11, isLocal: false, isDefinition: true)
!707 = !DIGlobalVariableExpression(var: !708, expr: !DIExpression())
!708 = distinct !DIGlobalVariable(name: "arg_join_network", scope: !594, file: !595, line: 128, type: !11, isLocal: false, isDefinition: true)
!709 = !DIGlobalVariableExpression(var: !710, expr: !DIExpression())
!710 = distinct !DIGlobalVariable(name: "arg_join_filesystem", scope: !594, file: !595, line: 129, type: !11, isLocal: false, isDefinition: true)
!711 = !DIGlobalVariableExpression(var: !712, expr: !DIExpression())
!712 = distinct !DIGlobalVariable(name: "arg_nice", scope: !594, file: !595, line: 130, type: !11, isLocal: false, isDefinition: true)
!713 = !DIGlobalVariableExpression(var: !714, expr: !DIExpression())
!714 = distinct !DIGlobalVariable(name: "arg_ipc", scope: !594, file: !595, line: 131, type: !11, isLocal: false, isDefinition: true)
!715 = !DIGlobalVariableExpression(var: !716, expr: !DIExpression())
!716 = distinct !DIGlobalVariable(name: "arg_writable_etc", scope: !594, file: !595, line: 132, type: !11, isLocal: false, isDefinition: true)
!717 = !DIGlobalVariableExpression(var: !718, expr: !DIExpression())
!718 = distinct !DIGlobalVariable(name: "arg_keep_config_pulse", scope: !594, file: !595, line: 133, type: !11, isLocal: false, isDefinition: true)
!719 = !DIGlobalVariableExpression(var: !720, expr: !DIExpression())
!720 = distinct !DIGlobalVariable(name: "arg_keep_shell_rc", scope: !594, file: !595, line: 134, type: !11, isLocal: false, isDefinition: true)
!721 = !DIGlobalVariableExpression(var: !722, expr: !DIExpression())
!722 = distinct !DIGlobalVariable(name: "arg_writable_var", scope: !594, file: !595, line: 135, type: !11, isLocal: false, isDefinition: true)
!723 = !DIGlobalVariableExpression(var: !724, expr: !DIExpression())
!724 = distinct !DIGlobalVariable(name: "arg_keep_var_tmp", scope: !594, file: !595, line: 136, type: !11, isLocal: false, isDefinition: true)
!725 = !DIGlobalVariableExpression(var: !726, expr: !DIExpression())
!726 = distinct !DIGlobalVariable(name: "arg_writable_run_user", scope: !594, file: !595, line: 137, type: !11, isLocal: false, isDefinition: true)
!727 = !DIGlobalVariableExpression(var: !728, expr: !DIExpression())
!728 = distinct !DIGlobalVariable(name: "arg_writable_var_log", scope: !594, file: !595, line: 138, type: !11, isLocal: false, isDefinition: true)
!729 = !DIGlobalVariableExpression(var: !730, expr: !DIExpression())
!730 = distinct !DIGlobalVariable(name: "arg_appimage", scope: !594, file: !595, line: 139, type: !11, isLocal: false, isDefinition: true)
!731 = !DIGlobalVariableExpression(var: !732, expr: !DIExpression())
!732 = distinct !DIGlobalVariable(name: "arg_apparmor", scope: !594, file: !595, line: 140, type: !11, isLocal: false, isDefinition: true)
!733 = !DIGlobalVariableExpression(var: !734, expr: !DIExpression())
!734 = distinct !DIGlobalVariable(name: "apparmor_profile", scope: !594, file: !595, line: 141, type: !44, isLocal: false, isDefinition: true)
!735 = !DIGlobalVariableExpression(var: !736, expr: !DIExpression())
!736 = distinct !DIGlobalVariable(name: "apparmor_replace", scope: !594, file: !595, line: 142, type: !737, isLocal: false, isDefinition: true)
!737 = !DIBasicType(name: "_Bool", size: 8, encoding: DW_ATE_boolean)
!738 = !DIGlobalVariableExpression(var: !739, expr: !DIExpression())
!739 = distinct !DIGlobalVariable(name: "arg_allow_debuggers", scope: !594, file: !595, line: 143, type: !11, isLocal: false, isDefinition: true)
!740 = !DIGlobalVariableExpression(var: !741, expr: !DIExpression())
!741 = distinct !DIGlobalVariable(name: "arg_x11_block", scope: !594, file: !595, line: 144, type: !11, isLocal: false, isDefinition: true)
!742 = !DIGlobalVariableExpression(var: !743, expr: !DIExpression())
!743 = distinct !DIGlobalVariable(name: "arg_x11_xorg", scope: !594, file: !595, line: 145, type: !11, isLocal: false, isDefinition: true)
!744 = !DIGlobalVariableExpression(var: !745, expr: !DIExpression())
!745 = distinct !DIGlobalVariable(name: "arg_allusers", scope: !594, file: !595, line: 146, type: !11, isLocal: false, isDefinition: true)
!746 = !DIGlobalVariableExpression(var: !747, expr: !DIExpression())
!747 = distinct !DIGlobalVariable(name: "arg_machineid", scope: !594, file: !595, line: 147, type: !11, isLocal: false, isDefinition: true)
!748 = !DIGlobalVariableExpression(var: !749, expr: !DIExpression())
!749 = distinct !DIGlobalVariable(name: "arg_allow_private_blacklist", scope: !594, file: !595, line: 148, type: !11, isLocal: false, isDefinition: true)
!750 = !DIGlobalVariableExpression(var: !751, expr: !DIExpression())
!751 = distinct !DIGlobalVariable(name: "arg_disable_mnt", scope: !594, file: !595, line: 149, type: !11, isLocal: false, isDefinition: true)
!752 = !DIGlobalVariableExpression(var: !753, expr: !DIExpression())
!753 = distinct !DIGlobalVariable(name: "arg_noprofile", scope: !594, file: !595, line: 150, type: !11, isLocal: false, isDefinition: true)
!754 = !DIGlobalVariableExpression(var: !755, expr: !DIExpression())
!755 = distinct !DIGlobalVariable(name: "arg_memory_deny_write_execute", scope: !594, file: !595, line: 151, type: !11, isLocal: false, isDefinition: true)
!756 = !DIGlobalVariableExpression(var: !757, expr: !DIExpression())
!757 = distinct !DIGlobalVariable(name: "arg_notv", scope: !594, file: !595, line: 152, type: !11, isLocal: false, isDefinition: true)
!758 = !DIGlobalVariableExpression(var: !759, expr: !DIExpression())
!759 = distinct !DIGlobalVariable(name: "arg_nodvd", scope: !594, file: !595, line: 153, type: !11, isLocal: false, isDefinition: true)
!760 = !DIGlobalVariableExpression(var: !761, expr: !DIExpression())
!761 = distinct !DIGlobalVariable(name: "arg_nou2f", scope: !594, file: !595, line: 154, type: !11, isLocal: false, isDefinition: true)
!762 = !DIGlobalVariableExpression(var: !763, expr: !DIExpression())
!763 = distinct !DIGlobalVariable(name: "arg_noinput", scope: !594, file: !595, line: 155, type: !11, isLocal: false, isDefinition: true)
!764 = !DIGlobalVariableExpression(var: !765, expr: !DIExpression())
!765 = distinct !DIGlobalVariable(name: "arg_deterministic_exit_code", scope: !594, file: !595, line: 156, type: !11, isLocal: false, isDefinition: true)
!766 = !DIGlobalVariableExpression(var: !767, expr: !DIExpression())
!767 = distinct !DIGlobalVariable(name: "arg_deterministic_shutdown", scope: !594, file: !595, line: 157, type: !11, isLocal: false, isDefinition: true)
!768 = !DIGlobalVariableExpression(var: !769, expr: !DIExpression())
!769 = distinct !DIGlobalVariable(name: "arg_keep_fd_all", scope: !594, file: !595, line: 158, type: !11, isLocal: false, isDefinition: true)
!770 = !DIGlobalVariableExpression(var: !771, expr: !DIExpression())
!771 = distinct !DIGlobalVariable(name: "arg_dbus_user", scope: !594, file: !595, line: 159, type: !772, isLocal: false, isDefinition: true)
!772 = !DIDerivedType(tag: DW_TAG_typedef, name: "DbusPolicy", file: !4, line: 366, baseType: !294)
!773 = !DIGlobalVariableExpression(var: !774, expr: !DIExpression())
!774 = distinct !DIGlobalVariable(name: "arg_dbus_system", scope: !594, file: !595, line: 160, type: !772, isLocal: false, isDefinition: true)
!775 = !DIGlobalVariableExpression(var: !776, expr: !DIExpression())
!776 = distinct !DIGlobalVariable(name: "arg_dbus_log_file", scope: !594, file: !595, line: 161, type: !270, isLocal: false, isDefinition: true)
!777 = !DIGlobalVariableExpression(var: !778, expr: !DIExpression())
!778 = distinct !DIGlobalVariable(name: "arg_dbus_log_user", scope: !594, file: !595, line: 162, type: !11, isLocal: false, isDefinition: true)
!779 = !DIGlobalVariableExpression(var: !780, expr: !DIExpression())
!780 = distinct !DIGlobalVariable(name: "arg_dbus_log_system", scope: !594, file: !595, line: 163, type: !11, isLocal: false, isDefinition: true)
!781 = !DIGlobalVariableExpression(var: !782, expr: !DIExpression())
!782 = distinct !DIGlobalVariable(name: "arg_tab", scope: !594, file: !595, line: 164, type: !11, isLocal: false, isDefinition: true)
!783 = !DIGlobalVariableExpression(var: !784, expr: !DIExpression())
!784 = distinct !DIGlobalVariable(name: "login_shell", scope: !594, file: !595, line: 165, type: !11, isLocal: false, isDefinition: true)
!785 = !DIGlobalVariableExpression(var: !786, expr: !DIExpression())
!786 = distinct !DIGlobalVariable(name: "just_run_the_shell", scope: !594, file: !595, line: 166, type: !11, isLocal: false, isDefinition: true)
!787 = !DIGlobalVariableExpression(var: !788, expr: !DIExpression())
!788 = distinct !DIGlobalVariable(name: "arg_netlock", scope: !594, file: !595, line: 167, type: !11, isLocal: false, isDefinition: true)
!789 = !DIGlobalVariableExpression(var: !790, expr: !DIExpression())
!790 = distinct !DIGlobalVariable(name: "arg_restrict_namespaces", scope: !594, file: !595, line: 168, type: !11, isLocal: false, isDefinition: true)
!791 = !DIGlobalVariableExpression(var: !792, expr: !DIExpression())
!792 = distinct !DIGlobalVariable(name: "fullargc", scope: !594, file: !595, line: 174, type: !11, isLocal: false, isDefinition: true)
!793 = !DIGlobalVariableExpression(var: !794, expr: !DIExpression())
!794 = distinct !DIGlobalVariable(name: "orig_umask", scope: !594, file: !595, line: 177, type: !517, isLocal: false, isDefinition: true)
!795 = !DIGlobalVariableExpression(var: !796, expr: !DIExpression())
!796 = distinct !DIGlobalVariable(name: "child_stack", scope: !594, file: !595, line: 63, type: !797, isLocal: true, isDefinition: true, align: 128)
!797 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 8388608, elements: !798)
!798 = !{!799}
!799 = !DISubrange(count: 1048576)
!800 = !DIGlobalVariableExpression(var: !801, expr: !DIExpression())
!801 = distinct !DIGlobalVariable(name: "cfg", scope: !594, file: !595, line: 65, type: !802, isLocal: false, isDefinition: true)
!802 = !DIDerivedType(tag: DW_TAG_typedef, name: "Config", file: !4, line: 224, baseType: !803)
!803 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "config_t", file: !4, line: 153, size: 8896, elements: !804)
!804 = !{!805, !806, !807, !808, !829, !830, !834, !835, !836, !837, !838, !839, !840, !841, !842, !843, !844, !845, !846, !847, !848, !849, !850, !876, !877, !878, !879, !889, !890, !891, !892, !893, !894, !895, !896, !897, !898, !899, !900, !901, !902, !903, !904, !905, !906, !907, !908, !909, !910, !911, !912, !913, !914, !915, !916, !917, !918, !919}
!805 = !DIDerivedType(tag: DW_TAG_member, name: "username", scope: !803, file: !4, line: 155, baseType: !44, size: 64)
!806 = !DIDerivedType(tag: DW_TAG_member, name: "homedir", scope: !803, file: !4, line: 156, baseType: !44, size: 64, offset: 64)
!807 = !DIDerivedType(tag: DW_TAG_member, name: "usershell", scope: !803, file: !4, line: 157, baseType: !44, size: 64, offset: 128)
!808 = !DIDerivedType(tag: DW_TAG_member, name: "profile", scope: !803, file: !4, line: 160, baseType: !809, size: 64, offset: 192)
!809 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !810, size: 64)
!810 = !DIDerivedType(tag: DW_TAG_typedef, name: "ProfileEntry", file: !4, line: 151, baseType: !811)
!811 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "profile_entry_t", file: !4, line: 140, size: 192, elements: !812)
!812 = !{!813, !815, !816}
!813 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !811, file: !4, line: 141, baseType: !814, size: 64)
!814 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !811, size: 64)
!815 = !DIDerivedType(tag: DW_TAG_member, name: "data", scope: !811, file: !4, line: 142, baseType: !44, size: 64, offset: 64)
!816 = !DIDerivedType(tag: DW_TAG_member, name: "wparam", scope: !811, file: !4, line: 149, baseType: !817, size: 64, offset: 128)
!817 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !818, size: 64)
!818 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "wparam_t", file: !4, line: 145, size: 192, elements: !819)
!819 = !{!820, !821, !822}
!820 = !DIDerivedType(tag: DW_TAG_member, name: "file", scope: !818, file: !4, line: 146, baseType: !44, size: 64)
!821 = !DIDerivedType(tag: DW_TAG_member, name: "link", scope: !818, file: !4, line: 147, baseType: !44, size: 64, offset: 64)
!822 = !DIDerivedType(tag: DW_TAG_member, name: "top", scope: !818, file: !4, line: 148, baseType: !823, size: 64, offset: 128)
!823 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !824, size: 64)
!824 = !DIDerivedType(tag: DW_TAG_typedef, name: "TopDir", file: !4, line: 138, baseType: !825)
!825 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "topdir_t", file: !4, line: 135, size: 128, elements: !826)
!826 = !{!827, !828}
!827 = !DIDerivedType(tag: DW_TAG_member, name: "path", scope: !825, file: !4, line: 136, baseType: !44, size: 64)
!828 = !DIDerivedType(tag: DW_TAG_member, name: "fd", scope: !825, file: !4, line: 137, baseType: !11, size: 32, offset: 64)
!829 = !DIDerivedType(tag: DW_TAG_member, name: "profile_rebuild_etc", scope: !803, file: !4, line: 161, baseType: !809, size: 64, offset: 256)
!830 = !DIDerivedType(tag: DW_TAG_member, name: "profile_ignore", scope: !803, file: !4, line: 164, baseType: !831, size: 2048, offset: 320)
!831 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 2048, elements: !832)
!832 = !{!833}
!833 = !DISubrange(count: 32)
!834 = !DIDerivedType(tag: DW_TAG_member, name: "keep_fd", scope: !803, file: !4, line: 165, baseType: !44, size: 64, offset: 2368)
!835 = !DIDerivedType(tag: DW_TAG_member, name: "chrootdir", scope: !803, file: !4, line: 166, baseType: !44, size: 64, offset: 2432)
!836 = !DIDerivedType(tag: DW_TAG_member, name: "home_private", scope: !803, file: !4, line: 167, baseType: !44, size: 64, offset: 2496)
!837 = !DIDerivedType(tag: DW_TAG_member, name: "home_private_keep", scope: !803, file: !4, line: 168, baseType: !44, size: 64, offset: 2560)
!838 = !DIDerivedType(tag: DW_TAG_member, name: "etc_private_keep", scope: !803, file: !4, line: 169, baseType: !44, size: 64, offset: 2624)
!839 = !DIDerivedType(tag: DW_TAG_member, name: "opt_private_keep", scope: !803, file: !4, line: 170, baseType: !44, size: 64, offset: 2688)
!840 = !DIDerivedType(tag: DW_TAG_member, name: "srv_private_keep", scope: !803, file: !4, line: 171, baseType: !44, size: 64, offset: 2752)
!841 = !DIDerivedType(tag: DW_TAG_member, name: "bin_private_keep", scope: !803, file: !4, line: 172, baseType: !44, size: 64, offset: 2816)
!842 = !DIDerivedType(tag: DW_TAG_member, name: "bin_private_lib", scope: !803, file: !4, line: 173, baseType: !44, size: 64, offset: 2880)
!843 = !DIDerivedType(tag: DW_TAG_member, name: "lib_private_keep", scope: !803, file: !4, line: 174, baseType: !44, size: 64, offset: 2944)
!844 = !DIDerivedType(tag: DW_TAG_member, name: "cwd", scope: !803, file: !4, line: 175, baseType: !44, size: 64, offset: 3008)
!845 = !DIDerivedType(tag: DW_TAG_member, name: "overlay_dir", scope: !803, file: !4, line: 176, baseType: !44, size: 64, offset: 3072)
!846 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !803, file: !4, line: 179, baseType: !44, size: 64, offset: 3136)
!847 = !DIDerivedType(tag: DW_TAG_member, name: "hostname", scope: !803, file: !4, line: 180, baseType: !44, size: 64, offset: 3200)
!848 = !DIDerivedType(tag: DW_TAG_member, name: "hosts_file", scope: !803, file: !4, line: 181, baseType: !44, size: 64, offset: 3264)
!849 = !DIDerivedType(tag: DW_TAG_member, name: "defaultgw", scope: !803, file: !4, line: 182, baseType: !76, size: 32, offset: 3328)
!850 = !DIDerivedType(tag: DW_TAG_member, name: "bridge0", scope: !803, file: !4, line: 183, baseType: !851, size: 704, offset: 3392)
!851 = !DIDerivedType(tag: DW_TAG_typedef, name: "Bridge", file: !4, line: 123, baseType: !852)
!852 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "bridge_t", file: !4, line: 97, size: 704, elements: !853)
!853 = !{!854, !855, !856, !857, !861, !862, !863, !864, !865, !866, !867, !868, !869, !870, !871, !872, !873, !874, !875}
!854 = !DIDerivedType(tag: DW_TAG_member, name: "dev", scope: !852, file: !4, line: 99, baseType: !44, size: 64)
!855 = !DIDerivedType(tag: DW_TAG_member, name: "ip", scope: !852, file: !4, line: 100, baseType: !76, size: 32, offset: 64)
!856 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !852, file: !4, line: 101, baseType: !76, size: 32, offset: 96)
!857 = !DIDerivedType(tag: DW_TAG_member, name: "mac", scope: !852, file: !4, line: 102, baseType: !858, size: 48, offset: 128)
!858 = !DICompositeType(tag: DW_TAG_array_type, baseType: !174, size: 48, elements: !859)
!859 = !{!860}
!860 = !DISubrange(count: 6)
!861 = !DIDerivedType(tag: DW_TAG_member, name: "mtu", scope: !852, file: !4, line: 103, baseType: !11, size: 32, offset: 192)
!862 = !DIDerivedType(tag: DW_TAG_member, name: "veth_name", scope: !852, file: !4, line: 105, baseType: !44, size: 64, offset: 256)
!863 = !DIDerivedType(tag: DW_TAG_member, name: "devsandbox", scope: !852, file: !4, line: 108, baseType: !44, size: 64, offset: 320)
!864 = !DIDerivedType(tag: DW_TAG_member, name: "ipsandbox", scope: !852, file: !4, line: 109, baseType: !76, size: 32, offset: 384)
!865 = !DIDerivedType(tag: DW_TAG_member, name: "masksandbox", scope: !852, file: !4, line: 110, baseType: !76, size: 32, offset: 416)
!866 = !DIDerivedType(tag: DW_TAG_member, name: "ip6sandbox", scope: !852, file: !4, line: 111, baseType: !44, size: 64, offset: 448)
!867 = !DIDerivedType(tag: DW_TAG_member, name: "macsandbox", scope: !852, file: !4, line: 112, baseType: !858, size: 48, offset: 512)
!868 = !DIDerivedType(tag: DW_TAG_member, name: "iprange_start", scope: !852, file: !4, line: 113, baseType: !76, size: 32, offset: 576)
!869 = !DIDerivedType(tag: DW_TAG_member, name: "iprange_end", scope: !852, file: !4, line: 114, baseType: !76, size: 32, offset: 608)
!870 = !DIDerivedType(tag: DW_TAG_member, name: "arg_ip_none", scope: !852, file: !4, line: 117, baseType: !174, size: 8, offset: 640)
!871 = !DIDerivedType(tag: DW_TAG_member, name: "arg_ip_dhcp", scope: !852, file: !4, line: 118, baseType: !174, size: 8, offset: 648)
!872 = !DIDerivedType(tag: DW_TAG_member, name: "arg_ip6_dhcp", scope: !852, file: !4, line: 119, baseType: !174, size: 8, offset: 656)
!873 = !DIDerivedType(tag: DW_TAG_member, name: "macvlan", scope: !852, file: !4, line: 120, baseType: !174, size: 8, offset: 664)
!874 = !DIDerivedType(tag: DW_TAG_member, name: "configured", scope: !852, file: !4, line: 121, baseType: !174, size: 8, offset: 672)
!875 = !DIDerivedType(tag: DW_TAG_member, name: "scan", scope: !852, file: !4, line: 122, baseType: !174, size: 8, offset: 680)
!876 = !DIDerivedType(tag: DW_TAG_member, name: "bridge1", scope: !803, file: !4, line: 184, baseType: !851, size: 704, offset: 4096)
!877 = !DIDerivedType(tag: DW_TAG_member, name: "bridge2", scope: !803, file: !4, line: 185, baseType: !851, size: 704, offset: 4800)
!878 = !DIDerivedType(tag: DW_TAG_member, name: "bridge3", scope: !803, file: !4, line: 186, baseType: !851, size: 704, offset: 5504)
!879 = !DIDerivedType(tag: DW_TAG_member, name: "interface0", scope: !803, file: !4, line: 187, baseType: !880, size: 256, offset: 6208)
!880 = !DIDerivedType(tag: DW_TAG_typedef, name: "Interface", file: !4, line: 133, baseType: !881)
!881 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "interface_t", file: !4, line: 125, size: 256, elements: !882)
!882 = !{!883, !884, !885, !886, !887, !888}
!883 = !DIDerivedType(tag: DW_TAG_member, name: "dev", scope: !881, file: !4, line: 126, baseType: !44, size: 64)
!884 = !DIDerivedType(tag: DW_TAG_member, name: "ip", scope: !881, file: !4, line: 127, baseType: !76, size: 32, offset: 64)
!885 = !DIDerivedType(tag: DW_TAG_member, name: "mask", scope: !881, file: !4, line: 128, baseType: !76, size: 32, offset: 96)
!886 = !DIDerivedType(tag: DW_TAG_member, name: "mac", scope: !881, file: !4, line: 129, baseType: !858, size: 48, offset: 128)
!887 = !DIDerivedType(tag: DW_TAG_member, name: "mtu", scope: !881, file: !4, line: 130, baseType: !11, size: 32, offset: 192)
!888 = !DIDerivedType(tag: DW_TAG_member, name: "configured", scope: !881, file: !4, line: 132, baseType: !174, size: 8, offset: 224)
!889 = !DIDerivedType(tag: DW_TAG_member, name: "interface1", scope: !803, file: !4, line: 188, baseType: !880, size: 256, offset: 6464)
!890 = !DIDerivedType(tag: DW_TAG_member, name: "interface2", scope: !803, file: !4, line: 189, baseType: !880, size: 256, offset: 6720)
!891 = !DIDerivedType(tag: DW_TAG_member, name: "interface3", scope: !803, file: !4, line: 190, baseType: !880, size: 256, offset: 6976)
!892 = !DIDerivedType(tag: DW_TAG_member, name: "dns1", scope: !803, file: !4, line: 191, baseType: !44, size: 64, offset: 7232)
!893 = !DIDerivedType(tag: DW_TAG_member, name: "dns2", scope: !803, file: !4, line: 192, baseType: !44, size: 64, offset: 7296)
!894 = !DIDerivedType(tag: DW_TAG_member, name: "dns3", scope: !803, file: !4, line: 193, baseType: !44, size: 64, offset: 7360)
!895 = !DIDerivedType(tag: DW_TAG_member, name: "dns4", scope: !803, file: !4, line: 194, baseType: !44, size: 64, offset: 7424)
!896 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list", scope: !803, file: !4, line: 197, baseType: !44, size: 64, offset: 7488)
!897 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list32", scope: !803, file: !4, line: 197, baseType: !44, size: 64, offset: 7552)
!898 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list_drop", scope: !803, file: !4, line: 198, baseType: !44, size: 64, offset: 7616)
!899 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list_drop32", scope: !803, file: !4, line: 198, baseType: !44, size: 64, offset: 7680)
!900 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list_keep", scope: !803, file: !4, line: 199, baseType: !44, size: 64, offset: 7744)
!901 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_list_keep32", scope: !803, file: !4, line: 199, baseType: !44, size: 64, offset: 7808)
!902 = !DIDerivedType(tag: DW_TAG_member, name: "protocol", scope: !803, file: !4, line: 200, baseType: !44, size: 64, offset: 7872)
!903 = !DIDerivedType(tag: DW_TAG_member, name: "restrict_namespaces", scope: !803, file: !4, line: 201, baseType: !44, size: 64, offset: 7936)
!904 = !DIDerivedType(tag: DW_TAG_member, name: "seccomp_error_action", scope: !803, file: !4, line: 202, baseType: !44, size: 64, offset: 8000)
!905 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_cpu", scope: !803, file: !4, line: 205, baseType: !228, size: 64, offset: 8064)
!906 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_nofile", scope: !803, file: !4, line: 206, baseType: !228, size: 64, offset: 8128)
!907 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_nproc", scope: !803, file: !4, line: 207, baseType: !228, size: 64, offset: 8192)
!908 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_fsize", scope: !803, file: !4, line: 208, baseType: !228, size: 64, offset: 8256)
!909 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_sigpending", scope: !803, file: !4, line: 209, baseType: !228, size: 64, offset: 8320)
!910 = !DIDerivedType(tag: DW_TAG_member, name: "rlimit_as", scope: !803, file: !4, line: 210, baseType: !228, size: 64, offset: 8384)
!911 = !DIDerivedType(tag: DW_TAG_member, name: "timeout", scope: !803, file: !4, line: 211, baseType: !5, size: 32, offset: 8448)
!912 = !DIDerivedType(tag: DW_TAG_member, name: "cpus", scope: !803, file: !4, line: 214, baseType: !76, size: 32, offset: 8480)
!913 = !DIDerivedType(tag: DW_TAG_member, name: "nice", scope: !803, file: !4, line: 215, baseType: !11, size: 32, offset: 8512)
!914 = !DIDerivedType(tag: DW_TAG_member, name: "command_line", scope: !803, file: !4, line: 218, baseType: !44, size: 64, offset: 8576)
!915 = !DIDerivedType(tag: DW_TAG_member, name: "window_title", scope: !803, file: !4, line: 219, baseType: !44, size: 64, offset: 8640)
!916 = !DIDerivedType(tag: DW_TAG_member, name: "command_name", scope: !803, file: !4, line: 220, baseType: !44, size: 64, offset: 8704)
!917 = !DIDerivedType(tag: DW_TAG_member, name: "original_argv", scope: !803, file: !4, line: 221, baseType: !266, size: 64, offset: 8768)
!918 = !DIDerivedType(tag: DW_TAG_member, name: "original_argc", scope: !803, file: !4, line: 222, baseType: !11, size: 32, offset: 8832)
!919 = !DIDerivedType(tag: DW_TAG_member, name: "original_program_index", scope: !803, file: !4, line: 223, baseType: !11, size: 32, offset: 8864)
!920 = !DIGlobalVariableExpression(var: !921, expr: !DIExpression())
!921 = distinct !DIGlobalVariable(name: "arg_netfilter", scope: !594, file: !595, line: 106, type: !11, isLocal: false, isDefinition: true)
!922 = !DIGlobalVariableExpression(var: !923, expr: !DIExpression())
!923 = distinct !DIGlobalVariable(name: "arg_netfilter6", scope: !594, file: !595, line: 107, type: !11, isLocal: false, isDefinition: true)
!924 = !DIGlobalVariableExpression(var: !925, expr: !DIExpression())
!925 = distinct !DIGlobalVariable(name: "arg_no3d", scope: !594, file: !595, line: 125, type: !11, isLocal: false, isDefinition: true)
!926 = !DIGlobalVariableExpression(var: !927, expr: !DIExpression())
!927 = distinct !DIGlobalVariable(name: "parent_to_child_fds", scope: !594, file: !595, line: 170, type: !928, isLocal: false, isDefinition: true)
!928 = !DICompositeType(tag: DW_TAG_array_type, baseType: !11, size: 64, elements: !929)
!929 = !{!930}
!930 = !DISubrange(count: 2)
!931 = !DIGlobalVariableExpression(var: !932, expr: !DIExpression())
!932 = distinct !DIGlobalVariable(name: "child_to_parent_fds", scope: !594, file: !595, line: 171, type: !928, isLocal: false, isDefinition: true)
!933 = !DIGlobalVariableExpression(var: !934, expr: !DIExpression())
!934 = distinct !DIGlobalVariable(name: "fullargv", scope: !594, file: !595, line: 173, type: !935, isLocal: false, isDefinition: true)
!935 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 8192, elements: !936)
!936 = !{!937}
!937 = !DISubrange(count: 128)
!938 = !DIGlobalVariableExpression(var: !939, expr: !DIExpression())
!939 = distinct !DIGlobalVariable(name: "sandbox_pid", scope: !594, file: !595, line: 176, type: !308, isLocal: false, isDefinition: true)
!940 = !DIGlobalVariableExpression(var: !941, expr: !DIExpression())
!941 = distinct !DIGlobalVariable(name: "child", scope: !594, file: !595, line: 175, type: !308, isLocal: true, isDefinition: true)
!942 = distinct !DICompileUnit(language: DW_LANG_C99, file: !943, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !944, splitDebugInlining: false, nameTableKind: None)
!943 = !DIFile(filename: "mountinfo.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "67d5e9609308864cdd5a7f5934326378")
!944 = !{!945, !950}
!945 = !DIGlobalVariableExpression(var: !946, expr: !DIExpression())
!946 = distinct !DIGlobalVariable(name: "mbuf", scope: !942, file: !943, line: 31, type: !947, isLocal: true, isDefinition: true)
!947 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 32768, elements: !948)
!948 = !{!949}
!949 = !DISubrange(count: 4096)
!950 = !DIGlobalVariableExpression(var: !951, expr: !DIExpression())
!951 = distinct !DIGlobalVariable(name: "mdata", scope: !942, file: !943, line: 32, type: !952, isLocal: true, isDefinition: true)
!952 = !DIDerivedType(tag: DW_TAG_typedef, name: "MountData", file: !4, line: 603, baseType: !953)
!953 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !4, line: 598, size: 256, elements: !954)
!954 = !{!955, !956, !957, !958}
!955 = !DIDerivedType(tag: DW_TAG_member, name: "mountid", scope: !953, file: !4, line: 599, baseType: !11, size: 32)
!956 = !DIDerivedType(tag: DW_TAG_member, name: "fsname", scope: !953, file: !4, line: 600, baseType: !44, size: 64, offset: 64)
!957 = !DIDerivedType(tag: DW_TAG_member, name: "dir", scope: !953, file: !4, line: 601, baseType: !44, size: 64, offset: 128)
!958 = !DIDerivedType(tag: DW_TAG_member, name: "fstype", scope: !953, file: !4, line: 602, baseType: !44, size: 64, offset: 192)
!959 = distinct !DICompileUnit(language: DW_LANG_C99, file: !960, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !961, splitDebugInlining: false, nameTableKind: None)
!960 = !DIFile(filename: "netfilter.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a57d0e8548f8d3535488e12ccd4e482a")
!961 = !{!44, !40}
!962 = distinct !DICompileUnit(language: DW_LANG_C99, file: !963, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, splitDebugInlining: false, nameTableKind: None)
!963 = !DIFile(filename: "netns.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "34ef3537130f2d20adafe55f7b1a9d38")
!964 = distinct !DICompileUnit(language: DW_LANG_C99, file: !965, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !966, retainedTypes: !967, splitDebugInlining: false, nameTableKind: None)
!965 = !DIFile(filename: "network.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "794966a4b8da6cb80003619ba268177f")
!966 = !{!95}
!967 = !{!968, !40, !970, !228}
!968 = !DIDerivedType(tag: DW_TAG_typedef, name: "caddr_t", file: !309, line: 115, baseType: !969)
!969 = !DIDerivedType(tag: DW_TAG_typedef, name: "__caddr_t", file: !55, line: 203, baseType: !44)
!970 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !971, size: 64)
!971 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sockaddr_in", file: !108, line: 238, size: 128, elements: !972)
!972 = !{!973, !974, !976, !981}
!973 = !DIDerivedType(tag: DW_TAG_member, name: "sin_family", scope: !971, file: !108, line: 240, baseType: !181, size: 16)
!974 = !DIDerivedType(tag: DW_TAG_member, name: "sin_port", scope: !971, file: !108, line: 241, baseType: !975, size: 16, offset: 16)
!975 = !DIDerivedType(tag: DW_TAG_typedef, name: "in_port_t", file: !108, line: 119, baseType: !71)
!976 = !DIDerivedType(tag: DW_TAG_member, name: "sin_addr", scope: !971, file: !108, line: 242, baseType: !977, size: 32, offset: 32)
!977 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "in_addr", file: !108, line: 31, size: 32, elements: !978)
!978 = !{!979}
!979 = !DIDerivedType(tag: DW_TAG_member, name: "s_addr", scope: !977, file: !108, line: 33, baseType: !980, size: 32)
!980 = !DIDerivedType(tag: DW_TAG_typedef, name: "in_addr_t", file: !108, line: 30, baseType: !76)
!981 = !DIDerivedType(tag: DW_TAG_member, name: "sin_zero", scope: !971, file: !108, line: 245, baseType: !982, size: 64, offset: 64)
!982 = !DICompositeType(tag: DW_TAG_array_type, baseType: !66, size: 64, elements: !983)
!983 = !{!984}
!984 = !DISubrange(count: 8)
!985 = distinct !DICompileUnit(language: DW_LANG_C99, file: !986, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !415, splitDebugInlining: false, nameTableKind: None)
!986 = !DIFile(filename: "network_main.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "bb7cea5c12ef9324ce2eabc0a97003f6")
!987 = distinct !DICompileUnit(language: DW_LANG_C99, file: !988, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !989, globals: !990, splitDebugInlining: false, nameTableKind: None)
!988 = !DIFile(filename: "no_sandbox.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "1b3fd69bf8f8b13add8b72ff139dae43")
!989 = !{!45, !40}
!990 = !{!991}
!991 = !DIGlobalVariableExpression(var: !992, expr: !DIExpression())
!992 = distinct !DIGlobalVariable(name: "kern_proc", scope: !993, file: !988, line: 92, type: !996, isLocal: true, isDefinition: true)
!993 = distinct !DISubprogram(name: "check_kernel_procs", scope: !988, file: !988, line: 87, type: !994, scopeLine: 87, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !987, retainedNodes: !480)
!994 = !DISubroutineType(types: !995)
!995 = !{!11}
!996 = !DICompositeType(tag: DW_TAG_array_type, baseType: !44, size: 384, elements: !859)
!997 = distinct !DICompileUnit(language: DW_LANG_C99, file: !998, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!998 = !DIFile(filename: "oom.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "d061b6f9b1970755a2e50c2404485c14")
!999 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1000, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1000 = !DIFile(filename: "output.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "62b5f6e4784e46d41607aa8c14a8cd64")
!1001 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1002, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !551, retainedTypes: !39, globals: !1003, splitDebugInlining: false, nameTableKind: None)
!1002 = !DIFile(filename: "paths.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "09a6d97d6f763c53bdf592d7315f988f")
!1003 = !{!1004, !1006, !1008, !1010}
!1004 = !DIGlobalVariableExpression(var: !1005, expr: !DIExpression())
!1005 = distinct !DIGlobalVariable(name: "paths", scope: !1001, file: !1002, line: 23, type: !266, isLocal: true, isDefinition: true)
!1006 = !DIGlobalVariableExpression(var: !1007, expr: !DIExpression())
!1007 = distinct !DIGlobalVariable(name: "elt", scope: !1001, file: !1002, line: 27, type: !44, isLocal: true, isDefinition: true)
!1008 = !DIGlobalVariableExpression(var: !1009, expr: !DIExpression())
!1009 = distinct !DIGlobalVariable(name: "path_cnt", scope: !1001, file: !1002, line: 24, type: !5, isLocal: true, isDefinition: true)
!1010 = !DIGlobalVariableExpression(var: !1011, expr: !DIExpression())
!1011 = distinct !DIGlobalVariable(name: "longest_path_elt", scope: !1001, file: !1002, line: 25, type: !5, isLocal: true, isDefinition: true)
!1012 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1013, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !489, retainedTypes: !39, globals: !1014, splitDebugInlining: false, nameTableKind: None)
!1013 = !DIFile(filename: "preproc.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "2cc2cf54b67b79cc5f9b0b53b1f244ce")
!1014 = !{!1015}
!1015 = !DIGlobalVariableExpression(var: !1016, expr: !DIExpression())
!1016 = distinct !DIGlobalVariable(name: "tmpfs_mounted", scope: !1012, file: !1013, line: 26, type: !11, isLocal: true, isDefinition: true)
!1017 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1018, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, splitDebugInlining: false, nameTableKind: None)
!1018 = !DIFile(filename: "process.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "b57805bdf25741add2b2aaa0ab4058c6")
!1019 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1020, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1021, retainedTypes: !1022, globals: !1023, splitDebugInlining: false, nameTableKind: None)
!1020 = !DIFile(filename: "profile.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a9786962d85db1ce8548d0f703dd15cb")
!1021 = !{!136, !294, !3}
!1022 = !{!40, !66}
!1023 = !{!1024, !1035}
!1024 = !DIGlobalVariableExpression(var: !1025, expr: !DIExpression())
!1025 = distinct !DIGlobalVariable(name: "conditionals", scope: !1019, file: !1020, line: 187, type: !1026, isLocal: false, isDefinition: true)
!1026 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1027, size: 1280, elements: !1033)
!1027 = !DIDerivedType(tag: DW_TAG_typedef, name: "Cond", file: !1020, line: 149, baseType: !1028)
!1028 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "cond_t", file: !1020, line: 146, size: 128, elements: !1029)
!1029 = !{!1030, !1031}
!1030 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !1028, file: !1020, line: 147, baseType: !270, size: 64)
!1031 = !DIDerivedType(tag: DW_TAG_member, name: "check", scope: !1028, file: !1020, line: 148, baseType: !1032, size: 64, offset: 64)
!1032 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !994, size: 64)
!1033 = !{!1034}
!1034 = !DISubrange(count: 10)
!1035 = !DIGlobalVariableExpression(var: !1036, expr: !DIExpression())
!1036 = distinct !DIGlobalVariable(name: "include_level", scope: !1019, file: !1020, line: 1754, type: !11, isLocal: true, isDefinition: true)
!1037 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1038, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, splitDebugInlining: false, nameTableKind: None)
!1038 = !DIFile(filename: "protocol.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "9a0d90e7345da101d75bf2031a77f1b6")
!1039 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1040, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1041, splitDebugInlining: false, nameTableKind: None)
!1040 = !DIFile(filename: "pulseaudio.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "d471a70a9b8e190343cd46d589a08bbb")
!1041 = !{!369, !3, !9}
!1042 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1043, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !281, retainedTypes: !1044, globals: !1045, splitDebugInlining: false, nameTableKind: None)
!1043 = !DIFile(filename: "restrict_users.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "ef1eeb191131209d16833db0c1e5c88f")
!1044 = !{!520, !523}
!1045 = !{!1046}
!1046 = !DIGlobalVariableExpression(var: !1047, expr: !DIExpression())
!1047 = distinct !DIGlobalVariable(name: "ulist", scope: !1042, file: !1043, line: 41, type: !1048, isLocal: false, isDefinition: true)
!1048 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1049, size: 64)
!1049 = !DIDerivedType(tag: DW_TAG_typedef, name: "USER_LIST", file: !1043, line: 40, baseType: !1050)
!1050 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "user_list", file: !1043, line: 37, size: 128, elements: !1051)
!1051 = !{!1052, !1054}
!1052 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !1050, file: !1043, line: 38, baseType: !1053, size: 64)
!1053 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1050, size: 64)
!1054 = !DIDerivedType(tag: DW_TAG_member, name: "user", scope: !1050, file: !1043, line: 39, baseType: !270, size: 64, offset: 64)
!1055 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1056, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !1057, splitDebugInlining: false, nameTableKind: None)
!1056 = !DIFile(filename: "restricted_shell.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "eb983cc1eb177cb2385efd0badb48cdf")
!1057 = !{!1058}
!1058 = !DIGlobalVariableExpression(var: !1059, expr: !DIExpression())
!1059 = distinct !DIGlobalVariable(name: "restricted_user", scope: !1055, file: !1056, line: 24, type: !44, isLocal: false, isDefinition: true)
!1060 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1061, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1062, retainedTypes: !1085, splitDebugInlining: false, nameTableKind: None)
!1061 = !DIFile(filename: "rlimit.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "b0fa96f1b625c735851a9bc092c73aec")
!1062 = !{!1063}
!1063 = !DICompositeType(tag: DW_TAG_enumeration_type, name: "__rlimit_resource", file: !1064, line: 31, baseType: !5, size: 32, elements: !1065)
!1064 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/resource.h", directory: "", checksumkind: CSK_MD5, checksum: "f46d42ca5fb626298a4c607cecb13cce")
!1065 = !{!1066, !1067, !1068, !1069, !1070, !1071, !1072, !1073, !1074, !1075, !1076, !1077, !1078, !1079, !1080, !1081, !1082, !1083, !1084}
!1066 = !DIEnumerator(name: "RLIMIT_CPU", value: 0)
!1067 = !DIEnumerator(name: "RLIMIT_FSIZE", value: 1)
!1068 = !DIEnumerator(name: "RLIMIT_DATA", value: 2)
!1069 = !DIEnumerator(name: "RLIMIT_STACK", value: 3)
!1070 = !DIEnumerator(name: "RLIMIT_CORE", value: 4)
!1071 = !DIEnumerator(name: "__RLIMIT_RSS", value: 5)
!1072 = !DIEnumerator(name: "RLIMIT_NOFILE", value: 7)
!1073 = !DIEnumerator(name: "__RLIMIT_OFILE", value: 7)
!1074 = !DIEnumerator(name: "RLIMIT_AS", value: 9)
!1075 = !DIEnumerator(name: "__RLIMIT_NPROC", value: 6)
!1076 = !DIEnumerator(name: "__RLIMIT_MEMLOCK", value: 8)
!1077 = !DIEnumerator(name: "__RLIMIT_LOCKS", value: 10)
!1078 = !DIEnumerator(name: "__RLIMIT_SIGPENDING", value: 11)
!1079 = !DIEnumerator(name: "__RLIMIT_MSGQUEUE", value: 12)
!1080 = !DIEnumerator(name: "__RLIMIT_NICE", value: 13)
!1081 = !DIEnumerator(name: "__RLIMIT_RTPRIO", value: 14)
!1082 = !DIEnumerator(name: "__RLIMIT_RTTIME", value: 15)
!1083 = !DIEnumerator(name: "__RLIMIT_NLIMITS", value: 16)
!1084 = !DIEnumerator(name: "__RLIM_NLIMITS", value: 16)
!1085 = !{!1086}
!1086 = !DIDerivedType(tag: DW_TAG_typedef, name: "rlim_t", file: !1064, line: 131, baseType: !1087)
!1087 = !DIDerivedType(tag: DW_TAG_typedef, name: "__rlim_t", file: !55, line: 157, baseType: !48)
!1088 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1089, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1090, retainedTypes: !995, globals: !1091, splitDebugInlining: false, nameTableKind: None)
!1089 = !DIFile(filename: "run_files.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "84ac38347f84969ab9875d8f41553436")
!1090 = !{!136}
!1091 = !{!1092}
!1092 = !DIGlobalVariableExpression(var: !1093, expr: !DIExpression())
!1093 = distinct !DIGlobalVariable(name: "sandbox_lock_fd", scope: !1088, file: !1089, line: 167, type: !11, isLocal: true, isDefinition: true)
!1094 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1095, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, splitDebugInlining: false, nameTableKind: None)
!1095 = !DIFile(filename: "run_symlink.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a76fbb125dd03d19d2d308b030e27d40")
!1096 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1097, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1098, retainedTypes: !1099, globals: !1100, splitDebugInlining: false, nameTableKind: None)
!1097 = !DIFile(filename: "sandbox.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "481cda1bc6bc7c040eb38a0ea70a2251")
!1098 = !{!9, !136, !379, !369}
!1099 = !{!40, !11, !558, !308}
!1100 = !{!1101}
!1101 = !DIGlobalVariableExpression(var: !1102, expr: !DIExpression())
!1102 = distinct !DIGlobalVariable(name: "monitored_pid", scope: !1096, file: !1097, line: 55, type: !11, isLocal: true, isDefinition: true)
!1103 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1104, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1062, retainedTypes: !1105, splitDebugInlining: false, nameTableKind: None)
!1104 = !DIFile(filename: "sbox.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "a224a363f68c7c3724986afce3217a65")
!1105 = !{!558, !80, !56}
!1106 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1107, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1108, retainedTypes: !1109, globals: !1110, splitDebugInlining: false, nameTableKind: None)
!1107 = !DIFile(filename: "seccomp.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "16c4c65493d34704f4387090c9956869")
!1108 = !{!199, !136}
!1109 = !{!11, !56, !40}
!1110 = !{!1111, !1137, !1139}
!1111 = !DIGlobalVariableExpression(var: !1112, expr: !DIExpression())
!1112 = distinct !DIGlobalVariable(name: "filter_list_head", scope: !1106, file: !1107, line: 32, type: !1113, isLocal: true, isDefinition: true)
!1113 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1114, size: 64)
!1114 = !DIDerivedType(tag: DW_TAG_typedef, name: "FilterList", file: !1107, line: 30, baseType: !1115)
!1115 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "filter_list", file: !1107, line: 26, size: 256, elements: !1116)
!1116 = !{!1117, !1119, !1136}
!1117 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !1115, file: !1107, line: 27, baseType: !1118, size: 64)
!1118 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1115, size: 64)
!1119 = !DIDerivedType(tag: DW_TAG_member, name: "prog", scope: !1115, file: !1107, line: 28, baseType: !1120, size: 128, offset: 64)
!1120 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sock_fprog", file: !1121, line: 31, size: 128, elements: !1122)
!1121 = !DIFile(filename: "/usr/include/linux/filter.h", directory: "", checksumkind: CSK_MD5, checksum: "73e04ad1c16b12de5e88700b371f738f")
!1122 = !{!1123, !1124}
!1123 = !DIDerivedType(tag: DW_TAG_member, name: "len", scope: !1120, file: !1121, line: 32, baseType: !56, size: 16)
!1124 = !DIDerivedType(tag: DW_TAG_member, name: "filter", scope: !1120, file: !1121, line: 33, baseType: !1125, size: 64, offset: 64)
!1125 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1126, size: 64)
!1126 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sock_filter", file: !1121, line: 24, size: 64, elements: !1127)
!1127 = !{!1128, !1131, !1133, !1134}
!1128 = !DIDerivedType(tag: DW_TAG_member, name: "code", scope: !1126, file: !1121, line: 25, baseType: !1129, size: 16)
!1129 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u16", file: !1130, line: 24, baseType: !56)
!1130 = !DIFile(filename: "/usr/include/asm-generic/int-ll64.h", directory: "", checksumkind: CSK_MD5, checksum: "b810f270733e106319b67ef512c6246e")
!1131 = !DIDerivedType(tag: DW_TAG_member, name: "jt", scope: !1126, file: !1121, line: 26, baseType: !1132, size: 8, offset: 16)
!1132 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u8", file: !1130, line: 21, baseType: !66)
!1133 = !DIDerivedType(tag: DW_TAG_member, name: "jf", scope: !1126, file: !1121, line: 27, baseType: !1132, size: 8, offset: 24)
!1134 = !DIDerivedType(tag: DW_TAG_member, name: "k", scope: !1126, file: !1121, line: 28, baseType: !1135, size: 32, offset: 32)
!1135 = !DIDerivedType(tag: DW_TAG_typedef, name: "__u32", file: !1130, line: 27, baseType: !5)
!1136 = !DIDerivedType(tag: DW_TAG_member, name: "fname", scope: !1115, file: !1107, line: 29, baseType: !270, size: 64, offset: 192)
!1137 = !DIGlobalVariableExpression(var: !1138, expr: !DIExpression())
!1138 = distinct !DIGlobalVariable(name: "err_printed", scope: !1106, file: !1107, line: 33, type: !11, isLocal: true, isDefinition: true)
!1139 = !DIGlobalVariableExpression(var: !1140, expr: !DIExpression())
!1140 = distinct !DIGlobalVariable(name: "load_file_list_flag", scope: !1106, file: !1107, line: 109, type: !11, isLocal: true, isDefinition: true)
!1141 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1142, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1142 = !DIFile(filename: "selinux.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "eac89f6b4a320e7f5f3e3e2adacb42fc")
!1143 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1144, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1144 = !DIFile(filename: "shutdown.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "363d363b9abae4a74c8a57e864d9d42c")
!1145 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1146, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !1147, splitDebugInlining: false, nameTableKind: None)
!1146 = !DIFile(filename: "usage.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "647c736c7196cae329a1dfdb85656ef6")
!1147 = !{!1148}
!1148 = !DIGlobalVariableExpression(var: !1149, expr: !DIExpression())
!1149 = distinct !DIGlobalVariable(name: "usage_str", scope: !1145, file: !1146, line: 22, type: !269, isLocal: true, isDefinition: true)
!1150 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1151, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1152, retainedTypes: !1153, globals: !1154, splitDebugInlining: false, nameTableKind: None)
!1151 = !DIFile(filename: "util.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "f50c1d1658bad3b265fc2e572197f57a")
!1152 = !{!199, !9}
!1153 = !{!11, !56, !40, !300, !558, !553, !308}
!1154 = !{!1155, !1158}
!1155 = !DIGlobalVariableExpression(var: !1156, expr: !DIExpression())
!1156 = distinct !DIGlobalVariable(name: "can_drop_all_groups", scope: !1157, file: !1151, line: 109, type: !11, isLocal: true, isDefinition: true)
!1157 = distinct !DISubprogram(name: "check_can_drop_all_groups", scope: !1151, file: !1151, line: 108, type: !994, scopeLine: 108, spFlags: DISPFlagDefinition, unit: !1150, retainedNodes: !480)
!1158 = !DIGlobalVariableExpression(var: !1159, expr: !DIExpression())
!1159 = distinct !DIGlobalVariable(name: "BUFLEN", scope: !1160, file: !1151, line: 414, type: !1163, isLocal: true, isDefinition: true)
!1160 = distinct !DISubprogram(name: "copy_file_by_fd", scope: !1151, file: !1151, line: 409, type: !1161, scopeLine: 409, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !1150, retainedNodes: !480)
!1161 = !DISubroutineType(types: !1162)
!1162 = !{!11, !11, !11}
!1163 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !11)
!1164 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1165, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !1166, retainedTypes: !1167, splitDebugInlining: false, nameTableKind: None)
!1165 = !DIFile(filename: "x11.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/firejail", checksumkind: CSK_MD5, checksum: "2f664c94cf5c173db2ba49b42c92d109")
!1166 = !{!3, !136, !9, !369, !95}
!1167 = !{!48, !11, !40, !52, !1168, !5}
!1168 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1169, size: 64)
!1169 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "sockaddr", file: !178, line: 178, size: 128, elements: !1170)
!1170 = !{!1171, !1172}
!1171 = !DIDerivedType(tag: DW_TAG_member, name: "sa_family", scope: !1169, file: !178, line: 180, baseType: !181, size: 16)
!1172 = !DIDerivedType(tag: DW_TAG_member, name: "sa_data", scope: !1169, file: !178, line: 181, baseType: !184, size: 112, offset: 16)
!1173 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1174, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !198, retainedTypes: !1175, globals: !1177, splitDebugInlining: false, nameTableKind: None)
!1174 = !DIFile(filename: "common.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/lib", checksumkind: CSK_MD5, checksum: "c847a3a42dc9e5970e2e9e509aaf1f30")
!1175 = !{!44, !40, !11, !66, !56, !1176}
!1176 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!1177 = !{!1178}
!1178 = !DIGlobalVariableExpression(var: !1179, expr: !DIExpression())
!1179 = distinct !DIGlobalVariable(name: "ts_list", scope: !1173, file: !1174, line: 560, type: !1180, isLocal: true, isDefinition: true)
!1180 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1181, size: 64)
!1181 = !DIDerivedType(tag: DW_TAG_typedef, name: "ListEntry", file: !1174, line: 558, baseType: !1182)
!1182 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "list_entry_t", file: !1174, line: 555, size: 192, elements: !1183)
!1183 = !{!1184, !1186}
!1184 = !DIDerivedType(tag: DW_TAG_member, name: "next", scope: !1182, file: !1174, line: 556, baseType: !1185, size: 64)
!1185 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !1182, size: 64)
!1186 = !DIDerivedType(tag: DW_TAG_member, name: "ts", scope: !1182, file: !1174, line: 557, baseType: !1187, size: 128, offset: 64)
!1187 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "timespec", file: !1188, line: 10, size: 128, elements: !1189)
!1188 = !DIFile(filename: "/usr/include/x86_64-linux-gnu/bits/types/struct_timespec.h", directory: "", checksumkind: CSK_MD5, checksum: "33f28095c70788baa6982a79b13f774b")
!1189 = !{!1190, !1192}
!1190 = !DIDerivedType(tag: DW_TAG_member, name: "tv_sec", scope: !1187, file: !1188, line: 12, baseType: !1191, size: 64)
!1191 = !DIDerivedType(tag: DW_TAG_typedef, name: "__time_t", file: !55, line: 160, baseType: !189)
!1192 = !DIDerivedType(tag: DW_TAG_member, name: "tv_nsec", scope: !1187, file: !1188, line: 16, baseType: !1193, size: 64, offset: 64)
!1193 = !DIDerivedType(tag: DW_TAG_typedef, name: "__syscall_slong_t", file: !55, line: 196, baseType: !189)
!1194 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1195, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, splitDebugInlining: false, nameTableKind: None)
!1195 = !DIFile(filename: "ldd_utils.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/lib", checksumkind: CSK_MD5, checksum: "8fbc14ca564b015a35fffbc135a185e4")
!1196 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1197, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !1198, splitDebugInlining: false, nameTableKind: None)
!1197 = !DIFile(filename: "firejail_user.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/lib", checksumkind: CSK_MD5, checksum: "d1c9e48aaba44e6228e41d47fb396c59")
!1198 = !{!1199, !1201}
!1199 = !DIGlobalVariableExpression(var: !1200, expr: !DIExpression())
!1200 = distinct !DIGlobalVariable(name: "uid_min", scope: !1196, file: !1197, line: 37, type: !11, isLocal: false, isDefinition: true)
!1201 = !DIGlobalVariableExpression(var: !1202, expr: !DIExpression())
!1202 = distinct !DIGlobalVariable(name: "gid_min", scope: !1196, file: !1197, line: 38, type: !11, isLocal: false, isDefinition: true)
!1203 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1204, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, globals: !1205, splitDebugInlining: false, nameTableKind: None)
!1204 = !DIFile(filename: "errno.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/lib", checksumkind: CSK_MD5, checksum: "55565846cdad310b44abc6c2fc7440e8")
!1205 = !{!1206}
!1206 = !DIGlobalVariableExpression(var: !1207, expr: !DIExpression())
!1207 = distinct !DIGlobalVariable(name: "errnolist", scope: !1203, file: !1204, line: 32, type: !1208, isLocal: true, isDefinition: true)
!1208 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1209, size: 17152, elements: !1214)
!1209 = !DIDerivedType(tag: DW_TAG_typedef, name: "ErrnoEntry", file: !1204, line: 30, baseType: !1210)
!1210 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1204, line: 27, size: 128, elements: !1211)
!1211 = !{!1212, !1213}
!1212 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !1210, file: !1204, line: 28, baseType: !44, size: 64)
!1213 = !DIDerivedType(tag: DW_TAG_member, name: "nr", scope: !1210, file: !1204, line: 29, baseType: !11, size: 32, offset: 64)
!1214 = !{!1215}
!1215 = !DISubrange(count: 134)
!1216 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1217, producer: "clang version 15.0.0 (https://github.com/llvm/llvm-project.git 8cb7a873ab8568acfbfd6c27a927d924cc994017)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, retainedTypes: !39, globals: !1218, splitDebugInlining: false, nameTableKind: None)
!1217 = !DIFile(filename: "syscall.c", directory: "/home/doitman/llfuzz-experiment/llfuzz/oss/firejail/src/lib", checksumkind: CSK_MD5, checksum: "9d9020e92c720f14ae9ccdf2cb26b92f")
!1218 = !{!1219, !1230, !1235}
!1219 = !DIGlobalVariableExpression(var: !1220, expr: !DIExpression())
!1220 = distinct !DIGlobalVariable(name: "syslist", scope: !1216, file: !1217, line: 52, type: !1221, isLocal: true, isDefinition: true)
!1221 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1222, size: 45056, elements: !1228)
!1222 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1223)
!1223 = !DIDerivedType(tag: DW_TAG_typedef, name: "SyscallEntry", file: !1217, line: 37, baseType: !1224)
!1224 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1217, line: 34, size: 128, elements: !1225)
!1225 = !{!1226, !1227}
!1226 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !1224, file: !1217, line: 35, baseType: !269, size: 64)
!1227 = !DIDerivedType(tag: DW_TAG_member, name: "nr", scope: !1224, file: !1217, line: 36, baseType: !11, size: 32, offset: 64)
!1228 = !{!1229}
!1229 = !DISubrange(count: 352)
!1230 = !DIGlobalVariableExpression(var: !1231, expr: !DIExpression())
!1231 = distinct !DIGlobalVariable(name: "syslist32", scope: !1216, file: !1217, line: 68, type: !1232, isLocal: true, isDefinition: true)
!1232 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1222, size: 54912, elements: !1233)
!1233 = !{!1234}
!1234 = !DISubrange(count: 429)
!1235 = !DIGlobalVariableExpression(var: !1236, expr: !DIExpression())
!1236 = distinct !DIGlobalVariable(name: "sysgroups", scope: !1216, file: !1217, line: 77, type: !1237, isLocal: true, isDefinition: true)
!1237 = !DICompositeType(tag: DW_TAG_array_type, baseType: !1238, size: 3712, elements: !1244)
!1238 = !DIDerivedType(tag: DW_TAG_const_type, baseType: !1239)
!1239 = !DIDerivedType(tag: DW_TAG_typedef, name: "SyscallGroupList", file: !1217, line: 42, baseType: !1240)
!1240 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1217, line: 39, size: 128, elements: !1241)
!1241 = !{!1242, !1243}
!1242 = !DIDerivedType(tag: DW_TAG_member, name: "name", scope: !1240, file: !1217, line: 40, baseType: !269, size: 64)
!1243 = !DIDerivedType(tag: DW_TAG_member, name: "list", scope: !1240, file: !1217, line: 41, baseType: !269, size: 64, offset: 64)
!1244 = !{!1245}
!1245 = !DISubrange(count: 29)
