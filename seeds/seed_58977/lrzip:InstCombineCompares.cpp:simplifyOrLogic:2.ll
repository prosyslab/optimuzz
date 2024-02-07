; ModuleID = '/home/doitman/llfuzz-experiment/lls/lls_latest/lrzip.ll'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.rzip_control = type { ptr, ptr, ptr, ptr, ptr, ptr, ptr, ptr, i64, i64, i64, i64, i64, ptr, i64, i64, i64, ptr, ptr, ptr, i8, i64, i64, i64, [5 x i8], i64, i64, i64, i64, i64, i32, i8, i32, i8, i8, i64, i64, i32, i32, i32, i64, i64, ptr, ptr, [8 x i8], ptr, i32, ptr, ptr, %union.pthread_mutex_t, i8, i8, i8, %union.sem_t, %struct.md5_ctx, [16 x i8], i64, %struct.checksum, ptr, i8, ptr, i8, ptr, i8, i32, ptr, ptr, ptr, ptr, i8, %struct.sliding_buffer, ptr, ptr, ptr, ptr, ptr, ptr }
%union.pthread_mutex_t = type { %struct.__pthread_mutex_s }
%struct.__pthread_mutex_s = type { i32, i32, i32, i32, i32, i16, i16, %struct.__pthread_internal_list }
%struct.__pthread_internal_list = type { ptr, ptr }
%union.sem_t = type { i64, [24 x i8] }
%struct.md5_ctx = type { i32, i32, i32, i32, [2 x i32], i32, [32 x i32] }
%struct.checksum = type { ptr, ptr, i64 }
%struct.sliding_buffer = type { ptr, ptr, i64, i64, i64, i64, i64, i64, i64, i64, i32 }
%struct.option = type { ptr, i32, ptr, i32 }
%struct.level = type { i64, i32, i32 }
%union.pthread_cond_t = type { %struct.__pthread_cond_s }
%struct.__pthread_cond_s = type { %union.anon.37, %union.anon.37, [2 x i32], [2 x i32], i32, i32, [2 x i32] }
%union.anon.37 = type { i64 }
%struct.sha4_context = type { [2 x i64], [8 x i64], [128 x i8], [128 x i8], [128 x i8], i32 }
%"class.libzpaq::ZPAQL" = type { ptr, ptr, %"class.libzpaq::Array.0", i32, i32, i32, [4 x i8], %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", i32, i32, i32, i32, i32, i32, i32, i32, ptr }
%"class.libzpaq::Array.0" = type <{ ptr, i64, i32, [4 x i8] }>
%"class.libzpaq::Predictor" = type <{ i32, i32, [256 x i32], [256 x i32], ptr, [256 x %"struct.libzpaq::Component"], [256 x i32], [1024 x i32], [4096 x i16], [32768 x i16], %"class.libzpaq::StateTable", ptr, i32, [4 x i8] }>
%"struct.libzpaq::Component" = type { i64, i64, i64, i64, i64, %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0" }
%"class.libzpaq::StateTable" = type { [1024 x i8] }
%"class.libzpaq::Decoder" = type { ptr, i32, i32, i32, [4 x i8], %"class.libzpaq::Predictor", %"class.libzpaq::Array.0" }

$_ZTV7bufRead = comdat any

$_ZTS7bufRead = comdat any

$_ZTI7bufRead = comdat any

$_ZTV8bufWrite = comdat any

$_ZTS8bufWrite = comdat any

$_ZTI8bufWrite = comdat any

$_ZTVN7libzpaq12MemoryReaderE = comdat any

$_ZTSN7libzpaq12MemoryReaderE = comdat any

$_ZTIN7libzpaq12MemoryReaderE = comdat any

@base_control = internal global %struct.rzip_control zeroinitializer, align 8
@control = internal global ptr null, align 8
@.str = private unnamed_addr constant [8 x i8] c"lrunzip\00", align 1
@.str.1 = private unnamed_addr constant [7 x i8] c"lrzcat\00", align 1
@.str.2 = private unnamed_addr constant [4 x i8] c"lrz\00", align 1
@.str.3 = private unnamed_addr constant [7 x i8] c"stdout\00", align 1
@long_options = internal global [38 x %struct.option] [%struct.option { ptr @.str.49, i32 0, ptr null, i32 98 }, %struct.option { ptr @.str.50, i32 0, ptr null, i32 99 }, %struct.option { ptr @.str.50, i32 0, ptr null, i32 67 }, %struct.option { ptr @.str.51, i32 0, ptr null, i32 100 }, %struct.option { ptr @.str.52, i32 0, ptr null, i32 68 }, %struct.option { ptr @.str.53, i32 2, ptr null, i32 101 }, %struct.option { ptr @.str.54, i32 0, ptr null, i32 102 }, %struct.option { ptr @.str.55, i32 0, ptr null, i32 103 }, %struct.option { ptr @.str.56, i32 0, ptr null, i32 104 }, %struct.option { ptr @.str.57, i32 0, ptr null, i32 72 }, %struct.option { ptr @.str.58, i32 0, ptr null, i32 105 }, %struct.option { ptr @.str.59, i32 0, ptr null, i32 107 }, %struct.option { ptr @.str.59, i32 0, ptr null, i32 75 }, %struct.option { ptr @.str.60, i32 0, ptr null, i32 108 }, %struct.option { ptr @.str.61, i32 0, ptr null, i32 47 }, %struct.option { ptr @.str.62, i32 2, ptr null, i32 76 }, %struct.option { ptr @.str.63, i32 0, ptr null, i32 76 }, %struct.option { ptr @.str.64, i32 1, ptr null, i32 109 }, %struct.option { ptr @.str.65, i32 0, ptr null, i32 110 }, %struct.option { ptr @.str.66, i32 1, ptr null, i32 78 }, %struct.option { ptr @.str.67, i32 1, ptr null, i32 111 }, %struct.option { ptr @.str.68, i32 1, ptr null, i32 79 }, %struct.option { ptr @.str.69, i32 1, ptr null, i32 112 }, %struct.option { ptr @.str.70, i32 0, ptr null, i32 80 }, %struct.option { ptr @.str.71, i32 0, ptr null, i32 113 }, %struct.option { ptr @.str.72, i32 0, ptr null, i32 81 }, %struct.option { ptr @.str.73, i32 0, ptr null, i32 114 }, %struct.option { ptr @.str.74, i32 1, ptr null, i32 83 }, %struct.option { ptr @.str.75, i32 0, ptr null, i32 116 }, %struct.option { ptr @.str.76, i32 1, ptr null, i32 84 }, %struct.option { ptr @.str.77, i32 0, ptr null, i32 85 }, %struct.option { ptr @.str.78, i32 0, ptr null, i32 118 }, %struct.option { ptr @.str.79, i32 0, ptr null, i32 86 }, %struct.option { ptr @.str.80, i32 1, ptr null, i32 119 }, %struct.option { ptr @.str.81, i32 0, ptr null, i32 122 }, %struct.option { ptr @.str.82, i32 0, ptr null, i32 49 }, %struct.option { ptr @.str.83, i32 0, ptr null, i32 57 }, %struct.option zeroinitializer], align 16
@.str.4 = private unnamed_addr constant [5 x i8] c"keep\00", align 1
@.str.5 = private unnamed_addr constant [6 x i8] c"LRZIP\00", align 1
@.str.6 = private unnamed_addr constant [9 x i8] c"NOCONFIG\00", align 1
@coptions = internal global ptr @.str.84, align 8
@loptions = internal global ptr @.str.85, align 8
@.str.7 = private unnamed_addr constant [7 x i8] c"main.c\00", align 1
@__func__.main = private unnamed_addr constant [5 x i8] c"main\00", align 1
@.str.8 = private unnamed_addr constant [42 x i8] c"Can only use one of -l, -b, -g, -z or -n\0A\00", align 1
@optarg = external global ptr, align 8
@.str.9 = private unnamed_addr constant [41 x i8] c"Invalid compression level (must be 1-9)\0A\00", align 1
@.str.10 = private unnamed_addr constant [48 x i8] c"Extra characters after compression level: '%s'\0A\00", align 1
@.str.11 = private unnamed_addr constant [38 x i8] c"Extra characters after ramsize: '%s'\0A\00", align 1
@.str.12 = private unnamed_addr constant [38 x i8] c"Invalid nice value (must be %d...%d)\0A\00", align 1
@.str.13 = private unnamed_addr constant [41 x i8] c"Extra characters after nice level: '%s'\0A\00", align 1
@.str.14 = private unnamed_addr constant [32 x i8] c"Cannot have -o and -O together\0A\00", align 1
@.str.15 = private unnamed_addr constant [61 x i8] c"Cannot specify an output filename when outputting to stdout\0A\00", align 1
@.str.16 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.17 = private unnamed_addr constant [40 x i8] c"Cannot have options -o and -O together\0A\00", align 1
@.str.18 = private unnamed_addr constant [62 x i8] c"Cannot specify an output directory when outputting to stdout\0A\00", align 1
@.str.19 = private unnamed_addr constant [31 x i8] c"Failed to allocate for outdir\0A\00", align 1
@.str.20 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.21 = private unnamed_addr constant [31 x i8] c"Must have at least one thread\0A\00", align 1
@.str.22 = private unnamed_addr constant [48 x i8] c"Extra characters after number of threads: '%s'\0A\00", align 1
@.str.23 = private unnamed_addr constant [64 x i8] c"Specified output filename already, can't specify an extension.\0A\00", align 1
@.str.24 = private unnamed_addr constant [60 x i8] c"Cannot specify a filename suffix when outputting to stdout\0A\00", align 1
@.str.25 = private unnamed_addr constant [55 x i8] c"Cannot specify an output file name when just testing.\0A\00", align 1
@.str.26 = private unnamed_addr constant [57 x i8] c"Doubt that you want to delete a file when just testing.\0A\00", align 1
@stdout = external global ptr, align 8
@.str.27 = private unnamed_addr constant [18 x i8] c"lrzip version %s\0A\00", align 1
@.str.28 = private unnamed_addr constant [6 x i8] c"0.651\00", align 1
@.str.29 = private unnamed_addr constant [25 x i8] c"Window must be positive\0A\00", align 1
@.str.30 = private unnamed_addr constant [42 x i8] c"Extra characters after window size: '%s'\0A\00", align 1
@optind = external global i32, align 4
@.str.31 = private unnamed_addr constant [54 x i8] c"Cannot specify output filename with more than 1 file\0A\00", align 1
@.str.32 = private unnamed_addr constant [47 x i8] c"Cannot specify output filename with recursive\0A\00", align 1
@.str.33 = private unnamed_addr constant [41 x i8] c"Cannot have -v and -q options. -v wins.\0A\00", align 1
@.str.34 = private unnamed_addr constant [51 x i8] c"If -U used, cannot specify a window size with -w.\0A\00", align 1
@.str.35 = private unnamed_addr constant [52 x i8] c"Cannot have -U and stdin, unlimited mode disabled.\0A\00", align 1
@.str.36 = private unnamed_addr constant [56 x i8] c"Warning, unable to set nice value %d...Resetting to %d\0A\00", align 1
@.str.37 = private unnamed_addr constant [2 x i8] c"-\00", align 1
@.str.38 = private unnamed_addr constant [19 x i8] c"Failed to stat %s\0A\00", align 1
@.str.39 = private unnamed_addr constant [119 x i8] c"lrzip only works directly on regular FILES.\0AUse -r recursive, lrztar or pipe through tar for compressing directories.\0A\00", align 1
@.str.40 = private unnamed_addr constant [52 x i8] c"%s not a directory, -r recursive needs a directory\0A\00", align 1
@.str.41 = private unnamed_addr constant [36 x i8] c"Cannot use -r recursive with STDIO\0A\00", align 1
@.str.42 = private unnamed_addr constant [35 x i8] c"Will not get file info from STDIN\0A\00", align 1
@.str.43 = private unnamed_addr constant [58 x i8] c"Will not read stdin from a terminal. Use -f to override.\0A\00", align 1
@.str.44 = private unnamed_addr constant [58 x i8] c"Will not write stdout to a terminal. Use -f to override.\0A\00", align 1
@.str.45 = private unnamed_addr constant [47 x i8] c"Can only check file written on decompression.\0A\00", align 1
@.str.46 = private unnamed_addr constant [69 x i8] c"Can't check file written when writing to stdout. Checking disabled.\0A\00", align 1
@.str.47 = private unnamed_addr constant [50 x i8] c"Unable to work from STDIO while reading password\0A\00", align 1
@local_control = internal global %struct.rzip_control zeroinitializer, align 8
@.str.48 = private unnamed_addr constant [30 x i8] c"Total time: %02d:%02d:%05.2f\0A\00", align 1
@.str.49 = private unnamed_addr constant [6 x i8] c"bzip2\00", align 1
@.str.50 = private unnamed_addr constant [6 x i8] c"check\00", align 1
@.str.51 = private unnamed_addr constant [11 x i8] c"decompress\00", align 1
@.str.52 = private unnamed_addr constant [7 x i8] c"delete\00", align 1
@.str.53 = private unnamed_addr constant [8 x i8] c"encrypt\00", align 1
@.str.54 = private unnamed_addr constant [6 x i8] c"force\00", align 1
@.str.55 = private unnamed_addr constant [5 x i8] c"gzip\00", align 1
@.str.56 = private unnamed_addr constant [5 x i8] c"help\00", align 1
@.str.57 = private unnamed_addr constant [5 x i8] c"hash\00", align 1
@.str.58 = private unnamed_addr constant [5 x i8] c"info\00", align 1
@.str.59 = private unnamed_addr constant [12 x i8] c"keep-broken\00", align 1
@.str.60 = private unnamed_addr constant [4 x i8] c"lzo\00", align 1
@.str.61 = private unnamed_addr constant [5 x i8] c"lzma\00", align 1
@.str.62 = private unnamed_addr constant [6 x i8] c"level\00", align 1
@.str.63 = private unnamed_addr constant [8 x i8] c"license\00", align 1
@.str.64 = private unnamed_addr constant [7 x i8] c"maxram\00", align 1
@.str.65 = private unnamed_addr constant [12 x i8] c"no-compress\00", align 1
@.str.66 = private unnamed_addr constant [11 x i8] c"nice-level\00", align 1
@.str.67 = private unnamed_addr constant [8 x i8] c"outfile\00", align 1
@.str.68 = private unnamed_addr constant [7 x i8] c"outdir\00", align 1
@.str.69 = private unnamed_addr constant [8 x i8] c"threads\00", align 1
@.str.70 = private unnamed_addr constant [9 x i8] c"progress\00", align 1
@.str.71 = private unnamed_addr constant [6 x i8] c"quiet\00", align 1
@.str.72 = private unnamed_addr constant [11 x i8] c"very-quiet\00", align 1
@.str.73 = private unnamed_addr constant [10 x i8] c"recursive\00", align 1
@.str.74 = private unnamed_addr constant [7 x i8] c"suffix\00", align 1
@.str.75 = private unnamed_addr constant [5 x i8] c"test\00", align 1
@.str.76 = private unnamed_addr constant [10 x i8] c"threshold\00", align 1
@.str.77 = private unnamed_addr constant [10 x i8] c"unlimited\00", align 1
@.str.78 = private unnamed_addr constant [8 x i8] c"verbose\00", align 1
@.str.79 = private unnamed_addr constant [8 x i8] c"version\00", align 1
@.str.80 = private unnamed_addr constant [7 x i8] c"window\00", align 1
@.str.81 = private unnamed_addr constant [5 x i8] c"zpaq\00", align 1
@.str.82 = private unnamed_addr constant [5 x i8] c"fast\00", align 1
@.str.83 = private unnamed_addr constant [5 x i8] c"best\00", align 1
@.str.84 = private unnamed_addr constant [48 x i8] c"bcCdefghHikKlLnN:o:O:p:PrS:tTUm:vVw:z?123456789\00", align 1
@.str.85 = private unnamed_addr constant [42 x i8] c"bcCdDefghHiKlL:nN:o:O:p:PqQrS:tTUm:vVw:z?\00", align 1
@__func__.usage = private unnamed_addr constant [6 x i8] c"usage\00", align 1
@.str.86 = private unnamed_addr constant [18 x i8] c"lrz%s version %s\0A\00", align 1
@.str.87 = private unnamed_addr constant [3 x i8] c"ip\00", align 1
@.str.88 = private unnamed_addr constant [37 x i8] c"Copyright (C) Con Kolivas 2006-2022\0A\00", align 1
@.str.89 = private unnamed_addr constant [15 x i8] c"Based on rzip \00", align 1
@.str.90 = private unnamed_addr constant [42 x i8] c"Copyright (C) Andrew Tridgell 1998-2003\0A\0A\00", align 1
@.str.91 = private unnamed_addr constant [34 x i8] c"Usage: lrz%s [options] <file...>\0A\00", align 1
@.str.92 = private unnamed_addr constant [18 x i8] c"General options:\0A\00", align 1
@.str.93 = private unnamed_addr constant [33 x i8] c"\09-c, --stdout\09\09output to STDOUT\0A\00", align 1
@.str.94 = private unnamed_addr constant [64 x i8] c"\09-C, --check\09\09check integrity of file written on decompression\0A\00", align 1
@.str.95 = private unnamed_addr constant [68 x i8] c"\09-c, -C, --check\09\09check integrity of file written on decompression\0A\00", align 1
@.str.96 = private unnamed_addr constant [30 x i8] c"\09-d, --decompress\09decompress\0A\00", align 1
@.str.97 = private unnamed_addr constant [86 x i8] c"\09-e, --encrypt[=password] password protected sha512/aes128 encryption on compression\0A\00", align 1
@.str.98 = private unnamed_addr constant [28 x i8] c"\09-h, -?, --help\09\09show help\0A\00", align 1
@.str.99 = private unnamed_addr constant [53 x i8] c"\09-H, --hash\09\09display md5 hash integrity information\0A\00", align 1
@.str.100 = private unnamed_addr constant [47 x i8] c"\09-i, --info\09\09show compressed file information\0A\00", align 1
@.str.101 = private unnamed_addr constant [54 x i8] c"\09-L, --license\09\09display software version and license\0A\00", align 1
@.str.102 = private unnamed_addr constant [44 x i8] c"\09-P, --progress\09\09show compression progress\0A\00", align 1
@.str.103 = private unnamed_addr constant [47 x i8] c"\09-q, --quiet\09\09don't show compression progress\0A\00", align 1
@.str.104 = private unnamed_addr constant [41 x i8] c"\09-Q, --very-quiet\09don't show any output\0A\00", align 1
@.str.105 = private unnamed_addr constant [54 x i8] c"\09-r, --recursive\09\09operate recursively on directories\0A\00", align 1
@.str.106 = private unnamed_addr constant [45 x i8] c"\09-t, --test\09\09test compressed file integrity\0A\00", align 1
@.str.107 = private unnamed_addr constant [40 x i8] c"\09-v[v%s], --verbose\09Increase verbosity\0A\00", align 1
@.str.108 = private unnamed_addr constant [2 x i8] c"v\00", align 1
@.str.109 = private unnamed_addr constant [30 x i8] c"\09-V, --version\09\09show version\0A\00", align 1
@.str.110 = private unnamed_addr constant [27 x i8] c"Options affecting output:\0A\00", align 1
@.str.111 = private unnamed_addr constant [38 x i8] c"\09-D, --delete\09\09delete existing files\0A\00", align 1
@.str.112 = private unnamed_addr constant [53 x i8] c"\09-f, --force\09\09force overwrite of any existing files\0A\00", align 1
@.str.113 = private unnamed_addr constant [58 x i8] c"\09-k, --keep\09\09don't delete source files on de/compression\0A\00", align 1
@.str.114 = private unnamed_addr constant [56 x i8] c"\09-K, --keep-broken\09keep broken or damaged output files\0A\00", align 1
@.str.115 = private unnamed_addr constant [66 x i8] c"\09-o, --outfile filename\09specify the output file name and/or path\0A\00", align 1
@.str.116 = private unnamed_addr constant [74 x i8] c"\09-O, --outdir directory\09specify the output directory when -o is not used\0A\00", align 1
@.str.117 = private unnamed_addr constant [65 x i8] c"\09-S, --suffix suffix\09specify compressed suffix (default '.lrz')\0A\00", align 1
@.str.118 = private unnamed_addr constant [32 x i8] c"Options affecting compression:\0A\00", align 1
@.str.119 = private unnamed_addr constant [38 x i8] c"\09--lzma\09\09\09lzma compression (default)\0A\00", align 1
@.str.120 = private unnamed_addr constant [33 x i8] c"\09-b, --bzip2\09\09bzip2 compression\0A\00", align 1
@.str.121 = private unnamed_addr constant [42 x i8] c"\09-g, --gzip\09\09gzip compression using zlib\0A\00", align 1
@.str.122 = private unnamed_addr constant [42 x i8] c"\09-l, --lzo\09\09lzo compression (ultra fast)\0A\00", align 1
@.str.123 = private unnamed_addr constant [74 x i8] c"\09-n, --no-compress\09no backend compression - prepare for other compressor\0A\00", align 1
@.str.124 = private unnamed_addr constant [75 x i8] c"\09-z, --zpaq\09\09zpaq compression (best, extreme compression, extremely slow)\0A\00", align 1
@.str.125 = private unnamed_addr constant [20 x i8] c"Low level options:\0A\00", align 1
@.str.126 = private unnamed_addr constant [67 x i8] c"\09-1 .. -9\09\09set lzma/bzip2/gzip compression level (1-9, default 7)\0A\00", align 1
@.str.127 = private unnamed_addr constant [24 x i8] c"\09--fast\09\09\09alias for -1\0A\00", align 1
@.str.128 = private unnamed_addr constant [24 x i8] c"\09--best\09\09\09alias for -9\0A\00", align 1
@.str.129 = private unnamed_addr constant [75 x i8] c"\09-L, --level level\09set lzma/bzip2/gzip compression level (1-9, default 7)\0A\00", align 1
@.str.130 = private unnamed_addr constant [62 x i8] c"\09-N, --nice-level value\09Set nice value to value (default %d)\0A\00", align 1
@.str.131 = private unnamed_addr constant [72 x i8] c"\09-p, --threads value\09Set processor count to override number of threads\0A\00", align 1
@.str.132 = private unnamed_addr constant [64 x i8] c"\09-m, --maxram size\09Set maximum available ram in hundreds of MB\0A\00", align 1
@.str.133 = private unnamed_addr constant [48 x i8] c"\09\09\09\09overrides detected amount of available ram\0A\00", align 1
@.str.134 = private unnamed_addr constant [55 x i8] c"\09-T, --threshold\09\09Disable LZ4 compressibility testing\0A\00", align 1
@.str.135 = private unnamed_addr constant [86 x i8] c"\09-U, --unlimited\09\09Use unlimited window size beyond ramsize (potentially much slower)\0A\00", align 1
@.str.136 = private unnamed_addr constant [65 x i8] c"\09-w, --window size\09maximum compression window in hundreds of MB\0A\00", align 1
@.str.137 = private unnamed_addr constant [73 x i8] c"\09\09\09\09default chosen by heuristic dependent on ram and chosen compression\0A\00", align 1
@.str.138 = private unnamed_addr constant [80 x i8] c"\0ALRZIP=NOCONFIG environment variable setting can be used to bypass lrzip.conf.\0A\00", align 1
@.str.139 = private unnamed_addr constant [83 x i8] c"TMP environment variable will be used for storage of temporary files when needed.\0A\00", align 1
@.str.140 = private unnamed_addr constant [47 x i8] c"TMPDIR may also be stored in lrzip.conf file.\0A\00", align 1
@.str.141 = private unnamed_addr constant [63 x i8] c"\0AIf no filenames or \22-\22 is specified, stdin/out will be used.\0A\00", align 1
@.str.142 = private unnamed_addr constant [16 x i8] c"lrz version %s\0A\00", align 1
@.str.143 = private unnamed_addr constant [37 x i8] c"Copyright (C) Con Kolivas 2006-2016\0A\00", align 1
@.str.144 = private unnamed_addr constant [78 x i8] c"This is free software.  You may redistribute copies of it under the terms of\0A\00", align 1
@.str.145 = private unnamed_addr constant [72 x i8] c"the GNU General Public License <http://www.gnu.org/licenses/gpl.html>.\0A\00", align 1
@.str.146 = private unnamed_addr constant [55 x i8] c"There is NO WARRANTY, to the extent permitted by law.\0A\00", align 1
@__func__.recurse_dirlist = private unnamed_addr constant [16 x i8] c"recurse_dirlist\00", align 1
@.str.147 = private unnamed_addr constant [29 x i8] c"Unable to open directory %s\0A\00", align 1
@.str.148 = private unnamed_addr constant [2 x i8] c".\00", align 1
@.str.149 = private unnamed_addr constant [3 x i8] c"..\00", align 1
@.str.150 = private unnamed_addr constant [6 x i8] c"%s/%s\00", align 1
@.str.151 = private unnamed_addr constant [24 x i8] c"Unable to stat file %s\0A\00", align 1
@.str.152 = private unnamed_addr constant [21 x i8] c"Not regular file %s\0A\00", align 1
@.str.153 = private unnamed_addr constant [15 x i8] c"Added file %s\0A\00", align 1
@__func__.sighandler = private unnamed_addr constant [11 x i8] c"sighandler\00", align 1
@.str.154 = private unnamed_addr constant [13 x i8] c"Interrupted\0A\00", align 1
@__func__.show_summary = private unnamed_addr constant [13 x i8] c"show_summary\00", align 1
@.str.155 = private unnamed_addr constant [50 x i8] c"The following options are in effect for this %s.\0A\00", align 1
@.str.156 = private unnamed_addr constant [14 x i8] c"DECOMPRESSION\00", align 1
@.str.157 = private unnamed_addr constant [12 x i8] c"COMPRESSION\00", align 1
@.str.158 = private unnamed_addr constant [46 x i8] c"Threading is %s. Number of CPUs detected: %d\0A\00", align 1
@.str.159 = private unnamed_addr constant [8 x i8] c"ENABLED\00", align 1
@.str.160 = private unnamed_addr constant [9 x i8] c"DISABLED\00", align 1
@.str.161 = private unnamed_addr constant [25 x i8] c"Detected %lld bytes ram\0A\00", align 1
@.str.162 = private unnamed_addr constant [22 x i8] c"Compression level %d\0A\00", align 1
@.str.163 = private unnamed_addr constant [16 x i8] c"Nice Value: %d\0A\00", align 1
@.str.164 = private unnamed_addr constant [15 x i8] c"Show Progress\0A\00", align 1
@.str.165 = private unnamed_addr constant [5 x i8] c"Max \00", align 1
@.str.166 = private unnamed_addr constant [9 x i8] c"Verbose\0A\00", align 1
@.str.167 = private unnamed_addr constant [17 x i8] c"Overwrite Files\0A\00", align 1
@.str.168 = private unnamed_addr constant [34 x i8] c"Remove input files on completion\0A\00", align 1
@.str.169 = private unnamed_addr constant [32 x i8] c"Output Directory Specified: %s\0A\00", align 1
@.str.170 = private unnamed_addr constant [31 x i8] c"Output Filename Specified: %s\0A\00", align 1
@.str.171 = private unnamed_addr constant [21 x i8] c"Test file integrity\0A\00", align 1
@.str.172 = private unnamed_addr constant [32 x i8] c"Temporary Directory set as: %s\0A\00", align 1
@.str.173 = private unnamed_addr constant [22 x i8] c"Compression mode is: \00", align 1
@.str.174 = private unnamed_addr constant [38 x i8] c"LZMA. LZ4 Compressibility testing %s\0A\00", align 1
@.str.175 = private unnamed_addr constant [8 x i8] c"enabled\00", align 1
@.str.176 = private unnamed_addr constant [9 x i8] c"disabled\00", align 1
@.str.177 = private unnamed_addr constant [5 x i8] c"LZO\0A\00", align 1
@.str.178 = private unnamed_addr constant [39 x i8] c"BZIP2. LZ4 Compressibility testing %s\0A\00", align 1
@.str.179 = private unnamed_addr constant [6 x i8] c"GZIP\0A\00", align 1
@.str.180 = private unnamed_addr constant [38 x i8] c"ZPAQ. LZ4 Compressibility testing %s\0A\00", align 1
@.str.181 = private unnamed_addr constant [26 x i8] c"RZIP pre-processing only\0A\00", align 1
@.str.182 = private unnamed_addr constant [35 x i8] c"Compression Window: %lld = %lldMB\0A\00", align 1
@.str.183 = private unnamed_addr constant [58 x i8] c"Heuristically Computed Compression Window: %lld = %lldMB\0A\00", align 1
@.str.184 = private unnamed_addr constant [29 x i8] c"Using Unlimited Window size\0A\00", align 1
@.str.185 = private unnamed_addr constant [30 x i8] c"Storage time in seconds %lld\0A\00", align 1
@.str.186 = private unnamed_addr constant [28 x i8] c"Encryption hash loops %lld\0A\00", align 1
@.str.187 = private unnamed_addr constant [14 x i8] c"/proc/meminfo\00", align 1
@.str.1.188 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.2.189 = private unnamed_addr constant [8 x i8] c"lrzip.c\00", align 1
@__func__.get_ram = private unnamed_addr constant [8 x i8] c"get_ram\00", align 1
@.str.3.190 = private unnamed_addr constant [7 x i8] c"fopen\0A\00", align 1
@.str.4.192 = private unnamed_addr constant [17 x i8] c"MemTotal: %ld kB\00", align 1
@.str.5.193 = private unnamed_addr constant [28 x i8] c"Failed to fgets in get_ram\0A\00", align 1
@.str.6.194 = private unnamed_addr constant [7 x i8] c"fclose\00", align 1
@__const.write_magic.magic = private unnamed_addr constant <{ i8, i8, i8, i8, i8, i8, [18 x i8] }> <{ i8 76, i8 82, i8 90, i8 73, i8 0, i8 6, [18 x i8] zeroinitializer }>, align 16
@__func__.write_magic = private unnamed_addr constant [12 x i8] c"write_magic\00", align 1
@.str.7.195 = private unnamed_addr constant [45 x i8] c"Failed to seek to BOF to write Magic Header\0A\00", align 1
@.str.8.196 = private unnamed_addr constant [30 x i8] c"Failed to write magic header\0A\00", align 1
@__func__.read_magic = private unnamed_addr constant [11 x i8] c"read_magic\00", align 1
@.str.9.199 = private unnamed_addr constant [29 x i8] c"Failed to read magic header\0A\00", align 1
@__func__.open_tmpoutfile = private unnamed_addr constant [16 x i8] c"open_tmpoutfile\00", align 1
@.str.10.210 = private unnamed_addr constant [23 x i8] c"Outputting to stdout.\0A\00", align 1
@.str.11.211 = private unnamed_addr constant [33 x i8] c"Failed to allocate outfile name\0A\00", align 1
@.str.12.212 = private unnamed_addr constant [16 x i8] c"lrzipout.XXXXXX\00", align 1
@.str.13.215 = private unnamed_addr constant [102 x i8] c"WARNING: Failed to create out tmpfile: %s, will fail if cannot perform %scompression entirely in ram\0A\00", align 1
@.str.14.213 = private unnamed_addr constant [3 x i8] c"de\00", align 1
@.str.15.214 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.16.216 = private unnamed_addr constant [30 x i8] c"Created temporary outfile %s\0A\00", align 1
@__func__.write_fdout = private unnamed_addr constant [12 x i8] c"write_fdout\00", align 1
@.str.17.217 = private unnamed_addr constant [42 x i8] c"Failed to write to fd_out in write_fdout\0A\00", align 1
@__func__.write_fdin = private unnamed_addr constant [11 x i8] c"write_fdin\00", align 1
@.str.18.227 = private unnamed_addr constant [40 x i8] c"Failed to write to fd_in in write_fdin\0A\00", align 1
@__func__.open_tmpinfile = private unnamed_addr constant [15 x i8] c"open_tmpinfile\00", align 1
@.str.19.228 = private unnamed_addr constant [32 x i8] c"Failed to allocate infile name\0A\00", align 1
@.str.20.229 = private unnamed_addr constant [15 x i8] c"lrzipin.XXXXXX\00", align 1
@.str.21.230 = private unnamed_addr constant [20 x i8] c"/tmp/lrzipin.XXXXXX\00", align 1
@.str.22.231 = private unnamed_addr constant [101 x i8] c"WARNING: Failed to create in tmpfile: %s, will fail if cannot perform %scompression entirely in ram\0A\00", align 1
@.str.23.232 = private unnamed_addr constant [30 x i8] c"Failed to unlink tmpfile: %s\0A\00", align 1
@.str.24.233 = private unnamed_addr constant [21 x i8] c"Copying from stdin.\0A\00", align 1
@.str.25.234 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@__func__.read_tmpinfile = private unnamed_addr constant [15 x i8] c"read_tmpinfile\00", align 1
@.str.26.235 = private unnamed_addr constant [29 x i8] c"Failed to fdopen in tmpfile\0A\00", align 1
@.str.27.236 = private unnamed_addr constant [45 x i8] c"Failed to allocate buffer in read_tmpinfile\0A\00", align 1
@.str.28.237 = private unnamed_addr constant [31 x i8] c"Failed read in read_tmpinfile\0A\00", align 1
@.str.29.238 = private unnamed_addr constant [32 x i8] c"Failed write in read_tmpinfile\0A\00", align 1
@__func__.clear_tmpinfile = private unnamed_addr constant [16 x i8] c"clear_tmpinfile\00", align 1
@.str.30.239 = private unnamed_addr constant [45 x i8] c"Failed to lseek on fd_in in clear_tmpinfile\0A\00", align 1
@.str.31.240 = private unnamed_addr constant [45 x i8] c"Failed to truncate fd_in in clear_tmpinfile\0A\00", align 1
@__func__.decompress_file = private unnamed_addr constant [16 x i8] c"decompress_file\00", align 1
@.str.32.243 = private unnamed_addr constant [24 x i8] c"Output filename is: %s\0A\00", align 1
@.str.33.244 = private unnamed_addr constant [45 x i8] c"Cannot decompress encrypted file from STDIN\0A\00", align 1
@.str.34.245 = private unnamed_addr constant [19 x i8] c"Failed to open %s\0A\00", align 1
@.str.35.246 = private unnamed_addr constant [39 x i8] c"Failed to unlink an existing file: %s\0A\00", align 1
@.str.36.247 = private unnamed_addr constant [21 x i8] c"Failed to create %s\0A\00", align 1
@.str.37.248 = private unnamed_addr constant [32 x i8] c"Failed to open history file %s\0A\00", align 1
@.str.38.249 = private unnamed_addr constant [28 x i8] c"Invalid expected size %lld\0A\00", align 1
@.str.39.250 = private unnamed_addr constant [39 x i8] c"Failed to fstatvfs in decompress_file\0A\00", align 1
@.str.40.251 = private unnamed_addr constant [100 x i8] c"Warning, inadequate free space detected, but attempting to decompress due to -f option being used.\0A\00", align 1
@.str.41.252 = private unnamed_addr constant [63 x i8] c"Inadequate free space to decompress file, use -f to override.\0A\00", align 1
@.str.42.253 = private unnamed_addr constant [31 x i8] c"Not performing MD5 hash check\0A\00", align 1
@.str.43.254 = private unnamed_addr constant [5 x i8] c"MD5 \00", align 1
@.str.44.255 = private unnamed_addr constant [7 x i8] c"CRC32 \00", align 1
@.str.45.256 = private unnamed_addr constant [35 x i8] c"being used for integrity testing.\0A\00", align 1
@.str.46.257 = private unnamed_addr constant [18 x i8] c"Decompressing...\0A\00", align 1
@.str.47.258 = private unnamed_addr constant [2 x i8] c"\0D\00", align 1
@.str.48.259 = private unnamed_addr constant [25 x i8] c"Output filename is: %s: \00", align 1
@.str.49.260 = private unnamed_addr constant [51 x i8] c"[OK] - %lld bytes                                \0A\00", align 1
@.str.50.261 = private unnamed_addr constant [51 x i8] c"[OK]                                             \0A\00", align 1
@.str.51.262 = private unnamed_addr constant [23 x i8] c"Failed to close files\0A\00", align 1
@.str.52.263 = private unnamed_addr constant [21 x i8] c"Failed to unlink %s\0A\00", align 1
@__func__.get_header_info = private unnamed_addr constant [16 x i8] c"get_header_info\00", align 1
@.str.53.280 = private unnamed_addr constant [35 x i8] c"Failed to read in get_header_info\0A\00", align 1
@.str.54.281 = private unnamed_addr constant [34 x i8] c"Failed to read in get_header_info\00", align 1
@.str.55.282 = private unnamed_addr constant [38 x i8] c"Failed to read_i64 in get_header_info\00", align 1
@__func__.get_fileinfo = private unnamed_addr constant [13 x i8] c"get_fileinfo\00", align 1
@.str.56.285 = private unnamed_addr constant [29 x i8] c"bad magic file descriptor!?\0A\00", align 1
@.str.57.286 = private unnamed_addr constant [59 x i8] c"Encrypted lrzip archive. No further information available\0A\00", align 1
@.str.58.287 = private unnamed_addr constant [43 x i8] c"Failed to read chunk_byte in get_fileinfo\0A\00", align 1
@.str.59.288 = private unnamed_addr constant [24 x i8] c"Invalid chunk bytes %d\0A\00", align 1
@.str.60.289 = private unnamed_addr constant [36 x i8] c"Failed to read eof in get_fileinfo\0A\00", align 1
@.str.61.290 = private unnamed_addr constant [43 x i8] c"Failed to read chunk_size in get_fileinfo\0A\00", align 1
@.str.62.291 = private unnamed_addr constant [25 x i8] c"Invalid chunk size %lld\0A\00", align 1
@.str.63.292 = private unnamed_addr constant [22 x i8] c"Rzip chunk:       %d\0A\00", align 1
@.str.64.293 = private unnamed_addr constant [22 x i8] c"Chunk byte width: %d\0A\00", align 1
@.str.65.294 = private unnamed_addr constant [23 x i8] c"Chunk size:       %ld\0A\00", align 1
@.str.66.295 = private unnamed_addr constant [20 x i8] c"Invalid chunk data\0A\00", align 1
@.str.67.296 = private unnamed_addr constant [47 x i8] c"Failed to seek to header data in get_fileinfo\0A\00", align 1
@.str.68.297 = private unnamed_addr constant [12 x i8] c"Stream: %d\0A\00", align 1
@.str.69.298 = private unnamed_addr constant [13 x i8] c"Offset: %ld\0A\00", align 1
@.str.70.299 = private unnamed_addr constant [21 x i8] c"%s\09%s\09%s\09%16s / %14s\00", align 1
@.str.71.300 = private unnamed_addr constant [6 x i8] c"Block\00", align 1
@.str.72.301 = private unnamed_addr constant [5 x i8] c"Comp\00", align 1
@.str.73.302 = private unnamed_addr constant [8 x i8] c"Percent\00", align 1
@.str.74.303 = private unnamed_addr constant [10 x i8] c"Comp Size\00", align 1
@.str.75.304 = private unnamed_addr constant [11 x i8] c"UComp Size\00", align 1
@.str.76.305 = private unnamed_addr constant [12 x i8] c"%18s : %14s\00", align 1
@.str.77.306 = private unnamed_addr constant [7 x i8] c"Offset\00", align 1
@.str.78.307 = private unnamed_addr constant [5 x i8] c"Head\00", align 1
@.str.79.269 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.80.308 = private unnamed_addr constant [54 x i8] c"Invalid earlier last_head position, corrupt archive.\0A\00", align 1
@.str.81.309 = private unnamed_addr constant [71 x i8] c"Offset greater than archive size, likely corrupted/truncated archive.\0A\00", align 1
@.str.82.310 = private unnamed_addr constant [43 x i8] c"Entry negative, likely corrupted archive.\0A\00", align 1
@.str.83.311 = private unnamed_addr constant [4 x i8] c"%d\09\00", align 1
@.str.84.312 = private unnamed_addr constant [5 x i8] c"none\00", align 1
@.str.85.313 = private unnamed_addr constant [6 x i8] c"bzip2\00", align 1
@.str.86.314 = private unnamed_addr constant [4 x i8] c"lzo\00", align 1
@.str.87.315 = private unnamed_addr constant [5 x i8] c"lzma\00", align 1
@.str.88.316 = private unnamed_addr constant [5 x i8] c"gzip\00", align 1
@.str.89.317 = private unnamed_addr constant [5 x i8] c"zpaq\00", align 1
@.str.90.318 = private unnamed_addr constant [10 x i8] c"Dunno wtf\00", align 1
@.str.91.319 = private unnamed_addr constant [23 x i8] c"\09%5.1f%%\09%16ld / %14ld\00", align 1
@.str.92.320 = private unnamed_addr constant [14 x i8] c"%18ld : %14ld\00", align 1
@.str.93.321 = private unnamed_addr constant [39 x i8] c"Failed to lseek c_len in get_fileinfo\0A\00", align 1
@.str.94.322 = private unnamed_addr constant [18 x i8] c"\0ASummary\0A=======\0A\00", align 1
@.str.95.323 = private unnamed_addr constant [33 x i8] c"File: %s\0Alrzip version: %d.%d \0A\0A\00", align 1
@.str.96.324 = private unnamed_addr constant [54 x i8] c"Due to %s, expected decompression size not available\0A\00", align 1
@.str.97.325 = private unnamed_addr constant [22 x i8] c"Compression to STDOUT\00", align 1
@.str.98.326 = private unnamed_addr constant [117 x i8] c"  Stats         Percent       Compressed /   Uncompressed\0A  -------------------------------------------------------\0A\00", align 1
@.str.99.327 = private unnamed_addr constant [39 x i8] c"  Rzip:         %5.1f%%\09%16ld / %14ld\0A\00", align 1
@.str.100.328 = private unnamed_addr constant [39 x i8] c"  Back end:     %5.1f%%\09%16ld / %14ld\0A\00", align 1
@.str.101.329 = private unnamed_addr constant [39 x i8] c"  Overall:      %5.1f%%\09%16ld / %14ld\0A\00", align 1
@.str.102.330 = private unnamed_addr constant [29 x i8] c"  Rzip:         Unavailable\0A\00", align 1
@.str.103.331 = private unnamed_addr constant [29 x i8] c"  Overall:      Unavailable\0A\00", align 1
@.str.104.332 = private unnamed_addr constant [23 x i8] c"  Compression Method: \00", align 1
@.str.105.333 = private unnamed_addr constant [12 x i8] c"rzip alone\0A\00", align 1
@.str.106.334 = private unnamed_addr constant [14 x i8] c"rzip + bzip2\0A\00", align 1
@.str.107.335 = private unnamed_addr constant [12 x i8] c"rzip + lzo\0A\00", align 1
@.str.108.336 = private unnamed_addr constant [13 x i8] c"rzip + lzma\0A\00", align 1
@.str.109.337 = private unnamed_addr constant [13 x i8] c"rzip + gzip\0A\00", align 1
@.str.110.338 = private unnamed_addr constant [13 x i8] c"rzip + zpaq\0A\00", align 1
@.str.111.339 = private unnamed_addr constant [11 x i8] c"Dunno wtf\0A\00", align 1
@.str.112.340 = private unnamed_addr constant [33 x i8] c"  Decompressed file size: %14lu\0A\00", align 1
@.str.113.341 = private unnamed_addr constant [33 x i8] c"  Compressed file size:   %14lu\0A\00", align 1
@.str.114.342 = private unnamed_addr constant [36 x i8] c"  Compression ratio:      %14.3Lfx\0A\00", align 1
@.str.115.343 = private unnamed_addr constant [42 x i8] c"  Decompressed file size:    Unavailable\0A\00", align 1
@.str.116.344 = private unnamed_addr constant [42 x i8] c"  Compression ratio:         Unavailable\0A\00", align 1
@.str.117.345 = private unnamed_addr constant [41 x i8] c"Failed to seek to md5 data in runzip_fd\0A\00", align 1
@.str.118.346 = private unnamed_addr constant [38 x i8] c"Failed to read md5 data in runzip_fd\0A\00", align 1
@.str.119.347 = private unnamed_addr constant [18 x i8] c"\0A  MD5 Checksum: \00", align 1
@.str.120.348 = private unnamed_addr constant [5 x i8] c"%02x\00", align 1
@.str.121.349 = private unnamed_addr constant [37 x i8] c"\0A  CRC32 used for integrity testing\0A\00", align 1
@.str.122.350 = private unnamed_addr constant [39 x i8] c"Failed to close fd_in in get_fileinfo\0A\00", align 1
@__func__.compress_file = private unnamed_addr constant [14 x i8] c"compress_file\00", align 1
@.str.123.353 = private unnamed_addr constant [40 x i8] c"%s: already has %s suffix. Skipping...\0A\00", align 1
@.str.124.354 = private unnamed_addr constant [42 x i8] c"Suffix added to %s.\0AFull pathname is: %s\0A\00", align 1
@.str.125.355 = private unnamed_addr constant [26 x i8] c"Cannot write file header\0A\00", align 1
@.str.126.356 = private unnamed_addr constant [41 x i8] c"Failed to preserve times on output file\0A\00", align 1
@.str.127.357 = private unnamed_addr constant [23 x i8] c"Failed to close fd_in\0A\00", align 1
@.str.128.358 = private unnamed_addr constant [24 x i8] c"Failed to close fd_out\0A\00", align 1
@__const.initialise_control.localeptr = private unnamed_addr constant [3 x i8] c"./\00", align 1
@.str.129.361 = private unnamed_addr constant [5 x i8] c".lrz\00", align 1
@__func__.initialise_control = private unnamed_addr constant [19 x i8] c"initialise_control\00", align 1
@.str.130.362 = private unnamed_addr constant [29 x i8] c"Failed to call time in main\0A\00", align 1
@.str.131.363 = private unnamed_addr constant [71 x i8] c"Warning your time reads before the year 2011, check your system clock\0A\00", align 1
@.str.132.364 = private unnamed_addr constant [7 x i8] c"TMPDIR\00", align 1
@.str.133.365 = private unnamed_addr constant [4 x i8] c"TMP\00", align 1
@.str.134.366 = private unnamed_addr constant [8 x i8] c"TEMPDIR\00", align 1
@.str.135.367 = private unnamed_addr constant [5 x i8] c"TEMP\00", align 1
@.str.136.368 = private unnamed_addr constant [31 x i8] c"Failed to allocate for tmpdir\0A\00", align 1
@__func__.fdout_seekto = private unnamed_addr constant [13 x i8] c"fdout_seekto\00", align 1
@.str.137.197 = private unnamed_addr constant [59 x i8] c"Trying to seek to %lld outside tmp outbuf in fdout_seekto\0A\00", align 1
@.str.138.200 = private unnamed_addr constant [5 x i8] c"LRZI\00", align 1
@__func__.get_magic = private unnamed_addr constant [10 x i8] c"get_magic\00", align 1
@.str.139.201 = private unnamed_addr constant [19 x i8] c"Not an lrzip file\0A\00", align 1
@.str.140.203 = private unnamed_addr constant [36 x i8] c"Detected lrzip version %d.%d file.\0A\00", align 1
@.str.141.205 = private unnamed_addr constant [74 x i8] c"Attempting to work with file produced by newer lrzip version %d.%d file.\0A\00", align 1
@.str.142.206 = private unnamed_addr constant [35 x i8] c"Unknown hash, falling back to CRC\0A\00", align 1
@.str.143.207 = private unnamed_addr constant [20 x i8] c"Unknown encryption\0A\00", align 1
@.str.144.208 = private unnamed_addr constant [28 x i8] c"Encryption hash loops %lld\0A\00", align 1
@.str.145.209 = private unnamed_addr constant [65 x i8] c"Asked to decrypt a non-encrypted archive. Bypassing decryption.\0A\00", align 1
@__func__.flush_tmpoutbuf = private unnamed_addr constant [16 x i8] c"flush_tmpoutbuf\00", align 1
@.str.146.225 = private unnamed_addr constant [34 x i8] c"Dumping buffer to physical file.\0A\00", align 1
@__func__.fwrite_stdout = private unnamed_addr constant [14 x i8] c"fwrite_stdout\00", align 1
@.str.147.226 = private unnamed_addr constant [35 x i8] c"Failed to fwrite in fwrite_stdout\0A\00", align 1
@__func__.dump_tmpoutfile = private unnamed_addr constant [16 x i8] c"dump_tmpoutfile\00", align 1
@.str.148.218 = private unnamed_addr constant [59 x i8] c"Failed: No temporary outfile created, unable to do in ram\0A\00", align 1
@.str.149.219 = private unnamed_addr constant [30 x i8] c"Failed to fdopen out tmpfile\0A\00", align 1
@.str.150.220 = private unnamed_addr constant [45 x i8] c"Dumping temporary file to control->outFILE.\0A\00", align 1
@.str.151.221 = private unnamed_addr constant [46 x i8] c"Failed to allocate buffer in dump_tmpoutfile\0A\00", align 1
@.str.152.222 = private unnamed_addr constant [32 x i8] c"Failed read in dump_tmpoutfile\0A\00", align 1
@.str.153.223 = private unnamed_addr constant [33 x i8] c"Failed write in dump_tmpoutfile\0A\00", align 1
@.str.154.224 = private unnamed_addr constant [47 x i8] c"Failed to ftruncate fd_out in dump_tmpoutfile\0A\00", align 1
@__func__.read_tmpinmagic = private unnamed_addr constant [16 x i8] c"read_tmpinmagic\00", align 1
@.str.155.279 = private unnamed_addr constant [60 x i8] c"Reached end of file on STDIN prematurely on v05 magic read\0A\00", align 1
@__func__.open_tmpinbuf = private unnamed_addr constant [14 x i8] c"open_tmpinbuf\00", align 1
@.str.156.278 = private unnamed_addr constant [45 x i8] c"Failed to malloc tmp_inbuf in open_tmpinbuf\0A\00", align 1
@__func__.preserve_perms = private unnamed_addr constant [15 x i8] c"preserve_perms\00", align 1
@.str.157.264 = private unnamed_addr constant [28 x i8] c"Failed to fstat input file\0A\00", align 1
@.str.158.276 = private unnamed_addr constant [42 x i8] c"Warning, unable to set permissions on %s\0A\00", align 1
@.str.159.277 = private unnamed_addr constant [36 x i8] c"Warning, unable to set owner on %s\0A\00", align 1
@__func__.open_tmpoutbuf = private unnamed_addr constant [15 x i8] c"open_tmpoutbuf\00", align 1
@.str.160.274 = private unnamed_addr constant [29 x i8] c"Malloced %ld for tmp_outbuf\0A\00", align 1
@.str.161.275 = private unnamed_addr constant [44 x i8] c"Unable to even malloc 100MB for tmp_outbuf\0A\00", align 1
@__func__.get_hash = private unnamed_addr constant [9 x i8] c"get_hash\00", align 1
@.str.162.266 = private unnamed_addr constant [51 x i8] c"Failed to calloc encrypt buffers in compress_file\0A\00", align 1
@.str.163.267 = private unnamed_addr constant [28 x i8] c"Supplied password was null!\00", align 1
@.str.164.268 = private unnamed_addr constant [19 x i8] c"Enter passphrase: \00", align 1
@.str.165.270 = private unnamed_addr constant [22 x i8] c"Re-enter passphrase: \00", align 1
@.str.166.271 = private unnamed_addr constant [36 x i8] c"Passwords do not match. Try again.\0A\00", align 1
@__func__.get_pass = private unnamed_addr constant [9 x i8] c"get_pass\00", align 1
@.str.167.272 = private unnamed_addr constant [31 x i8] c"Failed to retrieve passphrase\0A\00", align 1
@.str.168.273 = private unnamed_addr constant [18 x i8] c"Empty passphrase\0A\00", align 1
@__func__.preserve_times = private unnamed_addr constant [15 x i8] c"preserve_times\00", align 1
@.str.169.265 = private unnamed_addr constant [35 x i8] c"Warning, unable to set time on %s\0A\00", align 1
@.str.371 = private unnamed_addr constant [7 x i8] c"rzip.c\00", align 1
@__func__.rzip_fd = private unnamed_addr constant [8 x i8] c"rzip_fd\00", align 1
@.str.1.372 = private unnamed_addr constant [45 x i8] c"Failed to allocate control state in rzip_fd\0A\00", align 1
@.str.2.374 = private unnamed_addr constant [19 x i8] c"lzo_init() failed\0A\00", align 1
@.str.3.375 = private unnamed_addr constant [33 x i8] c"Failed to stat fd_in in rzip_fd\0A\00", align 1
@.str.4.376 = private unnamed_addr constant [17 x i8] c"File size: %lld\0A\00", align 1
@.str.5.378 = private unnamed_addr constant [37 x i8] c"Failed to fstatvfs in compress_file\0A\00", align 1
@.str.6.379 = private unnamed_addr constant [107 x i8] c"Warning, possibly inadequate free space detected, but attempting to compress due to -f option being used.\0A\00", align 1
@.str.7.380 = private unnamed_addr constant [70 x i8] c"Possibly inadequate free space to compress file, use -f to override.\0A\00", align 1
@levels = internal global [10 x %struct.level] [%struct.level { i64 1, i32 4, i32 1 }, %struct.level { i64 2, i32 4, i32 2 }, %struct.level { i64 4, i32 4, i32 2 }, %struct.level { i64 8, i32 4, i32 2 }, %struct.level { i64 16, i32 4, i32 3 }, %struct.level { i64 32, i32 4, i32 4 }, %struct.level { i64 32, i32 2, i32 6 }, %struct.level { i64 64, i32 1, i32 16 }, %struct.level { i64 64, i32 1, i32 32 }, %struct.level { i64 64, i32 1, i32 128 }], align 16
@.str.8.381 = private unnamed_addr constant [19 x i8] c"Failed to mmap %s\0A\00", align 1
@.str.9.382 = private unnamed_addr constant [24 x i8] c"Unable to mmap any ram\0A\00", align 1
@.str.10.383 = private unnamed_addr constant [83 x i8] c"Enabling sliding mmap mode and using mmap of %lld bytes with window of %lld bytes\0A\00", align 1
@.str.11.384 = private unnamed_addr constant [62 x i8] c"Succeeded in testing %lld sized mmap for rzip pre-processing\0A\00", align 1
@.str.12.385 = private unnamed_addr constant [94 x i8] c"Compression window is larger than ram, will proceed with unlimited mode possibly much slower\0A\00", align 1
@.str.13.386 = private unnamed_addr constant [18 x i8] c"Will take 1 pass\0A\00", align 1
@.str.14.387 = private unnamed_addr constant [21 x i8] c"Will take %d passes\0A\00", align 1
@.str.15.388 = private unnamed_addr constant [18 x i8] c"Chunk size: %lld\0A\00", align 1
@.str.16.389 = private unnamed_addr constant [16 x i8] c"Byte width: %d\0A\00", align 1
@.str.17.390 = private unnamed_addr constant [96 x i8] c"\0APass %d / %d -- Elapsed Time: %02d:%02d:%02d. ETA: %02d:%02d:%02d. Compress Speed: %3.3fMB/s.\0A\00", align 1
@.str.18.391 = private unnamed_addr constant [70 x i8] c"\0APass %d -- Elapsed Time: %02d:%02d:%02d. Compress Speed: %3.3fMB/s.\0A\00", align 1
@.str.19.392 = private unnamed_addr constant [66 x i8] c"Wrote EOF to file yet chunk_size was shrunk, corrupting archive.\0A\00", align 1
@.str.20.393 = private unnamed_addr constant [46 x i8] c"Failed to close_streamout_threads in rzip_fd\0A\00", align 1
@.str.21.394 = private unnamed_addr constant [6 x i8] c"MD5: \00", align 1
@.str.22.395 = private unnamed_addr constant [5 x i8] c"%02x\00", align 1
@.str.23.396 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.24.397 = private unnamed_addr constant [34 x i8] c"Failed to lrz_encrypt in rzip_fd\0A\00", align 1
@.str.25.398 = private unnamed_addr constant [32 x i8] c"Failed to write md5 in rzip_fd\0A\00", align 1
@.str.26.399 = private unnamed_addr constant [35 x i8] c"Failed to flush_tmpout in rzip_fd\0A\00", align 1
@.str.27.400 = private unnamed_addr constant [27 x i8] c"matches=%u match_bytes=%u\0A\00", align 1
@.str.28.401 = private unnamed_addr constant [30 x i8] c"literals=%u literal_bytes=%u\0A\00", align 1
@.str.29.402 = private unnamed_addr constant [46 x i8] c"true_tag_positives=%u false_tag_positives=%u\0A\00", align 1
@.str.30.403 = private unnamed_addr constant [23 x i8] c"inserts=%u match %.3f\0A\00", align 1
@.str.31.404 = private unnamed_addr constant [6 x i8] c"%s - \00", align 1
@.str.32.405 = private unnamed_addr constant [64 x i8] c"Compression Ratio: %.3f. Average Compression Speed: %6.3fMB/s.\0A\00", align 1
@.str.33.423 = private unnamed_addr constant [9 x i8] c"./util.h\00", align 1
@__func__.cksem_init = private unnamed_addr constant [11 x i8] c"cksem_init\00", align 1
@.str.34.439 = private unnamed_addr constant [35 x i8] c"Failed to sem_init ret=%d errno=%d\00", align 1
@__func__.cksem_post = private unnamed_addr constant [11 x i8] c"cksem_post\00", align 1
@.str.35.438 = private unnamed_addr constant [39 x i8] c"Failed to sem_post errno=%d cksem=0x%p\00", align 1
@__func__.mmap_stdin = private unnamed_addr constant [11 x i8] c"mmap_stdin\00", align 1
@.str.36.435 = private unnamed_addr constant [30 x i8] c"Failed to read in mmap_stdin\0A\00", align 1
@.str.37.436 = private unnamed_addr constant [25 x i8] c"Shrinking chunk to %lld\0A\00", align 1
@.str.38.437 = private unnamed_addr constant [46 x i8] c"Failed to remap to smaller buf in mmap_stdin\0A\00", align 1
@__func__.remap_high_sb = private unnamed_addr constant [14 x i8] c"remap_high_sb\00", align 1
@.str.39.432 = private unnamed_addr constant [35 x i8] c"Failed to munmap in remap_high_sb\0A\00", align 1
@.str.40.433 = private unnamed_addr constant [36 x i8] c"Failed to re mmap in remap_high_sb\0A\00", align 1
@__func__.sliding_get_sb_range = private unnamed_addr constant [21 x i8] c"sliding_get_sb_range\00", align 1
@.str.41.434 = private unnamed_addr constant [51 x i8] c"sliding_get_sb_range: the pointer is out of range\0A\00", align 1
@__func__.rzip_chunk = private unnamed_addr constant [11 x i8] c"rzip_chunk\00", align 1
@.str.42.406 = private unnamed_addr constant [38 x i8] c"Failed to open streams in rzip_chunk\0A\00", align 1
@.str.43.407 = private unnamed_addr constant [37 x i8] c"Beginning rzip pre-processing phase\0A\00", align 1
@.str.44.408 = private unnamed_addr constant [32 x i8] c"Failed to munmap in rzip_chunk\0A\00", align 1
@.str.45.409 = private unnamed_addr constant [45 x i8] c"Failed to flush/close streams in rzip_chunk\0A\00", align 1
@__func__.init_sliding_mmap = private unnamed_addr constant [18 x i8] c"init_sliding_mmap\00", align 1
@.str.46.431 = private unnamed_addr constant [46 x i8] c"Unable to mmap buf_high in init_sliding_mmap\0A\00", align 1
@__func__.hash_search = private unnamed_addr constant [12 x i8] c"hash_search\00", align 1
@.str.47.411 = private unnamed_addr constant [38 x i8] c"hashsize = %lld.  bits = %lld. %luMB\0A\00", align 1
@.str.48.412 = private unnamed_addr constant [46 x i8] c"Failed to allocate hash table in hash_search\0A\00", align 1
@.str.49.413 = private unnamed_addr constant [15 x i8] c"Total: %2d%%  \00", align 1
@.str.50.414 = private unnamed_addr constant [14 x i8] c"Chunk: %2d%%\0D\00", align 1
@.str.51.415 = private unnamed_addr constant [39 x i8] c"Failed to malloc ckbuf in hash_search\0A\00", align 1
@.str.52.416 = private unnamed_addr constant [33 x i8] c"Malloced %ld for checksum ckbuf\0A\00", align 1
@.str.53.417 = private unnamed_addr constant [45 x i8] c"Failed to malloc any ram for checksum ckbuf\0A\00", align 1
@__func__.remap_low_sb = private unnamed_addr constant [13 x i8] c"remap_low_sb\00", align 1
@.str.54.428 = private unnamed_addr constant [36 x i8] c"Sliding main buffer to offset %lld\0A\00", align 1
@.str.55.429 = private unnamed_addr constant [34 x i8] c"Failed to munmap in remap_low_sb\0A\00", align 1
@.str.56.430 = private unnamed_addr constant [35 x i8] c"Failed to re mmap in remap_low_sb\0A\00", align 1
@insert_hash.victim_round = internal global i64 0, align 8
@__func__.clean_one_from_hash = private unnamed_addr constant [20 x i8] c"clean_one_from_hash\00", align 1
@.str.57.427 = private unnamed_addr constant [28 x i8] c"Starting sweep for mask %u\0A\00", align 1
@__func__.cksem_wait = private unnamed_addr constant [11 x i8] c"cksem_wait\00", align 1
@.str.58.424 = private unnamed_addr constant [39 x i8] c"Failed to sem_wait errno=%d cksem=0x%p\00", align 1
@__func__.show_distrib = private unnamed_addr constant [13 x i8] c"show_distrib\00", align 1
@.str.59.419 = private unnamed_addr constant [37 x i8] c"WARNING: hash_count says total %lld\0A\00", align 1
@.str.60.421 = private unnamed_addr constant [16 x i8] c"0 total hashes\0A\00", align 1
@.str.61.422 = private unnamed_addr constant [56 x i8] c"%lld total hashes -- %lld in primary bucket (%-2.3f%%)\0A\00", align 1
@__func__.add_to_sslist = private unnamed_addr constant [14 x i8] c"add_to_sslist\00", align 1
@.str.62.410 = private unnamed_addr constant [47 x i8] c"Failed to calloc struct node in add_to_sslist\0A\00", align 1
@.str.442 = private unnamed_addr constant [9 x i8] c"runzip.c\00", align 1
@__func__.runzip_fd = private unnamed_addr constant [10 x i8] c"runzip_fd\00", align 1
@.str.1.443 = private unnamed_addr constant [37 x i8] c"Failed to runzip_chunk in runzip_fd\0A\00", align 1
@.str.2.445 = private unnamed_addr constant [37 x i8] c"Failed to flush_tmpout in runzip_fd\0A\00", align 1
@.str.3.446 = private unnamed_addr constant [40 x i8] c"Failed to clear_tmpinfile in runzip_fd\0A\00", align 1
@.str.4.447 = private unnamed_addr constant [41 x i8] c"\0AAverage DeCompression Speed: %6.3fMB/s\0A\00", align 1
@.str.5.449 = private unnamed_addr constant [37 x i8] c"Failed to seekto_fdinend in rzip_fd\0A\00", align 1
@.str.6.451 = private unnamed_addr constant [34 x i8] c"Failed to seekto_fdin in rzip_fd\0A\00", align 1
@.str.7.452 = private unnamed_addr constant [38 x i8] c"Failed to read md5 data in runzip_fd\0A\00", align 1
@.str.8.454 = private unnamed_addr constant [26 x i8] c"MD5 CHECK FAILED.\0AStored:\00", align 1
@.str.9.455 = private unnamed_addr constant [5 x i8] c"%02x\00", align 1
@.str.10.456 = private unnamed_addr constant [14 x i8] c"\0AOutput file:\00", align 1
@.str.11.457 = private unnamed_addr constant [2 x i8] c"\0A\00", align 1
@.str.12.458 = private unnamed_addr constant [6 x i8] c"MD5: \00", align 1
@.str.13.459 = private unnamed_addr constant [38 x i8] c"Failed to seekto_fdhist in runzip_fd\0A\00", align 1
@.str.14.460 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.15.461 = private unnamed_addr constant [39 x i8] c"Failed to fdopen fd_hist in runzip_fd\0A\00", align 1
@.str.16.462 = private unnamed_addr constant [35 x i8] c"Failed to md5_stream in runzip_fd\0A\00", align 1
@.str.17.463 = private unnamed_addr constant [47 x i8] c"MD5 integrity of written file matches archive\0A\00", align 1
@.str.18.464 = private unnamed_addr constant [158 x i8] c"Note this lrzip archive did not have a stored md5 value.\0AThe archive decompression was validated with crc32 and the md5 hash was calculated on decompression\0A\00", align 1
@__const.runzip_chunk.divisor = private unnamed_addr constant [4 x i64] [i64 1, i64 1024, i64 1048576, i64 1073741824], align 16
@.str.19.496 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.20.497 = private unnamed_addr constant [3 x i8] c"KB\00", align 1
@.str.21.498 = private unnamed_addr constant [3 x i8] c"MB\00", align 1
@.str.22.499 = private unnamed_addr constant [3 x i8] c"GB\00", align 1
@__const.runzip_chunk.suffix = private unnamed_addr constant [4 x ptr] [ptr @.str.19.496, ptr @.str.20.497, ptr @.str.21.498, ptr @.str.22.499], align 16
@__func__.runzip_chunk = private unnamed_addr constant [13 x i8] c"runzip_chunk\00", align 1
@.str.23.468 = private unnamed_addr constant [29 x i8] c"Reading chunk_bytes at %lld\0A\00", align 1
@.str.24.469 = private unnamed_addr constant [49 x i8] c"Failed to read chunk_bytes size in runzip_chunk\0A\00", align 1
@.str.25.470 = private unnamed_addr constant [43 x i8] c"chunk_bytes %d is invalid in runzip_chunk\0A\00", align 1
@.str.26.471 = private unnamed_addr constant [21 x i8] c"Expected size: %lld\0A\00", align 1
@.str.27.472 = private unnamed_addr constant [22 x i8] c"Chunk byte width: %d\0A\00", align 1
@.str.28.473 = private unnamed_addr constant [40 x i8] c"Failed to seek input file in runzip_fd\0A\00", align 1
@.str.29.474 = private unnamed_addr constant [42 x i8] c"Failed to open_stream_in in runzip_chunk\0A\00", align 1
@.str.30.475 = private unnamed_addr constant [25 x i8] c"%3d%%  %9.2f / %9.2f %s\0D\00", align 1
@.str.31.476 = private unnamed_addr constant [41 x i8] c"Bad checksum: 0x%08x - expected: 0x%08x\0A\00", align 1
@.str.32.477 = private unnamed_addr constant [28 x i8] c"Checksum for block: 0x%08x\0A\00", align 1
@.str.33.478 = private unnamed_addr constant [25 x i8] c"Failed to close stream!\0A\00", align 1
@__func__.read_u8 = private unnamed_addr constant [8 x i8] c"read_u8\00", align 1
@.str.34.495 = private unnamed_addr constant [23 x i8] c"Stream read u8 failed\0A\00", align 1
@__func__.read_vchars = private unnamed_addr constant [12 x i8] c"read_vchars\00", align 1
@.str.35.489 = private unnamed_addr constant [32 x i8] c"Stream read of %d bytes failed\0A\00", align 1
@__func__.unzip_literal = private unnamed_addr constant [14 x i8] c"unzip_literal\00", align 1
@.str.36.491 = private unnamed_addr constant [40 x i8] c"len %lld is negative in unzip_literal!\0A\00", align 1
@.str.37.492 = private unnamed_addr constant [46 x i8] c"Failed to malloc literal buffer of size %lld\0A\00", align 1
@.str.38.493 = private unnamed_addr constant [40 x i8] c"Failed to read_stream in unzip_literal\0A\00", align 1
@.str.39.494 = private unnamed_addr constant [45 x i8] c"Failed to write literal buffer of size %lld\0A\00", align 1
@__func__.unzip_match = private unnamed_addr constant [12 x i8] c"unzip_match\00", align 1
@.str.40.481 = private unnamed_addr constant [38 x i8] c"len %lld is negative in unzip_match!\0A\00", align 1
@.str.41.482 = private unnamed_addr constant [41 x i8] c"Seek failed on out file in unzip_match.\0A\00", align 1
@.str.42.483 = private unnamed_addr constant [58 x i8] c"Seek failed by %d from %d on history file in unzip_match\0A\00", align 1
@.str.43.484 = private unnamed_addr constant [57 x i8] c"Failed fd history in unzip_match due to corrupt archive\0A\00", align 1
@.str.44.485 = private unnamed_addr constant [44 x i8] c"Failed to malloc match buffer of size %lld\0A\00", align 1
@.str.45.486 = private unnamed_addr constant [40 x i8] c"Failed to read %d bytes in unzip_match\0A\00", align 1
@.str.46.487 = private unnamed_addr constant [41 x i8] c"Failed to write %d bytes in unzip_match\0A\00", align 1
@__func__.read_fdhist = private unnamed_addr constant [12 x i8] c"read_fdhist\00", align 1
@.str.47.488 = private unnamed_addr constant [55 x i8] c"Trying to read beyond end of tmpoutbuf in read_fdhist\0A\00", align 1
@__func__.read_u32 = private unnamed_addr constant [9 x i8] c"read_u32\00", align 1
@.str.48.479 = private unnamed_addr constant [24 x i8] c"Stream read u32 failed\0A\00", align 1
@__func__.seekto_fdinend = private unnamed_addr constant [15 x i8] c"seekto_fdinend\00", align 1
@.str.49.467 = private unnamed_addr constant [37 x i8] c"Trying to read greater than max_len\0A\00", align 1
@__func__.seekto_fdin = private unnamed_addr constant [12 x i8] c"seekto_fdin\00", align 1
@.str.50.466 = private unnamed_addr constant [56 x i8] c"Trying to seek outside tmpinbuf to %lld in seekto_fdin\0A\00", align 1
@__func__.seekto_fdhist = private unnamed_addr constant [14 x i8] c"seekto_fdhist\00", align 1
@.str.51.465 = private unnamed_addr constant [59 x i8] c"Trying to seek outside tmpoutbuf to %lld in seekto_fdhist\0A\00", align 1
@.str.502 = private unnamed_addr constant [9 x i8] c"stream.c\00", align 1
@__func__.init_mutex = private unnamed_addr constant [11 x i8] c"init_mutex\00", align 1
@.str.1.503 = private unnamed_addr constant [30 x i8] c"Failed to pthread_mutex_init\0A\00", align 1
@__func__.unlock_mutex = private unnamed_addr constant [13 x i8] c"unlock_mutex\00", align 1
@.str.2.505 = private unnamed_addr constant [32 x i8] c"Failed to pthread_mutex_unlock\0A\00", align 1
@__func__.lock_mutex = private unnamed_addr constant [11 x i8] c"lock_mutex\00", align 1
@.str.3.506 = private unnamed_addr constant [30 x i8] c"Failed to pthread_mutex_lock\0A\00", align 1
@__func__.create_pthread = private unnamed_addr constant [15 x i8] c"create_pthread\00", align 1
@.str.4.509 = private unnamed_addr constant [26 x i8] c"Failed to pthread_create\0A\00", align 1
@__func__.detach_pthread = private unnamed_addr constant [15 x i8] c"detach_pthread\00", align 1
@.str.5.510 = private unnamed_addr constant [26 x i8] c"Failed to pthread_detach\0A\00", align 1
@__func__.join_pthread = private unnamed_addr constant [13 x i8] c"join_pthread\00", align 1
@.str.6.511 = private unnamed_addr constant [24 x i8] c"Failed to pthread_join\0A\00", align 1
@__func__.put_fdout = private unnamed_addr constant [10 x i8] c"put_fdout\00", align 1
@.str.7.516 = private unnamed_addr constant [63 x i8] c"Unable to %scompress entirely in ram, will use physical files\0A\00", align 1
@.str.8.514 = private unnamed_addr constant [3 x i8] c"de\00", align 1
@.str.9.515 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@.str.10.518 = private unnamed_addr constant [86 x i8] c"Was unable to %scompress entirely in ram and no temporary file creation was possible\0A\00", align 1
@.str.11.520 = private unnamed_addr constant [46 x i8] c"Unable to write_fdout tmpoutbuf in put_fdout\0A\00", align 1
@__func__.read_1g = private unnamed_addr constant [8 x i8] c"read_1g\00", align 1
@.str.12.526 = private unnamed_addr constant [72 x i8] c"Inadequate ram to %scompress from STDIN and unable to create in tmpfile\00", align 1
@.str.13.527 = private unnamed_addr constant [44 x i8] c"Trying to read beyond out_ofs in tmpoutbuf\0A\00", align 1
@__func__.get_readseek = private unnamed_addr constant [13 x i8] c"get_readseek\00", align 1
@.str.14.531 = private unnamed_addr constant [29 x i8] c"Failed to lseek in get_seek\0A\00", align 1
@__func__.prepare_streamout_threads = private unnamed_addr constant [26 x i8] c"prepare_streamout_threads\00", align 1
@.str.15.534 = private unnamed_addr constant [55 x i8] c"Unable to calloc threads in prepare_streamout_threads\0A\00", align 1
@cthreads = internal global ptr null, align 8
@.str.16.535 = private unnamed_addr constant [56 x i8] c"Unable to calloc cthreads in prepare_streamout_threads\0A\00", align 1
@output_thread = internal global i64 0, align 8
@__func__.open_stream_out = private unnamed_addr constant [16 x i8] c"open_stream_out\00", align 1
@.str.17.550 = private unnamed_addr constant [58 x i8] c"Minimising number of threads to %d to limit memory usage\0A\00", align 1
@.str.18.551 = private unnamed_addr constant [53 x i8] c"Warning, low memory for chosen compression settings\0A\00", align 1
@.str.19.552 = private unnamed_addr constant [48 x i8] c"Unable to allocate enough memory for operation\0A\00", align 1
@.str.20.553 = private unnamed_addr constant [65 x i8] c"Succeeded in testing %lld sized malloc for back end compression\0A\00", align 1
@.str.21.554 = private unnamed_addr constant [59 x i8] c"Using up to %d threads to compress up to %lld bytes each.\0A\00", align 1
@.str.22.555 = private unnamed_addr constant [50 x i8] c"Using only 1 thread to compress up to %lld bytes\0A\00", align 1
@.str.23.556 = private unnamed_addr constant [57 x i8] c"Unable to malloc buffer of size %lld in open_stream_out\0A\00", align 1
@__func__.open_stream_in = private unnamed_addr constant [15 x i8] c"open_stream_in\00", align 1
@.str.24.559 = private unnamed_addr constant [46 x i8] c"Unable to calloc ucthreads in open_stream_in\0A\00", align 1
@.str.25.560 = private unnamed_addr constant [26 x i8] c"Reading eof flag at %lld\0A\00", align 1
@.str.26.562 = private unnamed_addr constant [43 x i8] c"Failed to read eof flag in open_stream_in\0A\00", align 1
@.str.27.563 = private unnamed_addr constant [9 x i8] c"EOF: %d\0A\00", align 1
@.str.28.564 = private unnamed_addr constant [36 x i8] c"Reading expected chunksize at %lld\0A\00", align 1
@.str.29.565 = private unnamed_addr constant [48 x i8] c"Failed to read in chunk size in open_stream_in\0A\00", align 1
@.str.30.567 = private unnamed_addr constant [18 x i8] c"Chunk size: %lld\0A\00", align 1
@.str.31.568 = private unnamed_addr constant [39 x i8] c"Invalid chunk data size %d bytes %lld\0A\00", align 1
@.str.32.570 = private unnamed_addr constant [34 x i8] c"Reading stream %d header at %lld\0A\00", align 1
@.str.33.571 = private unnamed_addr constant [34 x i8] c"Enabling stream close workaround\0A\00", align 1
@.str.34.572 = private unnamed_addr constant [38 x i8] c"Unexpected initial tag %d in streams\0A\00", align 1
@.str.35.573 = private unnamed_addr constant [17 x i8] c"Wrong password?\0A\00", align 1
@.str.36.574 = private unnamed_addr constant [47 x i8] c"Unexpected initial c_len %lld in streams %lld\0A\00", align 1
@.str.37.575 = private unnamed_addr constant [42 x i8] c"Unexpected initial u_len %lld in streams\0A\00", align 1
@__func__.read_stream = private unnamed_addr constant [12 x i8] c"read_stream\00", align 1
@.str.38.642 = private unnamed_addr constant [52 x i8] c"Stream ran out prematurely, likely corrupt archive\0A\00", align 1
@__func__.close_stream_in = private unnamed_addr constant [16 x i8] c"close_stream_in\00", align 1
@.str.39.674 = private unnamed_addr constant [46 x i8] c"Closing stream at %lld, want to seek to %lld\0A\00", align 1
@__func__.read_fdin = private unnamed_addr constant [10 x i8] c"read_fdin\00", align 1
@.str.40.528 = private unnamed_addr constant [80 x i8] c"Reached end of file on STDIN prematurely on read_fdin, asked for %lld got %lld\0A\00", align 1
@.str.41.538 = private unnamed_addr constant [9 x i8] c"./util.h\00", align 1
@__func__.cksem_init.541 = private unnamed_addr constant [11 x i8] c"cksem_init\00", align 1
@.str.42.542 = private unnamed_addr constant [35 x i8] c"Failed to sem_init ret=%d errno=%d\00", align 1
@__func__.cksem_post.539 = private unnamed_addr constant [11 x i8] c"cksem_post\00", align 1
@.str.43.540 = private unnamed_addr constant [39 x i8] c"Failed to sem_post errno=%d cksem=0x%p\00", align 1
@__func__.cksem_wait.546 = private unnamed_addr constant [11 x i8] c"cksem_wait\00", align 1
@.str.44.547 = private unnamed_addr constant [39 x i8] c"Failed to sem_wait errno=%d cksem=0x%p\00", align 1
@__func__.read_buf = private unnamed_addr constant [9 x i8] c"read_buf\00", align 1
@.str.45.578 = private unnamed_addr constant [33 x i8] c"Read of length %lld failed - %s\0A\00", align 1
@.str.46.579 = private unnamed_addr constant [50 x i8] c"Partial read!? asked for %lld bytes but got %lld\0A\00", align 1
@clear_buffer.i = internal global i32 0, align 4
@__func__.clear_buffer = private unnamed_addr constant [13 x i8] c"clear_buffer\00", align 1
@.str.47.582 = private unnamed_addr constant [59 x i8] c"Starting thread %ld to compress %lld bytes from stream %d\0A\00", align 1
@.str.48.583 = private unnamed_addr constant [33 x i8] c"Unable to malloc in clear_buffer\00", align 1
@.str.49.584 = private unnamed_addr constant [44 x i8] c"Unable to create compthread in clear_buffer\00", align 1
@.str.50.585 = private unnamed_addr constant [54 x i8] c"Unable to malloc buffer of size %lld in flush_buffer\0A\00", align 1
@__func__.compthread = private unnamed_addr constant [11 x i8] c"compthread\00", align 1
@.str.51.586 = private unnamed_addr constant [63 x i8] c"Warning, unable to set thread nice value %d...Resetting to %d\0A\00", align 1
@.str.52.587 = private unnamed_addr constant [31 x i8] c"Dunno wtf compression to use!\0A\00", align 1
@.str.53.588 = private unnamed_addr constant [39 x i8] c"Failed to realloc s_buf in compthread\0A\00", align 1
@.str.54.589 = private unnamed_addr constant [34 x i8] c"Failed to compress in compthread\0A\00", align 1
@output_lock = internal global %union.pthread_mutex_t zeroinitializer, align 8
@output_cond = internal global %union.pthread_cond_t zeroinitializer, align 8
@.str.55.590 = private unnamed_addr constant [93 x i8] c"Unable to compress in parallel, waiting for previous thread to complete before trying again\0A\00", align 1
@.str.56.591 = private unnamed_addr constant [46 x i8] c"Writing initial chunk bytes value %d at %lld\0A\00", align 1
@.str.57.592 = private unnamed_addr constant [24 x i8] c"Writing EOF flag as %d\0A\00", align 1
@.str.58.593 = private unnamed_addr constant [32 x i8] c"Writing initial header at %lld\0A\00", align 1
@.str.59.594 = private unnamed_addr constant [49 x i8] c"Failed to write_buf blank salt in compthread %d\0A\00", align 1
@.str.60.595 = private unnamed_addr constant [51 x i8] c"Compthread %ld seeking to %lld to store length %d\0A\00", align 1
@.str.61.596 = private unnamed_addr constant [35 x i8] c"Failed to seekto in compthread %d\0A\00", align 1
@.str.62.597 = private unnamed_addr constant [46 x i8] c"Failed to write_val cur_pos in compthread %d\0A\00", align 1
@.str.63.598 = private unnamed_addr constant [48 x i8] c"Compthread %ld seeking to %lld to write header\0A\00", align 1
@.str.64.599 = private unnamed_addr constant [43 x i8] c"Failed to seekto cur_pos in compthread %d\0A\00", align 1
@.str.65.600 = private unnamed_addr constant [57 x i8] c"Thread %ld writing %lld compressed bytes from stream %d\0A\00", align 1
@.str.66.601 = private unnamed_addr constant [50 x i8] c"Failed to write_buf header salt in compthread %d\0A\00", align 1
@.str.67.602 = private unnamed_addr constant [31 x i8] c"Failed write in compthread %d\0A\00", align 1
@.str.68.603 = private unnamed_addr constant [49 x i8] c"Failed to write_buf block salt in compthread %d\0A\00", align 1
@.str.69.605 = private unnamed_addr constant [37 x i8] c"Compthread %ld writing data at %lld\0A\00", align 1
@.str.70.606 = private unnamed_addr constant [44 x i8] c"Failed to write_buf s_buf in compthread %d\0A\00", align 1
@__func__.lzma_compress_buf = private unnamed_addr constant [18 x i8] c"lzma_compress_buf\00", align 1
@.str.71.630 = private unnamed_addr constant [46 x i8] c"Starting lzma back end compression thread...\0A\00", align 1
@.str.72.631 = private unnamed_addr constant [47 x i8] c"Unable to allocate c_buf in lzma_compress_buf\0A\00", align 1
@.str.73.632 = private unnamed_addr constant [51 x i8] c"LZMA Parameter ERROR: %d. This should not happen.\0A\00", align 1
@.str.74.633 = private unnamed_addr constant [71 x i8] c"Harmless LZMA Output Buffer Overflow error: %d. Incompressible block.\0A\00", align 1
@.str.75.634 = private unnamed_addr constant [54 x i8] c"LZMA Multi Thread ERROR: %d. This should not happen.\0A\00", align 1
@.str.76.635 = private unnamed_addr constant [54 x i8] c"Unidentified LZMA ERROR: %d. This should not happen.\0A\00", align 1
@.str.77.636 = private unnamed_addr constant [85 x i8] c"LZMA Warning: %d. Can't allocate enough RAM for compression window, trying smaller.\0A\00", align 1
@.str.78.637 = private unnamed_addr constant [100 x i8] c"Unable to allocate enough RAM for any sized compression window, falling back to bzip2 compression.\0A\00", align 1
@.str.79.620 = private unnamed_addr constant [22 x i8] c"Incompressible block\0A\00", align 1
@__func__.lz4_compresses = private unnamed_addr constant [15 x i8] c"lz4_compresses\00", align 1
@.str.80.621 = private unnamed_addr constant [44 x i8] c"Unable to allocate c_buf in lz4_compresses\0A\00", align 1
@.str.81.622 = private unnamed_addr constant [45 x i8] c"lz4 testing FAILED for chunk %ld. %d Passes\0A\00", align 1
@.str.82.623 = private unnamed_addr constant [77 x i8] c"lz4 testing OK for chunk %ld. Compressed size = %5.2F%% of chunk, %d Passes\0A\00", align 1
@__func__.lzo_compress_buf = private unnamed_addr constant [17 x i8] c"lzo_compress_buf\00", align 1
@.str.83.628 = private unnamed_addr constant [24 x i8] c"Failed to malloc wkmem\0A\00", align 1
@.str.84.629 = private unnamed_addr constant [45 x i8] c"Unable to allocate c_buf in lzo_compress_buf\00", align 1
@__func__.bzip2_compress_buf = private unnamed_addr constant [19 x i8] c"bzip2_compress_buf\00", align 1
@.str.85.626 = private unnamed_addr constant [48 x i8] c"Unable to allocate c_buf in bzip2_compress_buf\0A\00", align 1
@.str.86.627 = private unnamed_addr constant [21 x i8] c"BZ2 compress failed\0A\00", align 1
@__func__.gzip_compress_buf = private unnamed_addr constant [18 x i8] c"gzip_compress_buf\00", align 1
@.str.87.624 = private unnamed_addr constant [47 x i8] c"Unable to allocate c_buf in gzip_compress_buf\0A\00", align 1
@.str.88.625 = private unnamed_addr constant [18 x i8] c"compress2 failed\0A\00", align 1
@__func__.zpaq_compress_buf = private unnamed_addr constant [18 x i8] c"zpaq_compress_buf\00", align 1
@.str.89.619 = private unnamed_addr constant [47 x i8] c"Unable to allocate c_buf in zpaq_compress_buf\0A\00", align 1
@__func__.cond_wait = private unnamed_addr constant [10 x i8] c"cond_wait\00", align 1
@.str.90.618 = private unnamed_addr constant [29 x i8] c"Failed to pthread_cond_wait\0A\00", align 1
@__func__.get_seek = private unnamed_addr constant [9 x i8] c"get_seek\00", align 1
@__func__.seekto = private unnamed_addr constant [7 x i8] c"seekto\00", align 1
@.str.91.616 = private unnamed_addr constant [53 x i8] c"Trying to seek to %lld outside tmp outbuf in seekto\0A\00", align 1
@__func__.fd_seekto = private unnamed_addr constant [10 x i8] c"fd_seekto\00", align 1
@.str.92.617 = private unnamed_addr constant [34 x i8] c"Failed to seek to %lld in stream\0A\00", align 1
@__func__.write_buf = private unnamed_addr constant [10 x i8] c"write_buf\00", align 1
@.str.93.608 = private unnamed_addr constant [34 x i8] c"Write of length %lld failed - %s\0A\00", align 1
@.str.94.609 = private unnamed_addr constant [51 x i8] c"Partial write!? asked for %lld bytes but got %lld\0A\00", align 1
@__func__.cond_broadcast = private unnamed_addr constant [15 x i8] c"cond_broadcast\00", align 1
@.str.95.607 = private unnamed_addr constant [34 x i8] c"Failed to pthread_cond_broadcast\0A\00", align 1
@__func__.fill_buffer = private unnamed_addr constant [12 x i8] c"fill_buffer\00", align 1
@.str.96.643 = private unnamed_addr constant [55 x i8] c"Trying to start a busy thread, this shouldn't happen!\0A\00", align 1
@.str.97.644 = private unnamed_addr constant [30 x i8] c"Reading ucomp header at %lld\0A\00", align 1
@.str.98.645 = private unnamed_addr constant [60 x i8] c"Fill_buffer stream %d c_len %lld u_len %lld last_head %lld\0A\00", align 1
@.str.99.646 = private unnamed_addr constant [28 x i8] c"Skipping empty match block\0A\00", align 1
@.str.100.647 = private unnamed_addr constant [67 x i8] c"Invalid data compressed len %lld uncompressed %lld last_head %lld\0A\00", align 1
@.str.101.648 = private unnamed_addr constant [83 x i8] c"Warning, attempting to malloc very large buffer for this environment of size %lld\0A\00", align 1
@.str.102.649 = private unnamed_addr constant [53 x i8] c"Unable to malloc buffer of size %lld in fill_buffer\0A\00", align 1
@.str.103.650 = private unnamed_addr constant [61 x i8] c"Starting thread %ld to decompress %lld bytes from stream %d\0A\00", align 1
@.str.104.651 = private unnamed_addr constant [32 x i8] c"Unable to malloc in fill_buffer\00", align 1
@.str.105.652 = private unnamed_addr constant [42 x i8] c"Taking decompressed data from thread %ld\0A\00", align 1
@__func__.ucompthread = private unnamed_addr constant [12 x i8] c"ucompthread\00", align 1
@.str.106.653 = private unnamed_addr constant [38 x i8] c"Dunno wtf decompression type to use!\0A\00", align 1
@.str.107.654 = private unnamed_addr constant [37 x i8] c"Failed to decompress in ucompthread\0A\00", align 1
@.str.108.655 = private unnamed_addr constant [95 x i8] c"Unable to decompress in parallel, waiting for previous thread to complete before trying again\0A\00", align 1
@.str.109.656 = private unnamed_addr constant [51 x i8] c"Thread %ld decompressed %lld bytes from stream %d\0A\00", align 1
@__func__.lzma_decompress_buf = private unnamed_addr constant [20 x i8] c"lzma_decompress_buf\00", align 1
@.str.110.666 = private unnamed_addr constant [49 x i8] c"Failed to allocate %lld bytes for decompression\0A\00", align 1
@.str.111.667 = private unnamed_addr constant [42 x i8] c"Failed to decompress buffer - lzmaerr=%d\0A\00", align 1
@.str.112.668 = private unnamed_addr constant [72 x i8] c"Inconsistent length after decompression. Got %lld bytes, expected %lld\0A\00", align 1
@__func__.lzo_decompress_buf = private unnamed_addr constant [19 x i8] c"lzo_decompress_buf\00", align 1
@.str.113.663 = private unnamed_addr constant [48 x i8] c"Failed to allocate %lu bytes for decompression\0A\00", align 1
@.str.114.664 = private unnamed_addr constant [40 x i8] c"Failed to decompress buffer - lzerr=%d\0A\00", align 1
@.str.115.665 = private unnamed_addr constant [71 x i8] c"Inconsistent length after decompression. Got %lu bytes, expected %lld\0A\00", align 1
@__func__.bzip2_decompress_buf = private unnamed_addr constant [21 x i8] c"bzip2_decompress_buf\00", align 1
@.str.116.660 = private unnamed_addr constant [47 x i8] c"Failed to allocate %d bytes for decompression\0A\00", align 1
@.str.117.661 = private unnamed_addr constant [40 x i8] c"Failed to decompress buffer - bzerr=%d\0A\00", align 1
@.str.118.662 = private unnamed_addr constant [70 x i8] c"Inconsistent length after decompression. Got %d bytes, expected %lld\0A\00", align 1
@__func__.gzip_decompress_buf = private unnamed_addr constant [20 x i8] c"gzip_decompress_buf\00", align 1
@.str.119.657 = private unnamed_addr constant [48 x i8] c"Failed to allocate %ld bytes for decompression\0A\00", align 1
@.str.120.659 = private unnamed_addr constant [40 x i8] c"Failed to decompress buffer - gzerr=%d\0A\00", align 1
@.str.121.658 = private unnamed_addr constant [71 x i8] c"Inconsistent length after decompression. Got %ld bytes, expected %lld\0A\00", align 1
@__func__.zpaq_decompress_buf = private unnamed_addr constant [20 x i8] c"zpaq_decompress_buf\00", align 1
@__func__.rewrite_encrypted = private unnamed_addr constant [18 x i8] c"rewrite_encrypted\00", align 1
@.str.122.610 = private unnamed_addr constant [44 x i8] c"Failed to malloc head in rewrite_encrypted\0A\00", align 1
@.str.123.611 = private unnamed_addr constant [47 x i8] c"Failed to seekto buf ofs in rewrite_encrypted\0A\00", align 1
@.str.124.612 = private unnamed_addr constant [47 x i8] c"Failed to write_buf head in rewrite_encrypted\0A\00", align 1
@.str.125.613 = private unnamed_addr constant [45 x i8] c"Failed to read_buf buf in rewrite_encrypted\0A\00", align 1
@.str.126.614 = private unnamed_addr constant [49 x i8] c"Failed to seek back to ofs in rewrite_encrypted\0A\00", align 1
@.str.127.615 = private unnamed_addr constant [56 x i8] c"Failed to write_buf encrypted buf in rewrite_encrypted\0A\00", align 1
@__func__.read_seekto = private unnamed_addr constant [12 x i8] c"read_seekto\00", align 1
@.str.128.669 = private unnamed_addr constant [57 x i8] c"Trying to seek to %lld outside tmp inbuf in read_seekto\0A\00", align 1
@__func__.add_to_rulist = private unnamed_addr constant [14 x i8] c"add_to_rulist\00", align 1
@.str.129.675 = private unnamed_addr constant [44 x i8] c"Failed to calloc struct node in add_rulist\0A\00", align 1
@stdin = external global ptr, align 8
@.str.684 = private unnamed_addr constant [7 x i8] c"util.c\00", align 1
@__func__.fatal_exit = private unnamed_addr constant [11 x i8] c"fatal_exit\00", align 1
@.str.1.685 = private unnamed_addr constant [25 x i8] c"Deleting broken file %s\0A\00", align 1
@.str.2.687 = private unnamed_addr constant [37 x i8] c"Keeping broken file %s as requested\0A\00", align 1
@.str.3.688 = private unnamed_addr constant [23 x i8] c"Fatal error - exiting\0A\00", align 1
@.str.4.699 = private unnamed_addr constant [13 x i8] c"/dev/urandom\00", align 1
@__func__.get_rand = private unnamed_addr constant [9 x i8] c"get_rand\00", align 1
@.str.5.700 = private unnamed_addr constant [31 x i8] c"Failed to read fd in get_rand\0A\00", align 1
@.str.6.702 = private unnamed_addr constant [32 x i8] c"Failed to close fd in get_rand\0A\00", align 1
@.str.7.705 = private unnamed_addr constant [11 x i8] c"lrzip.conf\00", align 1
@.str.8.706 = private unnamed_addr constant [2 x i8] c"r\00", align 1
@.str.9.707 = private unnamed_addr constant [39 x i8] c"Using configuration file ./lrzip.conf\0A\00", align 1
@.str.10.708 = private unnamed_addr constant [5 x i8] c"HOME\00", align 1
@.str.11.709 = private unnamed_addr constant [21 x i8] c"%s/.lrzip/lrzip.conf\00", align 1
@.str.12.710 = private unnamed_addr constant [29 x i8] c"Using configuration file %s\0A\00", align 1
@.str.13.711 = private unnamed_addr constant [22 x i8] c"/etc/lrzip/lrzip.conf\00", align 1
@.str.14.712 = private unnamed_addr constant [48 x i8] c"Using configuration file /etc/lrzip/lrzip.conf\0A\00", align 1
@.str.15.713 = private unnamed_addr constant [3 x i8] c" =\00", align 1
@.str.16.714 = private unnamed_addr constant [7 x i8] c"window\00", align 1
@.str.17.715 = private unnamed_addr constant [10 x i8] c"unlimited\00", align 1
@.str.18.716 = private unnamed_addr constant [4 x i8] c"yes\00", align 1
@.str.19.717 = private unnamed_addr constant [17 x i8] c"compressionlevel\00", align 1
@__func__.read_config = private unnamed_addr constant [12 x i8] c"read_config\00", align 1
@.str.20.718 = private unnamed_addr constant [56 x i8] c"CONF.FILE error. Compression Level must between 1 and 9\00", align 1
@.str.21.720 = private unnamed_addr constant [18 x i8] c"compressionmethod\00", align 1
@.str.22.721 = private unnamed_addr constant [57 x i8] c"CONF.FILE error. Can only specify one compression method\00", align 1
@.str.23.722 = private unnamed_addr constant [6 x i8] c"bzip2\00", align 1
@.str.24.723 = private unnamed_addr constant [5 x i8] c"gzip\00", align 1
@.str.25.724 = private unnamed_addr constant [4 x i8] c"lzo\00", align 1
@.str.26.725 = private unnamed_addr constant [5 x i8] c"rzip\00", align 1
@.str.27.726 = private unnamed_addr constant [5 x i8] c"zpaq\00", align 1
@.str.28.727 = private unnamed_addr constant [5 x i8] c"lzma\00", align 1
@.str.29.728 = private unnamed_addr constant [58 x i8] c"CONF.FILE error. Invalid compression method %s specified\0A\00", align 1
@.str.30.729 = private unnamed_addr constant [8 x i8] c"lzotest\00", align 1
@.str.31.730 = private unnamed_addr constant [3 x i8] c"no\00", align 1
@.str.32.731 = private unnamed_addr constant [10 x i8] c"hashcheck\00", align 1
@.str.33.732 = private unnamed_addr constant [9 x i8] c"showhash\00", align 1
@.str.34.733 = private unnamed_addr constant [16 x i8] c"outputdirectory\00", align 1
@.str.35.734 = private unnamed_addr constant [34 x i8] c"Fatal Memory Error in read_config\00", align 1
@.str.36.735 = private unnamed_addr constant [2 x i8] c"/\00", align 1
@.str.37.736 = private unnamed_addr constant [10 x i8] c"verbosity\00", align 1
@.str.38.737 = private unnamed_addr constant [44 x i8] c"CONF.FILE error. Verbosity already defined.\00", align 1
@.str.39.738 = private unnamed_addr constant [4 x i8] c"max\00", align 1
@.str.40.739 = private unnamed_addr constant [55 x i8] c"lrzip.conf: Unrecognized verbosity value %s. Ignored.\0A\00", align 1
@.str.41.741 = private unnamed_addr constant [13 x i8] c"showprogress\00", align 1
@.str.42.742 = private unnamed_addr constant [3 x i8] c"NO\00", align 1
@.str.43.743 = private unnamed_addr constant [5 x i8] c"nice\00", align 1
@.str.44.744 = private unnamed_addr constant [49 x i8] c"CONF.FILE error. Nice must be between -20 and 19\00", align 1
@.str.45.745 = private unnamed_addr constant [11 x i8] c"keepbroken\00", align 1
@.str.46.746 = private unnamed_addr constant [12 x i8] c"DELETEFILES\00", align 1
@.str.47.747 = private unnamed_addr constant [4 x i8] c"YES\00", align 1
@.str.48.748 = private unnamed_addr constant [12 x i8] c"REPLACEFILE\00", align 1
@.str.49.749 = private unnamed_addr constant [7 x i8] c"tmpdir\00", align 1
@.str.50.750 = private unnamed_addr constant [8 x i8] c"encrypt\00", align 1
@.str.51.751 = private unnamed_addr constant [64 x i8] c"lrzip.conf: Unrecognized parameter value, %s = %s. Continuing.\0A\00", align 1
@.str.52.752 = private unnamed_addr constant [36 x i8] c"Failed to fclose fp in read_config\0A\00", align 1
@__func__.lrz_crypt = private unnamed_addr constant [10 x i8] c"lrz_crypt\00", align 1
@.str.53.755 = private unnamed_addr constant [25 x i8] c"Encrypting data        \0A\00", align 1
@.str.54.756 = private unnamed_addr constant [39 x i8] c"Failed to aes_setkey_enc in lrz_crypt\0A\00", align 1
@.str.55.757 = private unnamed_addr constant [39 x i8] c"Failed to aes_setkey_dec in lrz_crypt\0A\00", align 1
@.str.56.758 = private unnamed_addr constant [25 x i8] c"Decrypting data        \0A\00", align 1
@__func__.lrz_stretch = private unnamed_addr constant [12 x i8] c"lrz_stretch\00", align 1
@.str.57.761 = private unnamed_addr constant [39 x i8] c"Hashing passphrase %lld (%lld) times \0A\00", align 1
@fillbuf = internal constant <{ i8, [63 x i8] }> <{ i8 -128, [63 x i8] zeroinitializer }>, align 16
@aes_init_done = internal global i32 0, align 4
@RCON = internal global [10 x i64] zeroinitializer, align 16
@FSb = internal global [256 x i8] zeroinitializer, align 16
@RT0 = internal global [256 x i64] zeroinitializer, align 16
@RT1 = internal global [256 x i64] zeroinitializer, align 16
@RT2 = internal global [256 x i64] zeroinitializer, align 16
@RT3 = internal global [256 x i64] zeroinitializer, align 16
@RSb = internal global [256 x i8] zeroinitializer, align 16
@FT0 = internal global [256 x i64] zeroinitializer, align 16
@FT1 = internal global [256 x i64] zeroinitializer, align 16
@FT2 = internal global [256 x i64] zeroinitializer, align 16
@FT3 = internal global [256 x i64] zeroinitializer, align 16
@K = internal constant [80 x i64] [i64 4794697086780616226, i64 8158064640168781261, i64 -5349999486874862801, i64 -1606136188198331460, i64 4131703408338449720, i64 6480981068601479193, i64 -7908458776815382629, i64 -6116909921290321640, i64 -2880145864133508542, i64 1334009975649890238, i64 2608012711638119052, i64 6128411473006802146, i64 8268148722764581231, i64 -9160688886553864527, i64 -7215885187991268811, i64 -4495734319001033068, i64 -1973867731355612462, i64 -1171420211273849373, i64 1135362057144423861, i64 2597628984639134821, i64 3308224258029322869, i64 5365058923640841347, i64 6679025012923562964, i64 8573033837759648693, i64 -7476448914759557205, i64 -6327057829258317296, i64 -5763719355590565569, i64 -4658551843659510044, i64 -4116276920077217854, i64 -3051310485924567259, i64 489312712824947311, i64 1452737877330783856, i64 2861767655752347644, i64 3322285676063803686, i64 5560940570517711597, i64 5996557281743188959, i64 7280758554555802590, i64 8532644243296465576, i64 -9096487096722542874, i64 -7894198246740708037, i64 -6719396339535248540, i64 -6333637450476146687, i64 -4446306890439682159, i64 -4076793802049405392, i64 -3345356375505022440, i64 -2983346525034927856, i64 -860691631967231958, i64 1182934255886127544, i64 1847814050463011016, i64 2177327727835720531, i64 2830643537854262169, i64 3796741975233480872, i64 4115178125766777443, i64 5681478168544905931, i64 6601373596472566643, i64 7507060721942968483, i64 8399075790359081724, i64 8693463985226723168, i64 -8878714635349349518, i64 -8302665154208450068, i64 -8016688836872298968, i64 -6606660893046293015, i64 -4685533653050689259, i64 -4147400797238176981, i64 -3880063495543823972, i64 -3348786107499101689, i64 -1523767162380948706, i64 -757361751448694408, i64 500013540394364858, i64 748580250866718886, i64 1242879168328830382, i64 1977374033974150939, i64 2944078676154940804, i64 3659926193048069267, i64 4368137639120453308, i64 4836135668995329356, i64 5532061633213252278, i64 6448918945643986474, i64 6902733635092675308, i64 7801388544844847127], align 16
@sha4_padding = internal constant <{ i8, [127 x i8] }> <{ i8 -128, [127 x i8] zeroinitializer }>, align 16
@stderr = external global ptr, align 8
@.str.792 = private unnamed_addr constant [17 x i8] c"zpipe error: %s\0A\00", align 1
@.str.1.793 = private unnamed_addr constant [14 x i8] c"allocx failed\00", align 1
@_ZN7libzpaq8compsizeE = constant <{ [10 x i32], [246 x i32] }> <{ [10 x i32] [i32 0, i32 2, i32 3, i32 2, i32 3, i32 4, i32 6, i32 6, i32 3, i32 5], [246 x i32] zeroinitializer }>, align 16
@__const._ZN7libzpaq10StateTable10num_statesEii.bound = private unnamed_addr constant [6 x i32] [i32 20, i32 48, i32 15, i32 8, i32 6, i32 5], align 16
@.str.2.821 = private unnamed_addr constant [23 x i8] c"unexpected end of file\00", align 1
@.str.3.822 = private unnamed_addr constant [23 x i8] c"Invalid component type\00", align 1
@.str.4.823 = private unnamed_addr constant [18 x i8] c"COMP list too big\00", align 1
@.str.5.824 = private unnamed_addr constant [17 x i8] c"missing COMP END\00", align 1
@.str.6.825 = private unnamed_addr constant [18 x i8] c"missing HCOMP END\00", align 1
@.str.7.843 = private unnamed_addr constant [22 x i8] c"ZPAQL execution error\00", align 1
@.str.8.802 = private unnamed_addr constant [22 x i8] c"max size for CM is 32\00", align 1
@.str.9.803 = private unnamed_addr constant [23 x i8] c"max size for ICM is 26\00", align 1
@.str.10.804 = private unnamed_addr constant [28 x i8] c"max size for MATCH is 32 32\00", align 1
@.str.11.805 = private unnamed_addr constant [11 x i8] c"AVG j >= i\00", align 1
@.str.12.806 = private unnamed_addr constant [11 x i8] c"AVG k >= i\00", align 1
@.str.13.807 = private unnamed_addr constant [24 x i8] c"max size for MIX2 is 32\00", align 1
@.str.14.808 = private unnamed_addr constant [12 x i8] c"MIX2 k >= i\00", align 1
@.str.15.809 = private unnamed_addr constant [12 x i8] c"MIX2 j >= i\00", align 1
@.str.16.810 = private unnamed_addr constant [23 x i8] c"max size for MIX is 32\00", align 1
@.str.17.811 = private unnamed_addr constant [11 x i8] c"MIX j >= i\00", align 1
@.str.18.812 = private unnamed_addr constant [20 x i8] c"MIX m not in 1..i-j\00", align 1
@.str.19.813 = private unnamed_addr constant [24 x i8] c"max size for ISSE is 32\00", align 1
@.str.20.814 = private unnamed_addr constant [12 x i8] c"ISSE j >= i\00", align 1
@.str.21.815 = private unnamed_addr constant [23 x i8] c"max size for SSE is 32\00", align 1
@.str.22.816 = private unnamed_addr constant [11 x i8] c"SSE j >= i\00", align 1
@.str.23.817 = private unnamed_addr constant [20 x i8] c"SSE start > limit*4\00", align 1
@.str.24.818 = private unnamed_addr constant [23 x i8] c"unknown component type\00", align 1
@.str.25.844 = private unnamed_addr constant [34 x i8] c"component predict not implemented\00", align 1
@.str.26.835 = private unnamed_addr constant [24 x i8] c"unexpected end of input\00", align 1
@.str.27.836 = private unnamed_addr constant [18 x i8] c"archive corrupted\00", align 1
@.str.28.834 = private unnamed_addr constant [23 x i8] c"decoding end of stream\00", align 1
@.str.29.832 = private unnamed_addr constant [15 x i8] c"Unexpected EOS\00", align 1
@.str.30.833 = private unnamed_addr constant [29 x i8] c"unknown post processing type\00", align 1
@.str.31.840 = private unnamed_addr constant [23 x i8] c"unsupported ZPAQ level\00", align 1
@.str.32.841 = private unnamed_addr constant [23 x i8] c"unsupported ZPAQL type\00", align 1
@.str.33.842 = private unnamed_addr constant [43 x i8] c"ZPAQ level 1 requires at least 1 component\00", align 1
@.str.34.837 = private unnamed_addr constant [15 x i8] c"unexpected EOF\00", align 1
@.str.35.839 = private unnamed_addr constant [32 x i8] c"missing segment or end of block\00", align 1
@.str.36.838 = private unnamed_addr constant [22 x i8] c"missing reserved byte\00", align 1
@.str.37.831 = private unnamed_addr constant [30 x i8] c"missing end of segment marker\00", align 1
@_ZZN7libzpaq10Compressor10startBlockEiE6models = internal constant [299 x i8] c"\1A\00\01\02\00\00\02\03\10\08\13\00\00`\04\1C;\0A;p\19\0A;\0A;p8\00E\00\03\03\00\00\08\03\05\08\0D\00\08\11\01\08\12\02\08\12\03\08\13\04\04\16\18\07\10\00\07\18\FF\00\11hJ\04_\01;p\0A\19;p\0A\19;p\0A\19;p\0A\19;p\0A\19;\0A;p\19E\CF\08p8\00\C4\00\05\09\00\00\16\01\A0\03\05\08\0D\01\08\10\02\08\12\03\08\13\04\08\13\05\08\14\06\04\16\18\03\11\08\13\09\03\0D\03\0D\03\0D\03\0E\07\10\00\0F\18\FF\07\08\00\10\0A\FF\06\00\0F\10\18\00\09\08\11 \FF\06\08\11\12\10\FF\09\10\13 \FF\06\00\13\14\10\00\00\11hJ\04_\02;p\0A\19;p\0A\19;p\0A\19;p\0A\19;p\0A\19;\0A;p\0A\19;p\0A\19E\B7 \EF@/\0E\E7[/\0A\19<\1A0\86\97\14p?\09F\DF\00'\03\19p\1A4\19\19J\0A\04;p\19\0A\04;p\19\0A\04;p\19A\8F\D4H\04;p\08\8F\D8\08D\AF<<\19E\CF\09p\19\19\19\19\19p8\00\00\00", align 16
@.str.38.819 = private unnamed_addr constant [37 x i8] c"compression level must be at least 1\00", align 1
@.str.39.820 = private unnamed_addr constant [27 x i8] c"compression level too high\00", align 1
@.str.40.796 = private unnamed_addr constant [41 x i8] c"JIT supported only for x86-32 and x86-64\00", align 1
@__const._ZN7libzpaq5ZPAQL8assembleEv.regcode = private unnamed_addr constant [8 x i32] [i32 2, i32 6, i32 7, i32 5, i32 0, i32 0, i32 0, i32 0], align 16
@__const._ZN7libzpaq5ZPAQL8assembleEv.jtab = private unnamed_addr constant [2 x [4 x i32]] [[4 x i32] [i32 5, i32 4, i32 2, i32 7], [4 x i32] [i32 4, i32 5, i32 3, i32 6]], align 16
@.str.41.797 = private unnamed_addr constant [27 x i8] c"Cannot code x86 short jump\00", align 1
@.str.42.799 = private unnamed_addr constant [13 x i8] c"comp too big\00", align 1
@.str.43.800 = private unnamed_addr constant [18 x i8] c"invalid component\00", align 1
@.str.44.801 = private unnamed_addr constant [23 x i8] c"invalid ZPAQ component\00", align 1
@.str.45.798 = private unnamed_addr constant [21 x i8] c"predictor JIT failed\00", align 1
@.str.46.794 = private unnamed_addr constant [15 x i8] c"run JIT failed\00", align 1
@.str.47.795 = private unnamed_addr constant [17 x i8] c"Bad ZPAQL opcode\00", align 1
@_ZTVN7libzpaq6ReaderE = unnamed_addr constant { [6 x ptr] } { [6 x ptr] [ptr null, ptr @_ZTIN7libzpaq6ReaderE, ptr null, ptr null, ptr null, ptr null] }, align 8
@_ZTVN10__cxxabiv117__class_type_infoE = external global ptr
@_ZTSN7libzpaq6ReaderE = constant [18 x i8] c"N7libzpaq6ReaderE\00", align 1
@_ZTIN7libzpaq6ReaderE = constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @_ZTSN7libzpaq6ReaderE }, align 8
@_ZTVN7libzpaq6WriterE = unnamed_addr constant { [6 x ptr] } { [6 x ptr] [ptr null, ptr @_ZTIN7libzpaq6WriterE, ptr null, ptr null, ptr null, ptr null] }, align 8
@_ZTSN7libzpaq6WriterE = constant [18 x i8] c"N7libzpaq6WriterE\00", align 1
@_ZTIN7libzpaq6WriterE = constant { ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv117__class_type_infoE, i64 2), ptr @_ZTSN7libzpaq6WriterE }, align 8
@_ZTV7bufRead = linkonce_odr unnamed_addr constant { [6 x ptr] } { [6 x ptr] [ptr null, ptr @_ZTI7bufRead, ptr null, ptr null, ptr null, ptr null] }, comdat, align 8
@_ZTVN10__cxxabiv120__si_class_type_infoE = external global ptr
@_ZTS7bufRead = linkonce_odr constant [9 x i8] c"7bufRead\00", comdat, align 1
@_ZTI7bufRead = linkonce_odr constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTS7bufRead, ptr @_ZTIN7libzpaq6ReaderE }, comdat, align 8
@.str.48.826 = private unnamed_addr constant [10 x i8] c"\0D\09\09\09ZPAQ\09\00", align 1
@.str.49.827 = private unnamed_addr constant [2 x i8] c"\09\00", align 1
@.str.50.828 = private unnamed_addr constant [12 x i8] c"%ld:%i%%  \0D\00", align 1
@_ZTV8bufWrite = linkonce_odr unnamed_addr constant { [6 x ptr] } { [6 x ptr] [ptr null, ptr @_ZTI8bufWrite, ptr null, ptr null, ptr null, ptr null] }, comdat, align 8
@_ZTS8bufWrite = linkonce_odr constant [10 x i8] c"8bufWrite\00", comdat, align 1
@_ZTI8bufWrite = linkonce_odr constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTS8bufWrite, ptr @_ZTIN7libzpaq6WriterE }, comdat, align 8
@_ZTVN7libzpaq12MemoryReaderE = linkonce_odr unnamed_addr constant { [6 x ptr] } { [6 x ptr] [ptr null, ptr @_ZTIN7libzpaq12MemoryReaderE, ptr null, ptr null, ptr null, ptr null] }, comdat, align 8
@_ZTSN7libzpaq12MemoryReaderE = linkonce_odr constant [25 x i8] c"N7libzpaq12MemoryReaderE\00", comdat, align 1
@_ZTIN7libzpaq12MemoryReaderE = linkonce_odr constant { ptr, ptr, ptr } { ptr getelementptr inbounds (ptr, ptr @_ZTVN10__cxxabiv120__si_class_type_infoE, i64 2), ptr @_ZTSN7libzpaq12MemoryReaderE, ptr @_ZTIN7libzpaq6ReaderE }, comdat, align 8
@.str.51.790 = private unnamed_addr constant [14 x i8] c"Array too big\00", align 1
@.str.52.791 = private unnamed_addr constant [14 x i8] c"Out of memory\00", align 1
@g_CrcTable = global [256 x i32] zeroinitializer, align 16
@g_Alloc = internal global %struct.__pthread_internal_list zeroinitializer, align 8
@kLiteralNextStates = internal constant [12 x i32] [i32 0, i32 0, i32 0, i32 0, i32 1, i32 2, i32 3, i32 4, i32 5, i32 6, i32 4, i32 5], align 16
@kShortRepNextStates = internal constant [12 x i32] [i32 9, i32 9, i32 9, i32 9, i32 9, i32 9, i32 9, i32 11, i32 11, i32 11, i32 11, i32 11], align 16
@kRepNextStates = internal constant [12 x i32] [i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 8, i32 11, i32 11, i32 11, i32 11, i32 11], align 16
@kMatchNextStates = internal constant [12 x i32] [i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 7, i32 10, i32 10, i32 10, i32 10, i32 10], align 16

; Function Attrs: noreturn nounwind
declare void @exit(i32 noundef) #0

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memcpy.p0.p0.i64(ptr noalias nocapture writeonly, ptr noalias nocapture readonly, i64, i1 immarg) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_start(ptr) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn
declare void @llvm.va_end(ptr) #2

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0.i64(ptr nocapture writeonly, i8, i64, i1 immarg) #3

; Function Attrs: nounwind
declare void @free(ptr noundef) #4

declare i32 @fprintf(ptr noundef, ptr noundef, ...) #5

; Function Attrs: nounwind allocsize(0,1)
declare noalias ptr @calloc(i64 noundef, i64 noundef) #6

; Function Attrs: noinline nounwind uwtable
define void @sha4_update(ptr noundef %ctx, ptr noundef %input, i32 noundef %ilen) #7 {
entry:
  %ctx.addr = alloca ptr, align 8
  %input.addr = alloca ptr, align 8
  %ilen.addr = alloca i32, align 4
  %fill = alloca i32, align 4
  %left = alloca i64, align 8
  store ptr %ctx, ptr %ctx.addr, align 8
  store ptr %input, ptr %input.addr, align 8
  store i32 %ilen, ptr %ilen.addr, align 4
  %0 = load i32, ptr %ilen.addr, align 4
  %cmp = icmp sle i32 %0, 0
  br label %if.then

if.then:                                          ; preds = %entry
  br label %if.end33

if.then9:                                         ; No predecessors!
  %1 = load ptr, ptr %ctx.addr, align 8
  %total10 = getelementptr inbounds %struct.sha4_context, ptr %1, i32 0, i32 0
  %arrayidx11 = getelementptr inbounds [2 x i64], ptr %total10, i64 0, i64 1
  %2 = load i64, ptr %arrayidx11, align 8
  %inc = add i64 %2, 1
  store i64 %inc, ptr %arrayidx11, align 8
  %3 = load i64, ptr %left, align 8
  %tobool = icmp ne i64 %3, 0
  %4 = load i32, ptr %ilen.addr, align 4
  %5 = load i32, ptr %fill, align 4
  %cmp13 = icmp sge i32 %4, %5
  br label %if.then15

if.then15:                                        ; preds = %if.then9
  %6 = load ptr, ptr %ctx.addr, align 8
  %buffer = getelementptr inbounds %struct.sha4_context, ptr %6, i32 0, i32 2
  %arraydecay = getelementptr inbounds [128 x i8], ptr %buffer, i64 0, i64 0
  %7 = load i64, ptr %left, align 8
  %add.ptr = getelementptr inbounds i8, ptr %arraydecay, i64 %7
  %8 = load ptr, ptr %input.addr, align 8
  %9 = load i32, ptr %fill, align 4
  %conv16 = sext i32 %9 to i64
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %add.ptr, ptr align 1 %8, i64 %conv16, i1 false)
  %10 = load ptr, ptr %ctx.addr, align 8
  %11 = load ptr, ptr %ctx.addr, align 8
  %buffer17 = getelementptr inbounds %struct.sha4_context, ptr %11, i32 0, i32 2
  %arraydecay18 = getelementptr inbounds [128 x i8], ptr %buffer17, i64 0, i64 0
  call void @sha4_process(ptr noundef %10, ptr noundef %arraydecay18)
  %12 = load i32, ptr %fill, align 4
  %13 = load ptr, ptr %input.addr, align 8
  %idx.ext = sext i32 %12 to i64
  %add.ptr19 = getelementptr inbounds i8, ptr %13, i64 %idx.ext
  store ptr %add.ptr19, ptr %input.addr, align 8
  %14 = load i32, ptr %fill, align 4
  %15 = load i32, ptr %ilen.addr, align 4
  %sub20 = sub nsw i32 %15, %14
  store i32 %sub20, ptr %ilen.addr, align 4
  store i64 0, ptr %left, align 8
  br label %if.end21

if.end21:                                         ; preds = %if.then15
  br label %while.cond

while.cond:                                       ; preds = %while.body, %if.end21
  %16 = load i32, ptr %ilen.addr, align 4
  %cmp22 = icmp sge i32 %16, 128
  br label %while.body

while.body:                                       ; preds = %while.cond
  %17 = load ptr, ptr %ctx.addr, align 8
  %18 = load ptr, ptr %input.addr, align 8
  call void @sha4_process(ptr noundef %17, ptr noundef %18)
  %19 = load ptr, ptr %input.addr, align 8
  %add.ptr24 = getelementptr inbounds i8, ptr %19, i64 128
  store ptr %add.ptr24, ptr %input.addr, align 8
  %20 = load i32, ptr %ilen.addr, align 4
  %sub25 = sub nsw i32 %20, 128
  store i32 %sub25, ptr %ilen.addr, align 4
  br label %while.cond, !llvm.loop !6

if.then28:                                        ; No predecessors!
  %21 = load ptr, ptr %ctx.addr, align 8
  %buffer29 = getelementptr inbounds %struct.sha4_context, ptr %21, i32 0, i32 2
  %arraydecay30 = getelementptr inbounds [128 x i8], ptr %buffer29, i64 0, i64 0
  %22 = load i64, ptr %left, align 8
  %add.ptr31 = getelementptr inbounds i8, ptr %arraydecay30, i64 %22
  %23 = load ptr, ptr %input.addr, align 8
  %24 = load i32, ptr %ilen.addr, align 4
  %conv32 = sext i32 %24 to i64
  call void @llvm.memcpy.p0.p0.i64(ptr align 1 %add.ptr31, ptr align 1 %23, i64 %conv32, i1 false)
  br label %if.end33

if.end33:                                         ; preds = %if.then28, %if.then
  ret void
}

; Function Attrs: noinline nounwind uwtable
define internal void @sha4_process(ptr noundef %ctx, ptr noundef %data) #7 {
entry:
  %ctx.addr = alloca ptr, align 8
  %data.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  %temp1 = alloca i64, align 8
  %temp2 = alloca i64, align 8
  %W = alloca [80 x i64], align 16
  %A = alloca i64, align 8
  %B = alloca i64, align 8
  %C = alloca i64, align 8
  %D = alloca i64, align 8
  %E = alloca i64, align 8
  %F = alloca i64, align 8
  %G = alloca i64, align 8
  %H = alloca i64, align 8
  store ptr %ctx, ptr %ctx.addr, align 8
  store ptr %data, ptr %data.addr, align 8
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 16
  br label %for.end

for.body:                                         ; No predecessors!
  %1 = load ptr, ptr %data.addr, align 8
  %2 = load i32, ptr %i, align 4
  %shl = shl i32 %2, 3
  %idxprom = sext i32 %shl to i64
  %arrayidx = getelementptr inbounds i8, ptr %1, i64 %idxprom
  %3 = load i8, ptr %arrayidx, align 1
  %conv = zext i8 %3 to i64
  %shl1 = shl i64 %conv, 56
  %4 = load ptr, ptr %data.addr, align 8
  %5 = load i32, ptr %i, align 4
  %shl2 = shl i32 %5, 3
  %add = add nsw i32 %shl2, 1
  %idxprom3 = sext i32 %add to i64
  %arrayidx4 = getelementptr inbounds i8, ptr %4, i64 %idxprom3
  %6 = load i8, ptr %arrayidx4, align 1
  %conv5 = zext i8 %6 to i64
  %shl6 = shl i64 %conv5, 48
  %or = or i64 %shl1, %shl6
  %7 = load ptr, ptr %data.addr, align 8
  %8 = load i32, ptr %i, align 4
  %shl7 = shl i32 %8, 3
  %add8 = add nsw i32 %shl7, 2
  %idxprom9 = sext i32 %add8 to i64
  %arrayidx10 = getelementptr inbounds i8, ptr %7, i64 %idxprom9
  %9 = load i8, ptr %arrayidx10, align 1
  %conv11 = zext i8 %9 to i64
  %shl12 = shl i64 %conv11, 40
  %or13 = or i64 %or, %shl12
  %10 = load ptr, ptr %data.addr, align 8
  %11 = load i32, ptr %i, align 4
  %shl14 = shl i32 %11, 3
  %add15 = add nsw i32 %shl14, 3
  %idxprom16 = sext i32 %add15 to i64
  %arrayidx17 = getelementptr inbounds i8, ptr %10, i64 %idxprom16
  %12 = load i8, ptr %arrayidx17, align 1
  %conv18 = zext i8 %12 to i64
  %shl19 = shl i64 %conv18, 32
  %or20 = or i64 %or13, %shl19
  %13 = load ptr, ptr %data.addr, align 8
  %14 = load i32, ptr %i, align 4
  %shl21 = shl i32 %14, 3
  %add22 = add nsw i32 %shl21, 4
  %idxprom23 = sext i32 %add22 to i64
  %arrayidx24 = getelementptr inbounds i8, ptr %13, i64 %idxprom23
  %15 = load i8, ptr %arrayidx24, align 1
  %conv25 = zext i8 %15 to i64
  %shl26 = shl i64 %conv25, 24
  %or27 = or i64 %or20, %shl26
  %16 = load ptr, ptr %data.addr, align 8
  %17 = load i32, ptr %i, align 4
  %shl28 = shl i32 %17, 3
  %add29 = add nsw i32 %shl28, 5
  %idxprom30 = sext i32 %add29 to i64
  %arrayidx31 = getelementptr inbounds i8, ptr %16, i64 %idxprom30
  %18 = load i8, ptr %arrayidx31, align 1
  %conv32 = zext i8 %18 to i64
  %shl33 = shl i64 %conv32, 16
  %or34 = or i64 %or27, %shl33
  %19 = load ptr, ptr %data.addr, align 8
  %20 = load i32, ptr %i, align 4
  %shl35 = shl i32 %20, 3
  %add36 = add nsw i32 %shl35, 6
  %idxprom37 = sext i32 %add36 to i64
  %arrayidx38 = getelementptr inbounds i8, ptr %19, i64 %idxprom37
  %21 = load i8, ptr %arrayidx38, align 1
  %conv39 = zext i8 %21 to i64
  %shl40 = shl i64 %conv39, 8
  %or41 = or i64 %or34, %shl40
  %22 = load ptr, ptr %data.addr, align 8
  %23 = load i32, ptr %i, align 4
  %shl42 = shl i32 %23, 3
  %add43 = add nsw i32 %shl42, 7
  %idxprom44 = sext i32 %add43 to i64
  %arrayidx45 = getelementptr inbounds i8, ptr %22, i64 %idxprom44
  %24 = load i8, ptr %arrayidx45, align 1
  %conv46 = zext i8 %24 to i64
  %or47 = or i64 %or41, %conv46
  %25 = load i32, ptr %i, align 4
  %idxprom48 = sext i32 %25 to i64
  %arrayidx49 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom48
  store i64 %or47, ptr %arrayidx49, align 8
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %26 = load i32, ptr %i, align 4
  %inc = add nsw i32 %26, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !8

for.end:                                          ; preds = %for.cond
  br label %for.cond50

for.cond50:                                       ; preds = %for.inc110, %for.end
  %27 = load i32, ptr %i, align 4
  %cmp51 = icmp slt i32 %27, 80
  br label %for.end112

for.body53:                                       ; No predecessors!
  %28 = load i32, ptr %i, align 4
  %sub = sub nsw i32 %28, 2
  %idxprom54 = sext i32 %sub to i64
  %arrayidx55 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom54
  %29 = load i64, ptr %arrayidx55, align 8
  %shr = lshr i64 %29, 19
  %30 = load i32, ptr %i, align 4
  %sub56 = sub nsw i32 %30, 2
  %idxprom57 = sext i32 %sub56 to i64
  %arrayidx58 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom57
  %31 = load i64, ptr %arrayidx58, align 8
  %shl59 = shl i64 %31, 45
  %or60 = or i64 %shr, %shl59
  %32 = load i32, ptr %i, align 4
  %sub61 = sub nsw i32 %32, 2
  %idxprom62 = sext i32 %sub61 to i64
  %arrayidx63 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom62
  %33 = load i64, ptr %arrayidx63, align 8
  %shr64 = lshr i64 %33, 61
  %34 = load i32, ptr %i, align 4
  %sub65 = sub nsw i32 %34, 2
  %idxprom66 = sext i32 %sub65 to i64
  %arrayidx67 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom66
  %35 = load i64, ptr %arrayidx67, align 8
  %shl68 = shl i64 %35, 3
  %or69 = or i64 %shr64, %shl68
  %xor = xor i64 %or60, %or69
  %36 = load i32, ptr %i, align 4
  %sub70 = sub nsw i32 %36, 2
  %idxprom71 = sext i32 %sub70 to i64
  %arrayidx72 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom71
  %37 = load i64, ptr %arrayidx72, align 8
  %shr73 = lshr i64 %37, 6
  %xor74 = xor i64 %xor, %shr73
  %38 = load i32, ptr %i, align 4
  %sub75 = sub nsw i32 %38, 7
  %idxprom76 = sext i32 %sub75 to i64
  %arrayidx77 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom76
  %39 = load i64, ptr %arrayidx77, align 8
  %add78 = add i64 %xor74, %39
  %40 = load i32, ptr %i, align 4
  %sub79 = sub nsw i32 %40, 15
  %idxprom80 = sext i32 %sub79 to i64
  %arrayidx81 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom80
  %41 = load i64, ptr %arrayidx81, align 8
  %shr82 = lshr i64 %41, 1
  %42 = load i32, ptr %i, align 4
  %sub83 = sub nsw i32 %42, 15
  %idxprom84 = sext i32 %sub83 to i64
  %arrayidx85 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom84
  %43 = load i64, ptr %arrayidx85, align 8
  %shl86 = shl i64 %43, 63
  %or87 = or i64 %shr82, %shl86
  %44 = load i32, ptr %i, align 4
  %sub88 = sub nsw i32 %44, 15
  %idxprom89 = sext i32 %sub88 to i64
  %arrayidx90 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom89
  %45 = load i64, ptr %arrayidx90, align 8
  %shr91 = lshr i64 %45, 8
  %46 = load i32, ptr %i, align 4
  %sub92 = sub nsw i32 %46, 15
  %idxprom93 = sext i32 %sub92 to i64
  %arrayidx94 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom93
  %47 = load i64, ptr %arrayidx94, align 8
  %shl95 = shl i64 %47, 56
  %or96 = or i64 %shr91, %shl95
  %xor97 = xor i64 %or87, %or96
  %48 = load i32, ptr %i, align 4
  %sub98 = sub nsw i32 %48, 15
  %idxprom99 = sext i32 %sub98 to i64
  %arrayidx100 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom99
  %49 = load i64, ptr %arrayidx100, align 8
  %shr101 = lshr i64 %49, 7
  %xor102 = xor i64 %xor97, %shr101
  %add103 = add i64 %add78, %xor102
  %50 = load i32, ptr %i, align 4
  %sub104 = sub nsw i32 %50, 16
  %idxprom105 = sext i32 %sub104 to i64
  %arrayidx106 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom105
  %51 = load i64, ptr %arrayidx106, align 8
  %add107 = add i64 %add103, %51
  %52 = load i32, ptr %i, align 4
  %idxprom108 = sext i32 %52 to i64
  %arrayidx109 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom108
  store i64 %add107, ptr %arrayidx109, align 8
  br label %for.inc110

for.inc110:                                       ; preds = %for.body53
  %53 = load i32, ptr %i, align 4
  %inc111 = add nsw i32 %53, 1
  store i32 %inc111, ptr %i, align 4
  br label %for.cond50, !llvm.loop !9

for.end112:                                       ; preds = %for.cond50
  %54 = load ptr, ptr %ctx.addr, align 8
  %state = getelementptr inbounds %struct.sha4_context, ptr %54, i32 0, i32 1
  %arrayidx113 = getelementptr inbounds [8 x i64], ptr %state, i64 0, i64 0
  %55 = load i64, ptr %arrayidx113, align 8
  store i64 %55, ptr %A, align 8
  %56 = load ptr, ptr %ctx.addr, align 8
  %state114 = getelementptr inbounds %struct.sha4_context, ptr %56, i32 0, i32 1
  %arrayidx115 = getelementptr inbounds [8 x i64], ptr %state114, i64 0, i64 1
  %57 = load i64, ptr %arrayidx115, align 8
  store i64 %57, ptr %B, align 8
  %58 = load ptr, ptr %ctx.addr, align 8
  %state116 = getelementptr inbounds %struct.sha4_context, ptr %58, i32 0, i32 1
  %arrayidx117 = getelementptr inbounds [8 x i64], ptr %state116, i64 0, i64 2
  %59 = load i64, ptr %arrayidx117, align 8
  store i64 %59, ptr %C, align 8
  %60 = load ptr, ptr %ctx.addr, align 8
  %state118 = getelementptr inbounds %struct.sha4_context, ptr %60, i32 0, i32 1
  %arrayidx119 = getelementptr inbounds [8 x i64], ptr %state118, i64 0, i64 3
  %61 = load i64, ptr %arrayidx119, align 8
  store i64 %61, ptr %D, align 8
  %62 = load ptr, ptr %ctx.addr, align 8
  %state120 = getelementptr inbounds %struct.sha4_context, ptr %62, i32 0, i32 1
  %arrayidx121 = getelementptr inbounds [8 x i64], ptr %state120, i64 0, i64 4
  %63 = load i64, ptr %arrayidx121, align 8
  store i64 %63, ptr %E, align 8
  %64 = load ptr, ptr %ctx.addr, align 8
  %state122 = getelementptr inbounds %struct.sha4_context, ptr %64, i32 0, i32 1
  %arrayidx123 = getelementptr inbounds [8 x i64], ptr %state122, i64 0, i64 5
  %65 = load i64, ptr %arrayidx123, align 8
  store i64 %65, ptr %F, align 8
  %66 = load ptr, ptr %ctx.addr, align 8
  %state124 = getelementptr inbounds %struct.sha4_context, ptr %66, i32 0, i32 1
  %arrayidx125 = getelementptr inbounds [8 x i64], ptr %state124, i64 0, i64 6
  %67 = load i64, ptr %arrayidx125, align 8
  store i64 %67, ptr %G, align 8
  %68 = load ptr, ptr %ctx.addr, align 8
  %state126 = getelementptr inbounds %struct.sha4_context, ptr %68, i32 0, i32 1
  %arrayidx127 = getelementptr inbounds [8 x i64], ptr %state126, i64 0, i64 7
  %69 = load i64, ptr %arrayidx127, align 8
  store i64 %69, ptr %H, align 8
  store i32 0, ptr %i, align 4
  br label %do.body

do.body:                                          ; preds = %do.body, %for.end112
  %70 = load i64, ptr %H, align 8
  %71 = load i64, ptr %E, align 8
  %shr128 = lshr i64 %71, 14
  %72 = load i64, ptr %E, align 8
  %shl129 = shl i64 %72, 50
  %or130 = or i64 %shr128, %shl129
  %73 = load i64, ptr %E, align 8
  %shr131 = lshr i64 %73, 18
  %74 = load i64, ptr %E, align 8
  %shl132 = shl i64 %74, 46
  %or133 = or i64 %shr131, %shl132
  %xor134 = xor i64 %or130, %or133
  %75 = load i64, ptr %E, align 8
  %shr135 = lshr i64 %75, 41
  %76 = load i64, ptr %E, align 8
  %shl136 = shl i64 %76, 23
  %or137 = or i64 %shr135, %shl136
  %xor138 = xor i64 %xor134, %or137
  %add139 = add i64 %70, %xor138
  %77 = load i64, ptr %G, align 8
  %78 = load i64, ptr %E, align 8
  %79 = load i64, ptr %F, align 8
  %80 = load i64, ptr %G, align 8
  %xor140 = xor i64 %79, %80
  %and = and i64 %78, %xor140
  %xor141 = xor i64 %77, %and
  %add142 = add i64 %add139, %xor141
  %81 = load i32, ptr %i, align 4
  %idxprom143 = sext i32 %81 to i64
  %arrayidx144 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom143
  %82 = load i64, ptr %arrayidx144, align 8
  %add145 = add i64 %add142, %82
  %83 = load i32, ptr %i, align 4
  %idxprom146 = sext i32 %83 to i64
  %arrayidx147 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom146
  %84 = load i64, ptr %arrayidx147, align 8
  %add148 = add i64 %add145, %84
  store i64 %add148, ptr %temp1, align 8
  %85 = load i64, ptr %A, align 8
  %shr149 = lshr i64 %85, 28
  %86 = load i64, ptr %A, align 8
  %shl150 = shl i64 %86, 36
  %or151 = or i64 %shr149, %shl150
  %87 = load i64, ptr %A, align 8
  %shr152 = lshr i64 %87, 34
  %88 = load i64, ptr %A, align 8
  %shl153 = shl i64 %88, 30
  %or154 = or i64 %shr152, %shl153
  %xor155 = xor i64 %or151, %or154
  %89 = load i64, ptr %A, align 8
  %shr156 = lshr i64 %89, 39
  %90 = load i64, ptr %A, align 8
  %shl157 = shl i64 %90, 25
  %or158 = or i64 %shr156, %shl157
  %xor159 = xor i64 %xor155, %or158
  %91 = load i64, ptr %A, align 8
  %92 = load i64, ptr %B, align 8
  %and160 = and i64 %91, %92
  %93 = load i64, ptr %C, align 8
  %94 = load i64, ptr %A, align 8
  %95 = load i64, ptr %B, align 8
  %or161 = or i64 %94, %95
  %and162 = and i64 %93, %or161
  %or163 = or i64 %and160, %and162
  %add164 = add i64 %xor159, %or163
  store i64 %add164, ptr %temp2, align 8
  %96 = load i64, ptr %temp1, align 8
  %97 = load i64, ptr %D, align 8
  %add165 = add i64 %97, %96
  store i64 %add165, ptr %D, align 8
  %98 = load i64, ptr %temp1, align 8
  %99 = load i64, ptr %temp2, align 8
  %add166 = add i64 %98, %99
  store i64 %add166, ptr %H, align 8
  %100 = load i32, ptr %i, align 4
  %inc167 = add nsw i32 %100, 1
  store i32 %inc167, ptr %i, align 4
  %101 = load i64, ptr %G, align 8
  %102 = load i64, ptr %D, align 8
  %shr168 = lshr i64 %102, 14
  %103 = load i64, ptr %D, align 8
  %shl169 = shl i64 %103, 50
  %or170 = or i64 %shr168, %shl169
  %104 = load i64, ptr %D, align 8
  %shr171 = lshr i64 %104, 18
  %105 = load i64, ptr %D, align 8
  %shl172 = shl i64 %105, 46
  %or173 = or i64 %shr171, %shl172
  %xor174 = xor i64 %or170, %or173
  %106 = load i64, ptr %D, align 8
  %shr175 = lshr i64 %106, 41
  %107 = load i64, ptr %D, align 8
  %shl176 = shl i64 %107, 23
  %or177 = or i64 %shr175, %shl176
  %xor178 = xor i64 %xor174, %or177
  %add179 = add i64 %101, %xor178
  %108 = load i64, ptr %F, align 8
  %109 = load i64, ptr %D, align 8
  %110 = load i64, ptr %E, align 8
  %111 = load i64, ptr %F, align 8
  %xor180 = xor i64 %110, %111
  %and181 = and i64 %109, %xor180
  %xor182 = xor i64 %108, %and181
  %add183 = add i64 %add179, %xor182
  %112 = load i32, ptr %i, align 4
  %idxprom184 = sext i32 %112 to i64
  %arrayidx185 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom184
  %113 = load i64, ptr %arrayidx185, align 8
  %add186 = add i64 %add183, %113
  %114 = load i32, ptr %i, align 4
  %idxprom187 = sext i32 %114 to i64
  %arrayidx188 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom187
  %115 = load i64, ptr %arrayidx188, align 8
  %add189 = add i64 %add186, %115
  store i64 %add189, ptr %temp1, align 8
  %116 = load i64, ptr %H, align 8
  %shr190 = lshr i64 %116, 28
  %117 = load i64, ptr %H, align 8
  %shl191 = shl i64 %117, 36
  %or192 = or i64 %shr190, %shl191
  %118 = load i64, ptr %H, align 8
  %shr193 = lshr i64 %118, 34
  %119 = load i64, ptr %H, align 8
  %shl194 = shl i64 %119, 30
  %or195 = or i64 %shr193, %shl194
  %xor196 = xor i64 %or192, %or195
  %120 = load i64, ptr %H, align 8
  %shr197 = lshr i64 %120, 39
  %121 = load i64, ptr %H, align 8
  %shl198 = shl i64 %121, 25
  %or199 = or i64 %shr197, %shl198
  %xor200 = xor i64 %xor196, %or199
  %122 = load i64, ptr %H, align 8
  %123 = load i64, ptr %A, align 8
  %and201 = and i64 %122, %123
  %124 = load i64, ptr %B, align 8
  %125 = load i64, ptr %H, align 8
  %126 = load i64, ptr %A, align 8
  %or202 = or i64 %125, %126
  %and203 = and i64 %124, %or202
  %or204 = or i64 %and201, %and203
  %add205 = add i64 %xor200, %or204
  store i64 %add205, ptr %temp2, align 8
  %127 = load i64, ptr %temp1, align 8
  %128 = load i64, ptr %C, align 8
  %add206 = add i64 %128, %127
  store i64 %add206, ptr %C, align 8
  %129 = load i64, ptr %temp1, align 8
  %130 = load i64, ptr %temp2, align 8
  %add207 = add i64 %129, %130
  store i64 %add207, ptr %G, align 8
  %131 = load i32, ptr %i, align 4
  %inc208 = add nsw i32 %131, 1
  store i32 %inc208, ptr %i, align 4
  %132 = load i64, ptr %F, align 8
  %133 = load i64, ptr %C, align 8
  %shr209 = lshr i64 %133, 14
  %134 = load i64, ptr %C, align 8
  %shl210 = shl i64 %134, 50
  %or211 = or i64 %shr209, %shl210
  %135 = load i64, ptr %C, align 8
  %shr212 = lshr i64 %135, 18
  %136 = load i64, ptr %C, align 8
  %shl213 = shl i64 %136, 46
  %or214 = or i64 %shr212, %shl213
  %xor215 = xor i64 %or211, %or214
  %137 = load i64, ptr %C, align 8
  %shr216 = lshr i64 %137, 41
  %138 = load i64, ptr %C, align 8
  %shl217 = shl i64 %138, 23
  %or218 = or i64 %shr216, %shl217
  %xor219 = xor i64 %xor215, %or218
  %add220 = add i64 %132, %xor219
  %139 = load i64, ptr %E, align 8
  %140 = load i64, ptr %C, align 8
  %141 = load i64, ptr %D, align 8
  %142 = load i64, ptr %E, align 8
  %xor221 = xor i64 %141, %142
  %and222 = and i64 %140, %xor221
  %xor223 = xor i64 %139, %and222
  %add224 = add i64 %add220, %xor223
  %143 = load i32, ptr %i, align 4
  %idxprom225 = sext i32 %143 to i64
  %arrayidx226 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom225
  %144 = load i64, ptr %arrayidx226, align 8
  %add227 = add i64 %add224, %144
  %145 = load i32, ptr %i, align 4
  %idxprom228 = sext i32 %145 to i64
  %arrayidx229 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom228
  %146 = load i64, ptr %arrayidx229, align 8
  %add230 = add i64 %add227, %146
  store i64 %add230, ptr %temp1, align 8
  %147 = load i64, ptr %G, align 8
  %shr231 = lshr i64 %147, 28
  %148 = load i64, ptr %G, align 8
  %shl232 = shl i64 %148, 36
  %or233 = or i64 %shr231, %shl232
  %149 = load i64, ptr %G, align 8
  %shr234 = lshr i64 %149, 34
  %150 = load i64, ptr %G, align 8
  %shl235 = shl i64 %150, 30
  %or236 = or i64 %shr234, %shl235
  %xor237 = xor i64 %or233, %or236
  %151 = load i64, ptr %G, align 8
  %shr238 = lshr i64 %151, 39
  %152 = load i64, ptr %G, align 8
  %shl239 = shl i64 %152, 25
  %or240 = or i64 %shr238, %shl239
  %xor241 = xor i64 %xor237, %or240
  %153 = load i64, ptr %G, align 8
  %154 = load i64, ptr %H, align 8
  %and242 = and i64 %153, %154
  %155 = load i64, ptr %A, align 8
  %156 = load i64, ptr %G, align 8
  %157 = load i64, ptr %H, align 8
  %or243 = or i64 %156, %157
  %and244 = and i64 %155, %or243
  %or245 = or i64 %and242, %and244
  %add246 = add i64 %xor241, %or245
  store i64 %add246, ptr %temp2, align 8
  %158 = load i64, ptr %temp1, align 8
  %159 = load i64, ptr %B, align 8
  %add247 = add i64 %159, %158
  store i64 %add247, ptr %B, align 8
  %160 = load i64, ptr %temp1, align 8
  %161 = load i64, ptr %temp2, align 8
  %add248 = add i64 %160, %161
  store i64 %add248, ptr %F, align 8
  %162 = load i32, ptr %i, align 4
  %inc249 = add nsw i32 %162, 1
  store i32 %inc249, ptr %i, align 4
  %163 = load i64, ptr %E, align 8
  %164 = load i64, ptr %B, align 8
  %shr250 = lshr i64 %164, 14
  %165 = load i64, ptr %B, align 8
  %shl251 = shl i64 %165, 50
  %or252 = or i64 %shr250, %shl251
  %166 = load i64, ptr %B, align 8
  %shr253 = lshr i64 %166, 18
  %167 = load i64, ptr %B, align 8
  %shl254 = shl i64 %167, 46
  %or255 = or i64 %shr253, %shl254
  %xor256 = xor i64 %or252, %or255
  %168 = load i64, ptr %B, align 8
  %shr257 = lshr i64 %168, 41
  %169 = load i64, ptr %B, align 8
  %shl258 = shl i64 %169, 23
  %or259 = or i64 %shr257, %shl258
  %xor260 = xor i64 %xor256, %or259
  %add261 = add i64 %163, %xor260
  %170 = load i64, ptr %D, align 8
  %171 = load i64, ptr %B, align 8
  %172 = load i64, ptr %C, align 8
  %173 = load i64, ptr %D, align 8
  %xor262 = xor i64 %172, %173
  %and263 = and i64 %171, %xor262
  %xor264 = xor i64 %170, %and263
  %add265 = add i64 %add261, %xor264
  %174 = load i32, ptr %i, align 4
  %idxprom266 = sext i32 %174 to i64
  %arrayidx267 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom266
  %175 = load i64, ptr %arrayidx267, align 8
  %add268 = add i64 %add265, %175
  %176 = load i32, ptr %i, align 4
  %idxprom269 = sext i32 %176 to i64
  %arrayidx270 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom269
  %177 = load i64, ptr %arrayidx270, align 8
  %add271 = add i64 %add268, %177
  store i64 %add271, ptr %temp1, align 8
  %178 = load i64, ptr %F, align 8
  %shr272 = lshr i64 %178, 28
  %179 = load i64, ptr %F, align 8
  %shl273 = shl i64 %179, 36
  %or274 = or i64 %shr272, %shl273
  %180 = load i64, ptr %F, align 8
  %shr275 = lshr i64 %180, 34
  %181 = load i64, ptr %F, align 8
  %shl276 = shl i64 %181, 30
  %or277 = or i64 %shr275, %shl276
  %xor278 = xor i64 %or274, %or277
  %182 = load i64, ptr %F, align 8
  %shr279 = lshr i64 %182, 39
  %183 = load i64, ptr %F, align 8
  %shl280 = shl i64 %183, 25
  %or281 = or i64 %shr279, %shl280
  %xor282 = xor i64 %xor278, %or281
  %184 = load i64, ptr %F, align 8
  %185 = load i64, ptr %G, align 8
  %and283 = and i64 %184, %185
  %186 = load i64, ptr %H, align 8
  %187 = load i64, ptr %F, align 8
  %188 = load i64, ptr %G, align 8
  %or284 = or i64 %187, %188
  %and285 = and i64 %186, %or284
  %or286 = or i64 %and283, %and285
  %add287 = add i64 %xor282, %or286
  store i64 %add287, ptr %temp2, align 8
  %189 = load i64, ptr %temp1, align 8
  %190 = load i64, ptr %A, align 8
  %add288 = add i64 %190, %189
  store i64 %add288, ptr %A, align 8
  %191 = load i64, ptr %temp1, align 8
  %192 = load i64, ptr %temp2, align 8
  %add289 = add i64 %191, %192
  store i64 %add289, ptr %E, align 8
  %193 = load i32, ptr %i, align 4
  %inc290 = add nsw i32 %193, 1
  store i32 %inc290, ptr %i, align 4
  %194 = load i64, ptr %D, align 8
  %195 = load i64, ptr %A, align 8
  %shr291 = lshr i64 %195, 14
  %196 = load i64, ptr %A, align 8
  %shl292 = shl i64 %196, 50
  %or293 = or i64 %shr291, %shl292
  %197 = load i64, ptr %A, align 8
  %shr294 = lshr i64 %197, 18
  %198 = load i64, ptr %A, align 8
  %shl295 = shl i64 %198, 46
  %or296 = or i64 %shr294, %shl295
  %xor297 = xor i64 %or293, %or296
  %199 = load i64, ptr %A, align 8
  %shr298 = lshr i64 %199, 41
  %200 = load i64, ptr %A, align 8
  %shl299 = shl i64 %200, 23
  %or300 = or i64 %shr298, %shl299
  %xor301 = xor i64 %xor297, %or300
  %add302 = add i64 %194, %xor301
  %201 = load i64, ptr %C, align 8
  %202 = load i64, ptr %A, align 8
  %203 = load i64, ptr %B, align 8
  %204 = load i64, ptr %C, align 8
  %xor303 = xor i64 %203, %204
  %and304 = and i64 %202, %xor303
  %xor305 = xor i64 %201, %and304
  %add306 = add i64 %add302, %xor305
  %205 = load i32, ptr %i, align 4
  %idxprom307 = sext i32 %205 to i64
  %arrayidx308 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom307
  %206 = load i64, ptr %arrayidx308, align 8
  %add309 = add i64 %add306, %206
  %207 = load i32, ptr %i, align 4
  %idxprom310 = sext i32 %207 to i64
  %arrayidx311 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom310
  %208 = load i64, ptr %arrayidx311, align 8
  %add312 = add i64 %add309, %208
  store i64 %add312, ptr %temp1, align 8
  %209 = load i64, ptr %E, align 8
  %shr313 = lshr i64 %209, 28
  %210 = load i64, ptr %E, align 8
  %shl314 = shl i64 %210, 36
  %or315 = or i64 %shr313, %shl314
  %211 = load i64, ptr %E, align 8
  %shr316 = lshr i64 %211, 34
  %212 = load i64, ptr %E, align 8
  %shl317 = shl i64 %212, 30
  %or318 = or i64 %shr316, %shl317
  %xor319 = xor i64 %or315, %or318
  %213 = load i64, ptr %E, align 8
  %shr320 = lshr i64 %213, 39
  %214 = load i64, ptr %E, align 8
  %shl321 = shl i64 %214, 25
  %or322 = or i64 %shr320, %shl321
  %xor323 = xor i64 %xor319, %or322
  %215 = load i64, ptr %E, align 8
  %216 = load i64, ptr %F, align 8
  %and324 = and i64 %215, %216
  %217 = load i64, ptr %G, align 8
  %218 = load i64, ptr %E, align 8
  %219 = load i64, ptr %F, align 8
  %or325 = or i64 %218, %219
  %and326 = and i64 %217, %or325
  %or327 = or i64 %and324, %and326
  %add328 = add i64 %xor323, %or327
  store i64 %add328, ptr %temp2, align 8
  %220 = load i64, ptr %temp1, align 8
  %221 = load i64, ptr %H, align 8
  %add329 = add i64 %221, %220
  store i64 %add329, ptr %H, align 8
  %222 = load i64, ptr %temp1, align 8
  %223 = load i64, ptr %temp2, align 8
  %add330 = add i64 %222, %223
  store i64 %add330, ptr %D, align 8
  %224 = load i32, ptr %i, align 4
  %inc331 = add nsw i32 %224, 1
  store i32 %inc331, ptr %i, align 4
  %225 = load i64, ptr %C, align 8
  %226 = load i64, ptr %H, align 8
  %shr332 = lshr i64 %226, 14
  %227 = load i64, ptr %H, align 8
  %shl333 = shl i64 %227, 50
  %or334 = or i64 %shr332, %shl333
  %228 = load i64, ptr %H, align 8
  %shr335 = lshr i64 %228, 18
  %229 = load i64, ptr %H, align 8
  %shl336 = shl i64 %229, 46
  %or337 = or i64 %shr335, %shl336
  %xor338 = xor i64 %or334, %or337
  %230 = load i64, ptr %H, align 8
  %shr339 = lshr i64 %230, 41
  %231 = load i64, ptr %H, align 8
  %shl340 = shl i64 %231, 23
  %or341 = or i64 %shr339, %shl340
  %xor342 = xor i64 %xor338, %or341
  %add343 = add i64 %225, %xor342
  %232 = load i64, ptr %B, align 8
  %233 = load i64, ptr %H, align 8
  %234 = load i64, ptr %A, align 8
  %235 = load i64, ptr %B, align 8
  %xor344 = xor i64 %234, %235
  %and345 = and i64 %233, %xor344
  %xor346 = xor i64 %232, %and345
  %add347 = add i64 %add343, %xor346
  %236 = load i32, ptr %i, align 4
  %idxprom348 = sext i32 %236 to i64
  %arrayidx349 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom348
  %237 = load i64, ptr %arrayidx349, align 8
  %add350 = add i64 %add347, %237
  %238 = load i32, ptr %i, align 4
  %idxprom351 = sext i32 %238 to i64
  %arrayidx352 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom351
  %239 = load i64, ptr %arrayidx352, align 8
  %add353 = add i64 %add350, %239
  store i64 %add353, ptr %temp1, align 8
  %240 = load i64, ptr %D, align 8
  %shr354 = lshr i64 %240, 28
  %241 = load i64, ptr %D, align 8
  %shl355 = shl i64 %241, 36
  %or356 = or i64 %shr354, %shl355
  %242 = load i64, ptr %D, align 8
  %shr357 = lshr i64 %242, 34
  %243 = load i64, ptr %D, align 8
  %shl358 = shl i64 %243, 30
  %or359 = or i64 %shr357, %shl358
  %xor360 = xor i64 %or356, %or359
  %244 = load i64, ptr %D, align 8
  %shr361 = lshr i64 %244, 39
  %245 = load i64, ptr %D, align 8
  %shl362 = shl i64 %245, 25
  %or363 = or i64 %shr361, %shl362
  %xor364 = xor i64 %xor360, %or363
  %246 = load i64, ptr %D, align 8
  %247 = load i64, ptr %E, align 8
  %and365 = and i64 %246, %247
  %248 = load i64, ptr %F, align 8
  %249 = load i64, ptr %D, align 8
  %250 = load i64, ptr %E, align 8
  %or366 = or i64 %249, %250
  %and367 = and i64 %248, %or366
  %or368 = or i64 %and365, %and367
  %add369 = add i64 %xor364, %or368
  store i64 %add369, ptr %temp2, align 8
  %251 = load i64, ptr %temp1, align 8
  %252 = load i64, ptr %G, align 8
  %add370 = add i64 %252, %251
  store i64 %add370, ptr %G, align 8
  %253 = load i64, ptr %temp1, align 8
  %254 = load i64, ptr %temp2, align 8
  %add371 = add i64 %253, %254
  store i64 %add371, ptr %C, align 8
  %255 = load i32, ptr %i, align 4
  %inc372 = add nsw i32 %255, 1
  store i32 %inc372, ptr %i, align 4
  %256 = load i64, ptr %B, align 8
  %257 = load i64, ptr %G, align 8
  %shr373 = lshr i64 %257, 14
  %258 = load i64, ptr %G, align 8
  %shl374 = shl i64 %258, 50
  %or375 = or i64 %shr373, %shl374
  %259 = load i64, ptr %G, align 8
  %shr376 = lshr i64 %259, 18
  %260 = load i64, ptr %G, align 8
  %shl377 = shl i64 %260, 46
  %or378 = or i64 %shr376, %shl377
  %xor379 = xor i64 %or375, %or378
  %261 = load i64, ptr %G, align 8
  %shr380 = lshr i64 %261, 41
  %262 = load i64, ptr %G, align 8
  %shl381 = shl i64 %262, 23
  %or382 = or i64 %shr380, %shl381
  %xor383 = xor i64 %xor379, %or382
  %add384 = add i64 %256, %xor383
  %263 = load i64, ptr %A, align 8
  %264 = load i64, ptr %G, align 8
  %265 = load i64, ptr %H, align 8
  %266 = load i64, ptr %A, align 8
  %xor385 = xor i64 %265, %266
  %and386 = and i64 %264, %xor385
  %xor387 = xor i64 %263, %and386
  %add388 = add i64 %add384, %xor387
  %267 = load i32, ptr %i, align 4
  %idxprom389 = sext i32 %267 to i64
  %arrayidx390 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom389
  %268 = load i64, ptr %arrayidx390, align 8
  %add391 = add i64 %add388, %268
  %269 = load i32, ptr %i, align 4
  %idxprom392 = sext i32 %269 to i64
  %arrayidx393 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom392
  %270 = load i64, ptr %arrayidx393, align 8
  %add394 = add i64 %add391, %270
  store i64 %add394, ptr %temp1, align 8
  %271 = load i64, ptr %C, align 8
  %shr395 = lshr i64 %271, 28
  %272 = load i64, ptr %C, align 8
  %shl396 = shl i64 %272, 36
  %or397 = or i64 %shr395, %shl396
  %273 = load i64, ptr %C, align 8
  %shr398 = lshr i64 %273, 34
  %274 = load i64, ptr %C, align 8
  %shl399 = shl i64 %274, 30
  %or400 = or i64 %shr398, %shl399
  %xor401 = xor i64 %or397, %or400
  %275 = load i64, ptr %C, align 8
  %shr402 = lshr i64 %275, 39
  %276 = load i64, ptr %C, align 8
  %shl403 = shl i64 %276, 25
  %or404 = or i64 %shr402, %shl403
  %xor405 = xor i64 %xor401, %or404
  %277 = load i64, ptr %C, align 8
  %278 = load i64, ptr %D, align 8
  %and406 = and i64 %277, %278
  %279 = load i64, ptr %E, align 8
  %280 = load i64, ptr %C, align 8
  %281 = load i64, ptr %D, align 8
  %or407 = or i64 %280, %281
  %and408 = and i64 %279, %or407
  %or409 = or i64 %and406, %and408
  %add410 = add i64 %xor405, %or409
  store i64 %add410, ptr %temp2, align 8
  %282 = load i64, ptr %temp1, align 8
  %283 = load i64, ptr %F, align 8
  %add411 = add i64 %283, %282
  store i64 %add411, ptr %F, align 8
  %284 = load i64, ptr %temp1, align 8
  %285 = load i64, ptr %temp2, align 8
  %add412 = add i64 %284, %285
  store i64 %add412, ptr %B, align 8
  %286 = load i32, ptr %i, align 4
  %inc413 = add nsw i32 %286, 1
  store i32 %inc413, ptr %i, align 4
  %287 = load i64, ptr %A, align 8
  %288 = load i64, ptr %F, align 8
  %shr414 = lshr i64 %288, 14
  %289 = load i64, ptr %F, align 8
  %shl415 = shl i64 %289, 50
  %or416 = or i64 %shr414, %shl415
  %290 = load i64, ptr %F, align 8
  %shr417 = lshr i64 %290, 18
  %291 = load i64, ptr %F, align 8
  %shl418 = shl i64 %291, 46
  %or419 = or i64 %shr417, %shl418
  %xor420 = xor i64 %or416, %or419
  %292 = load i64, ptr %F, align 8
  %shr421 = lshr i64 %292, 41
  %293 = load i64, ptr %F, align 8
  %shl422 = shl i64 %293, 23
  %or423 = or i64 %shr421, %shl422
  %xor424 = xor i64 %xor420, %or423
  %add425 = add i64 %287, %xor424
  %294 = load i64, ptr %H, align 8
  %295 = load i64, ptr %F, align 8
  %296 = load i64, ptr %G, align 8
  %297 = load i64, ptr %H, align 8
  %xor426 = xor i64 %296, %297
  %and427 = and i64 %295, %xor426
  %xor428 = xor i64 %294, %and427
  %add429 = add i64 %add425, %xor428
  %298 = load i32, ptr %i, align 4
  %idxprom430 = sext i32 %298 to i64
  %arrayidx431 = getelementptr inbounds [80 x i64], ptr @K, i64 0, i64 %idxprom430
  %299 = load i64, ptr %arrayidx431, align 8
  %add432 = add i64 %add429, %299
  %300 = load i32, ptr %i, align 4
  %idxprom433 = sext i32 %300 to i64
  %arrayidx434 = getelementptr inbounds [80 x i64], ptr %W, i64 0, i64 %idxprom433
  %301 = load i64, ptr %arrayidx434, align 8
  %add435 = add i64 %add432, %301
  store i64 %add435, ptr %temp1, align 8
  %302 = load i64, ptr %B, align 8
  %shr436 = lshr i64 %302, 28
  %303 = load i64, ptr %B, align 8
  %shl437 = shl i64 %303, 36
  %or438 = or i64 %shr436, %shl437
  %304 = load i64, ptr %B, align 8
  %shr439 = lshr i64 %304, 34
  %305 = load i64, ptr %B, align 8
  %shl440 = shl i64 %305, 30
  %or441 = or i64 %shr439, %shl440
  %xor442 = xor i64 %or438, %or441
  %306 = load i64, ptr %B, align 8
  %shr443 = lshr i64 %306, 39
  %307 = load i64, ptr %B, align 8
  %shl444 = shl i64 %307, 25
  %or445 = or i64 %shr443, %shl444
  %xor446 = xor i64 %xor442, %or445
  %308 = load i64, ptr %B, align 8
  %309 = load i64, ptr %C, align 8
  %and447 = and i64 %308, %309
  %310 = load i64, ptr %D, align 8
  %311 = load i64, ptr %B, align 8
  %312 = load i64, ptr %C, align 8
  %or448 = or i64 %311, %312
  %and449 = and i64 %310, %or448
  %or450 = or i64 %and447, %and449
  %add451 = add i64 %xor446, %or450
  store i64 %add451, ptr %temp2, align 8
  %313 = load i64, ptr %temp1, align 8
  %314 = load i64, ptr %E, align 8
  %add452 = add i64 %314, %313
  store i64 %add452, ptr %E, align 8
  %315 = load i64, ptr %temp1, align 8
  %316 = load i64, ptr %temp2, align 8
  %add453 = add i64 %315, %316
  store i64 %add453, ptr %A, align 8
  %317 = load i32, ptr %i, align 4
  %inc454 = add nsw i32 %317, 1
  store i32 %inc454, ptr %i, align 4
  %318 = load i32, ptr %i, align 4
  %cmp455 = icmp slt i32 %318, 80
  br label %do.body, !llvm.loop !10

do.end:                                           ; No predecessors!
  %319 = load i64, ptr %A, align 8
  %320 = load ptr, ptr %ctx.addr, align 8
  %state457 = getelementptr inbounds %struct.sha4_context, ptr %320, i32 0, i32 1
  %arrayidx458 = getelementptr inbounds [8 x i64], ptr %state457, i64 0, i64 0
  %321 = load i64, ptr %arrayidx458, align 8
  %add459 = add i64 %321, %319
  store i64 %add459, ptr %arrayidx458, align 8
  %322 = load i64, ptr %B, align 8
  %323 = load ptr, ptr %ctx.addr, align 8
  %state460 = getelementptr inbounds %struct.sha4_context, ptr %323, i32 0, i32 1
  %arrayidx461 = getelementptr inbounds [8 x i64], ptr %state460, i64 0, i64 1
  %324 = load i64, ptr %arrayidx461, align 8
  %add462 = add i64 %324, %322
  store i64 %add462, ptr %arrayidx461, align 8
  %325 = load i64, ptr %C, align 8
  %326 = load ptr, ptr %ctx.addr, align 8
  %state463 = getelementptr inbounds %struct.sha4_context, ptr %326, i32 0, i32 1
  %arrayidx464 = getelementptr inbounds [8 x i64], ptr %state463, i64 0, i64 2
  %327 = load i64, ptr %arrayidx464, align 8
  %add465 = add i64 %327, %325
  store i64 %add465, ptr %arrayidx464, align 8
  %328 = load i64, ptr %D, align 8
  %329 = load ptr, ptr %ctx.addr, align 8
  %state466 = getelementptr inbounds %struct.sha4_context, ptr %329, i32 0, i32 1
  %arrayidx467 = getelementptr inbounds [8 x i64], ptr %state466, i64 0, i64 3
  %330 = load i64, ptr %arrayidx467, align 8
  %add468 = add i64 %330, %328
  store i64 %add468, ptr %arrayidx467, align 8
  %331 = load i64, ptr %E, align 8
  %332 = load ptr, ptr %ctx.addr, align 8
  %state469 = getelementptr inbounds %struct.sha4_context, ptr %332, i32 0, i32 1
  %arrayidx470 = getelementptr inbounds [8 x i64], ptr %state469, i64 0, i64 4
  %333 = load i64, ptr %arrayidx470, align 8
  %add471 = add i64 %333, %331
  store i64 %add471, ptr %arrayidx470, align 8
  %334 = load i64, ptr %F, align 8
  %335 = load ptr, ptr %ctx.addr, align 8
  %state472 = getelementptr inbounds %struct.sha4_context, ptr %335, i32 0, i32 1
  %arrayidx473 = getelementptr inbounds [8 x i64], ptr %state472, i64 0, i64 5
  %336 = load i64, ptr %arrayidx473, align 8
  %add474 = add i64 %336, %334
  store i64 %add474, ptr %arrayidx473, align 8
  %337 = load i64, ptr %G, align 8
  %338 = load ptr, ptr %ctx.addr, align 8
  %state475 = getelementptr inbounds %struct.sha4_context, ptr %338, i32 0, i32 1
  %arrayidx476 = getelementptr inbounds [8 x i64], ptr %state475, i64 0, i64 6
  %339 = load i64, ptr %arrayidx476, align 8
  %add477 = add i64 %339, %337
  store i64 %add477, ptr %arrayidx476, align 8
  %340 = load i64, ptr %H, align 8
  %341 = load ptr, ptr %ctx.addr, align 8
  %state478 = getelementptr inbounds %struct.sha4_context, ptr %341, i32 0, i32 1
  %arrayidx479 = getelementptr inbounds [8 x i64], ptr %state478, i64 0, i64 7
  %342 = load i64, ptr %arrayidx479, align 8
  %add480 = add i64 %342, %340
  store i64 %add480, ptr %arrayidx479, align 8
  ret void
}

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #8

; Function Attrs: noinline nounwind uwtable
define void @_ZN7libzpaq5ZPAQLD2Ev(ptr noundef nonnull align 8 dereferenceable(192) %this) unnamed_addr #7 align 2 personality ptr null {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %rcode = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 19
  %rcode_size = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 18
  invoke void null(ptr noundef nonnull align 8 dereferenceable(8) %rcode, ptr noundef nonnull align 4 dereferenceable(4) %rcode_size, i32 noundef 0)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %outbuf = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 10
  call void @_ZN7libzpaq5ArrayIcED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %outbuf) #14
  %r = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 9
  call void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %r) #14
  %h = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 8
  call void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %h) #14
  %m = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 7
  call void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %m) #14
  %header = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 2
  call void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %header) #14
  ret void

terminate.lpad:                                   ; preds = %entry
  %0 = landingpad { ptr, i32 }
          catch ptr null
  %1 = extractvalue { ptr, i32 } %0, 0
  call void @__clang_call_terminate(ptr %1) #15
  unreachable
}

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayIcED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #7 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #7 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #7 align 2

; Function Attrs: noinline noreturn nounwind uwtable
declare hidden void @__clang_call_terminate(ptr noundef) #9

declare ptr @__cxa_begin_catch(ptr)

declare void @_ZSt9terminatev()

; Function Attrs: mustprogress noinline uwtable
declare void @_ZN7libzpaq5ArrayIhE6resizeEmi(ptr noundef nonnull align 8 dereferenceable(20), i64 noundef, i32 noundef) #10 align 2

; Function Attrs: mustprogress noinline uwtable
declare void @_ZN7libzpaq5errorEPKc(ptr noundef) #10

; Function Attrs: mustprogress noinline nounwind uwtable
declare void @_ZN7libzpaq4freeEPv(ptr noundef) #11

; Function Attrs: mustprogress noinline nounwind uwtable
declare noundef ptr @_ZN7libzpaq6callocEmm(i64 noundef, i64 noundef) #11

; Function Attrs: noinline nounwind uwtable
define void @_ZN7libzpaq9PredictorD2Ev(ptr noundef nonnull align 8 dereferenceable(110620) %this) unnamed_addr #7 align 2 personality ptr null {
entry:
  %this.addr = alloca ptr, align 8
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %pcode = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 11
  %pcode_size = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 12
  invoke void null(ptr noundef nonnull align 8 dereferenceable(8) %pcode, ptr noundef nonnull align 4 dereferenceable(4) %pcode_size, i32 noundef 0)
          to label %invoke.cont unwind label %terminate.lpad

invoke.cont:                                      ; preds = %entry
  %comp = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 5
  %array.begin = getelementptr inbounds [256 x %"struct.libzpaq::Component"], ptr %comp, i32 0, i32 0
  %0 = getelementptr inbounds %"struct.libzpaq::Component", ptr %array.begin, i64 256
  %arraydestroy.element = getelementptr inbounds %"struct.libzpaq::Component", ptr %0, i64 -1
  call void @_ZN7libzpaq9ComponentD2Ev(ptr noundef nonnull align 8 dereferenceable(112) %arraydestroy.element) #14
  %arraydestroy.done = icmp eq ptr %arraydestroy.element, %array.begin
  br label %arraydestroy.done2

arraydestroy.done2:                               ; preds = %invoke.cont
  ret void

terminate.lpad:                                   ; preds = %entry
  %1 = landingpad { ptr, i32 }
          catch ptr null
  %2 = extractvalue { ptr, i32 } %1, 0
  call void @__clang_call_terminate(ptr %2) #15
  unreachable
}

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq9ComponentD2Ev(ptr noundef nonnull align 8 dereferenceable(112)) unnamed_addr #7 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayItED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #7 align 2

; Function Attrs: noinline uwtable
define void @_ZN7libzpaq9PredictorC2ERNS_5ZPAQLE(ptr noundef nonnull align 8 dereferenceable(110620) %this, ptr noundef nonnull align 8 dereferenceable(192) %zr) unnamed_addr #12 align 2 personality ptr null {
entry:
  %this.addr = alloca ptr, align 8
  %zr.addr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  %i = alloca i32, align 4
  %i7 = alloca i32, align 4
  %i18 = alloca i32, align 4
  %i35 = alloca i32, align 4
  %sqsum = alloca i32, align 4
  %stsum = alloca i32, align 4
  %i52 = alloca i32, align 4
  %i62 = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store ptr %zr, ptr %zr.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %c8 = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 0
  store i32 1, ptr %c8, align 8
  %hmap4 = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 1
  store i32 1, ptr %hmap4, align 4
  %z = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 4
  %0 = load ptr, ptr %zr.addr, align 8
  store ptr %0, ptr %z, align 8
  %comp = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 5
  %array.begin = getelementptr inbounds [256 x %"struct.libzpaq::Component"], ptr %comp, i32 0, i32 0
  %arrayctor.end = getelementptr inbounds %"struct.libzpaq::Component", ptr %array.begin, i64 256
  br label %arrayctor.loop

arrayctor.loop:                                   ; preds = %entry
  invoke void null(ptr noundef nonnull align 8 dereferenceable(112) %array.begin)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %arrayctor.loop
  %arrayctor.next = getelementptr inbounds %"struct.libzpaq::Component", ptr %array.begin, i64 1
  %arrayctor.done = icmp eq ptr %arrayctor.next, %arrayctor.end
  br label %arrayctor.cont

arrayctor.cont:                                   ; preds = %invoke.cont
  %st = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 10
  invoke void @_ZN7libzpaq10StateTableC2Ev(ptr noundef nonnull align 1 dereferenceable(1024) %st)
          to label %invoke.cont4 unwind label %lpad3

invoke.cont4:                                     ; preds = %arrayctor.cont
  %dt2k = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 6
  %arrayidx = getelementptr inbounds [256 x i32], ptr %dt2k, i64 0, i64 0
  store i32 0, ptr %arrayidx, align 8
  store i32 1, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %invoke.cont4
  %1 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %1, 256
  br label %for.body

for.body:                                         ; preds = %for.cond
  %2 = load i32, ptr %i, align 4
  %div = sdiv i32 2048, %2
  %dt2k5 = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 6
  %3 = load i32, ptr %i, align 4
  %idxprom = sext i32 %3 to i64
  %arrayidx6 = getelementptr inbounds [256 x i32], ptr %dt2k5, i64 0, i64 %idxprom
  store i32 %div, ptr %arrayidx6, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %4 = load i32, ptr %i, align 4
  %inc = add nsw i32 %4, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !11

lpad:                                             ; preds = %arrayctor.loop
  %5 = landingpad { ptr, i32 }
          cleanup
  %6 = extractvalue { ptr, i32 } %5, 0
  store ptr %6, ptr %exn.slot, align 8
  %7 = extractvalue { ptr, i32 } %5, 1
  store i32 %7, ptr %ehselector.slot, align 4
  %arraydestroy.isempty = icmp eq ptr %array.begin, %array.begin
  br label %arraydestroy.done2

arraydestroy.done2:                               ; preds = %lpad
  br label %eh.resume

lpad3:                                            ; preds = %for.body65, %for.body55, %arrayctor.cont
  %8 = landingpad { ptr, i32 }
          cleanup
  %9 = extractvalue { ptr, i32 } %8, 0
  store ptr %9, ptr %exn.slot, align 8
  %10 = extractvalue { ptr, i32 } %8, 1
  store i32 %10, ptr %ehselector.slot, align 4
  %array.begin74 = getelementptr inbounds [256 x %"struct.libzpaq::Component"], ptr %comp, i32 0, i32 0
  %11 = getelementptr inbounds %"struct.libzpaq::Component", ptr %array.begin74, i64 256
  %arraydestroy.element77 = getelementptr inbounds %"struct.libzpaq::Component", ptr %11, i64 -1
  call void @_ZN7libzpaq9ComponentD2Ev(ptr noundef nonnull align 8 dereferenceable(112) %arraydestroy.element77) #14
  %arraydestroy.done78 = icmp eq ptr %arraydestroy.element77, %array.begin74
  br label %arraydestroy.done79

for.end:                                          ; No predecessors!
  store i32 0, ptr %i7, align 4
  br label %for.cond8

for.cond8:                                        ; preds = %for.inc15, %for.end
  %12 = load i32, ptr %i7, align 4
  %cmp9 = icmp slt i32 %12, 1024
  br label %for.body10

for.body10:                                       ; preds = %for.cond8
  %13 = load i32, ptr %i7, align 4
  %mul = mul nsw i32 %13, 2
  %add = add nsw i32 %mul, 3
  %div11 = sdiv i32 131072, %add
  %mul12 = mul nsw i32 %div11, 2
  %dt = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 7
  %14 = load i32, ptr %i7, align 4
  %idxprom13 = sext i32 %14 to i64
  %arrayidx14 = getelementptr inbounds [1024 x i32], ptr %dt, i64 0, i64 %idxprom13
  store i32 %mul12, ptr %arrayidx14, align 4
  br label %for.inc15

for.inc15:                                        ; preds = %for.body10
  %15 = load i32, ptr %i7, align 4
  %inc16 = add nsw i32 %15, 1
  store i32 %inc16, ptr %i7, align 4
  br label %for.cond8, !llvm.loop !12

for.end17:                                        ; No predecessors!
  store i32 0, ptr %i18, align 4
  br label %for.cond19

for.cond19:                                       ; preds = %for.inc32, %for.end17
  %16 = load i32, ptr %i18, align 4
  %cmp20 = icmp slt i32 %16, 32768
  br label %for.body21

for.body21:                                       ; preds = %for.cond19
  %17 = load i32, ptr %i18, align 4
  %conv = sitofp i32 %17 to double
  %add22 = fadd double %conv, 5.000000e-01
  %18 = load i32, ptr %i18, align 4
  %conv23 = sitofp i32 %18 to double
  %sub = fsub double 3.276750e+04, %conv23
  %div24 = fdiv double %add22, %sub
  %call = call noundef double @_ZN7libzpaq3logEd(double noundef %div24)
  %19 = call double @llvm.fmuladd.f64(double %call, double 6.400000e+01, double 5.000000e-01)
  %add26 = fadd double %19, 1.000000e+05
  %conv27 = fptosi double %add26 to i32
  %sub28 = sub nsw i32 %conv27, 100000
  %conv29 = trunc i32 %sub28 to i16
  %stretcht = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 9
  %20 = load i32, ptr %i18, align 4
  %idxprom30 = sext i32 %20 to i64
  %arrayidx31 = getelementptr inbounds [32768 x i16], ptr %stretcht, i64 0, i64 %idxprom30
  store i16 %conv29, ptr %arrayidx31, align 2
  br label %for.inc32

for.inc32:                                        ; preds = %for.body21
  %21 = load i32, ptr %i18, align 4
  %inc33 = add nsw i32 %21, 1
  store i32 %inc33, ptr %i18, align 4
  br label %for.cond19, !llvm.loop !13

for.end34:                                        ; No predecessors!
  store i32 0, ptr %i35, align 4
  br label %for.cond36

for.cond36:                                       ; preds = %for.inc49, %for.end34
  %22 = load i32, ptr %i35, align 4
  %cmp37 = icmp slt i32 %22, 4096
  br label %for.body38

for.body38:                                       ; preds = %for.cond36
  %23 = load i32, ptr %i35, align 4
  %sub39 = sub nsw i32 %23, 2048
  %conv40 = sitofp i32 %sub39 to double
  %mul41 = fmul double %conv40, -1.562500e-02
  %call42 = call noundef double @_ZN7libzpaq3expEd(double noundef %mul41)
  %add43 = fadd double 1.000000e+00, %call42
  %div44 = fdiv double 3.276800e+04, %add43
  %conv45 = fptosi double %div44 to i32
  %conv46 = trunc i32 %conv45 to i16
  %squasht = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 8
  %24 = load i32, ptr %i35, align 4
  %idxprom47 = sext i32 %24 to i64
  %arrayidx48 = getelementptr inbounds [4096 x i16], ptr %squasht, i64 0, i64 %idxprom47
  store i16 %conv46, ptr %arrayidx48, align 2
  br label %for.inc49

for.inc49:                                        ; preds = %for.body38
  %25 = load i32, ptr %i35, align 4
  %inc50 = add nsw i32 %25, 1
  store i32 %inc50, ptr %i35, align 4
  br label %for.cond36, !llvm.loop !14

for.end51:                                        ; No predecessors!
  store i32 0, ptr %sqsum, align 4
  store i32 0, ptr %stsum, align 4
  store i32 32767, ptr %i52, align 4
  br label %for.cond53

for.cond53:                                       ; preds = %for.inc60, %for.end51
  %26 = load i32, ptr %i52, align 4
  %cmp54 = icmp sge i32 %26, 0
  br label %for.body55

for.body55:                                       ; preds = %for.cond53
  %27 = load i32, ptr %stsum, align 4
  %mul56 = mul i32 %27, 3
  %28 = load i32, ptr %i52, align 4
  %call58 = invoke noundef i32 null(ptr noundef nonnull align 8 dereferenceable(110620) %this1, i32 noundef %28)
          to label %invoke.cont57 unwind label %lpad3

invoke.cont57:                                    ; preds = %for.body55
  %add59 = add i32 %mul56, %call58
  store i32 %add59, ptr %stsum, align 4
  br label %for.inc60

for.inc60:                                        ; preds = %invoke.cont57
  %29 = load i32, ptr %i52, align 4
  %dec = add nsw i32 %29, -1
  store i32 %dec, ptr %i52, align 4
  br label %for.cond53, !llvm.loop !15

for.end61:                                        ; No predecessors!
  store i32 4095, ptr %i62, align 4
  br label %for.cond63

for.cond63:                                       ; preds = %for.inc71, %for.end61
  %30 = load i32, ptr %i62, align 4
  %cmp64 = icmp sge i32 %30, 0
  br label %for.body65

for.body65:                                       ; preds = %for.cond63
  %31 = load i32, ptr %sqsum, align 4
  %mul66 = mul i32 %31, 3
  %32 = load i32, ptr %i62, align 4
  %sub67 = sub nsw i32 %32, 2048
  %call69 = invoke noundef i32 null(ptr noundef nonnull align 8 dereferenceable(110620) %this1, i32 noundef %sub67)
          to label %invoke.cont68 unwind label %lpad3

invoke.cont68:                                    ; preds = %for.body65
  %add70 = add i32 %mul66, %call69
  store i32 %add70, ptr %sqsum, align 4
  br label %for.inc71

for.inc71:                                        ; preds = %invoke.cont68
  %33 = load i32, ptr %i62, align 4
  %dec72 = add nsw i32 %33, -1
  store i32 %dec72, ptr %i62, align 4
  br label %for.cond63, !llvm.loop !16

for.end73:                                        ; No predecessors!
  %pcode = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 11
  store ptr null, ptr %pcode, align 8
  %pcode_size = getelementptr inbounds %"class.libzpaq::Predictor", ptr %this1, i32 0, i32 12
  store i32 0, ptr %pcode_size, align 8
  ret void

arraydestroy.done79:                              ; preds = %lpad3
  br label %eh.resume

eh.resume:                                        ; preds = %arraydestroy.done79, %arraydestroy.done2
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val80 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val80
}

; Function Attrs: mustprogress noinline nounwind uwtable
declare noundef double @_ZN7libzpaq3logEd(double noundef) #11

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare double @llvm.fmuladd.f64(double, double, double) #13

; Function Attrs: mustprogress noinline nounwind uwtable
declare noundef double @_ZN7libzpaq3expEd(double noundef) #11

; Function Attrs: nounwind
declare double @exp(double noundef) #4

; Function Attrs: nounwind
declare double @log(double noundef) #4

; Function Attrs: noinline uwtable
define void @_ZN7libzpaq10StateTableC2Ev(ptr noundef nonnull align 1 dereferenceable(1024) %this) unnamed_addr #12 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %N = alloca i32, align 4
  %t = alloca [50 x [50 x [2 x i8]]], align 16
  %state = alloca i32, align 4
  %i = alloca i32, align 4
  %n1 = alloca i32, align 4
  %n0 = alloca i32, align 4
  %n = alloca i32, align 4
  %n020 = alloca i32, align 4
  %n124 = alloca i32, align 4
  %y = alloca i32, align 4
  %s = alloca i32, align 4
  %s0 = alloca i32, align 4
  %s1 = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  store i32 50, ptr %N, align 4
  call void @llvm.memset.p0.i64(ptr align 16 %t, i8 0, i64 5000, i1 false)
  store i32 0, ptr %state, align 4
  store i32 0, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc16, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 50
  br label %for.body

for.body:                                         ; preds = %for.cond
  store i32 0, ptr %n1, align 4
  br label %for.cond2

for.cond2:                                        ; preds = %for.inc, %for.body
  %1 = load i32, ptr %n1, align 4
  %2 = load i32, ptr %i, align 4
  %cmp3 = icmp sle i32 %1, %2
  %3 = load i32, ptr %i, align 4
  %4 = load i32, ptr %n1, align 4
  %sub = sub nsw i32 %3, %4
  store i32 %sub, ptr %n0, align 4
  %5 = load i32, ptr %n0, align 4
  %6 = load i32, ptr %n1, align 4
  %call = call noundef i32 @_ZN7libzpaq10StateTable10num_statesEii(ptr noundef nonnull align 1 dereferenceable(1024) %this1, i32 noundef %5, i32 noundef %6)
  store i32 %call, ptr %n, align 4
  %7 = load i32, ptr %n, align 4
  %tobool = icmp ne i32 %7, 0
  br label %if.then

if.then:                                          ; preds = %for.cond2
  %8 = load i32, ptr %state, align 4
  %conv = trunc i32 %8 to i8
  %9 = load i32, ptr %n0, align 4
  %idxprom = sext i32 %9 to i64
  %arrayidx = getelementptr inbounds [50 x [50 x [2 x i8]]], ptr %t, i64 0, i64 %idxprom
  %10 = load i32, ptr %n1, align 4
  %idxprom5 = sext i32 %10 to i64
  %arrayidx6 = getelementptr inbounds [50 x [2 x i8]], ptr %arrayidx, i64 0, i64 %idxprom5
  %arrayidx7 = getelementptr inbounds [2 x i8], ptr %arrayidx6, i64 0, i64 0
  store i8 %conv, ptr %arrayidx7, align 2
  %11 = load i32, ptr %state, align 4
  %12 = load i32, ptr %n, align 4
  %add = add nsw i32 %11, %12
  %sub8 = sub nsw i32 %add, 1
  %conv9 = trunc i32 %sub8 to i8
  %13 = load i32, ptr %n0, align 4
  %idxprom10 = sext i32 %13 to i64
  %arrayidx11 = getelementptr inbounds [50 x [50 x [2 x i8]]], ptr %t, i64 0, i64 %idxprom10
  %14 = load i32, ptr %n1, align 4
  %idxprom12 = sext i32 %14 to i64
  %arrayidx13 = getelementptr inbounds [50 x [2 x i8]], ptr %arrayidx11, i64 0, i64 %idxprom12
  %arrayidx14 = getelementptr inbounds [2 x i8], ptr %arrayidx13, i64 0, i64 1
  store i8 %conv9, ptr %arrayidx14, align 1
  %15 = load i32, ptr %n, align 4
  %16 = load i32, ptr %state, align 4
  %add15 = add nsw i32 %16, %15
  store i32 %add15, ptr %state, align 4
  br label %if.end

if.end:                                           ; preds = %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %17 = load i32, ptr %n1, align 4
  %inc = add nsw i32 %17, 1
  store i32 %inc, ptr %n1, align 4
  br label %for.cond2, !llvm.loop !17

for.end:                                          ; No predecessors!
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %18 = load i32, ptr %i, align 4
  %inc17 = add nsw i32 %18, 1
  store i32 %inc17, ptr %i, align 4
  br label %for.cond, !llvm.loop !18

for.end18:                                        ; No predecessors!
  %ns = getelementptr inbounds %"class.libzpaq::StateTable", ptr %this1, i32 0, i32 0
  %arraydecay = getelementptr inbounds [1024 x i8], ptr %ns, i64 0, i64 0
  %call19 = call noundef ptr @_ZN7libzpaq6memsetEPvim(ptr noundef %arraydecay, i32 noundef 0, i64 noundef 1024)
  store i32 0, ptr %n020, align 4
  br label %for.cond21

for.cond21:                                       ; preds = %for.inc76, %for.end18
  %19 = load i32, ptr %n020, align 4
  %cmp22 = icmp slt i32 %19, 50
  br label %for.body23

for.body23:                                       ; preds = %for.cond21
  store i32 0, ptr %n124, align 4
  br label %for.cond25

for.cond25:                                       ; preds = %for.inc73, %for.body23
  %20 = load i32, ptr %n124, align 4
  %cmp26 = icmp slt i32 %20, 50
  br label %for.body27

for.body27:                                       ; preds = %for.cond25
  store i32 0, ptr %y, align 4
  br label %for.cond28

for.cond28:                                       ; preds = %for.inc70, %for.body27
  %21 = load i32, ptr %y, align 4
  %22 = load i32, ptr %n020, align 4
  %23 = load i32, ptr %n124, align 4
  %call29 = call noundef i32 @_ZN7libzpaq10StateTable10num_statesEii(ptr noundef nonnull align 1 dereferenceable(1024) %this1, i32 noundef %22, i32 noundef %23)
  %cmp30 = icmp slt i32 %21, %call29
  br label %for.body31

for.body31:                                       ; preds = %for.cond28
  %24 = load i32, ptr %n020, align 4
  %idxprom32 = sext i32 %24 to i64
  %arrayidx33 = getelementptr inbounds [50 x [50 x [2 x i8]]], ptr %t, i64 0, i64 %idxprom32
  %25 = load i32, ptr %n124, align 4
  %idxprom34 = sext i32 %25 to i64
  %arrayidx35 = getelementptr inbounds [50 x [2 x i8]], ptr %arrayidx33, i64 0, i64 %idxprom34
  %26 = load i32, ptr %y, align 4
  %idxprom36 = sext i32 %26 to i64
  %arrayidx37 = getelementptr inbounds [2 x i8], ptr %arrayidx35, i64 0, i64 %idxprom36
  %27 = load i8, ptr %arrayidx37, align 1
  %conv38 = zext i8 %27 to i32
  store i32 %conv38, ptr %s, align 4
  %28 = load i32, ptr %n020, align 4
  store i32 %28, ptr %s0, align 4
  %29 = load i32, ptr %n124, align 4
  store i32 %29, ptr %s1, align 4
  call void @_ZN7libzpaq10StateTable10next_stateERiS1_i(ptr noundef nonnull align 1 dereferenceable(1024) %this1, ptr noundef nonnull align 4 dereferenceable(4) %s0, ptr noundef nonnull align 4 dereferenceable(4) %s1, i32 noundef 0)
  %30 = load i32, ptr %s0, align 4
  %idxprom39 = sext i32 %30 to i64
  %arrayidx40 = getelementptr inbounds [50 x [50 x [2 x i8]]], ptr %t, i64 0, i64 %idxprom39
  %31 = load i32, ptr %s1, align 4
  %idxprom41 = sext i32 %31 to i64
  %arrayidx42 = getelementptr inbounds [50 x [2 x i8]], ptr %arrayidx40, i64 0, i64 %idxprom41
  %arrayidx43 = getelementptr inbounds [2 x i8], ptr %arrayidx42, i64 0, i64 0
  %32 = load i8, ptr %arrayidx43, align 2
  %ns44 = getelementptr inbounds %"class.libzpaq::StateTable", ptr %this1, i32 0, i32 0
  %33 = load i32, ptr %s, align 4
  %mul = mul nsw i32 %33, 4
  %add45 = add nsw i32 %mul, 0
  %idxprom46 = sext i32 %add45 to i64
  %arrayidx47 = getelementptr inbounds [1024 x i8], ptr %ns44, i64 0, i64 %idxprom46
  store i8 %32, ptr %arrayidx47, align 1
  %34 = load i32, ptr %n020, align 4
  store i32 %34, ptr %s0, align 4
  %35 = load i32, ptr %n124, align 4
  store i32 %35, ptr %s1, align 4
  call void @_ZN7libzpaq10StateTable10next_stateERiS1_i(ptr noundef nonnull align 1 dereferenceable(1024) %this1, ptr noundef nonnull align 4 dereferenceable(4) %s0, ptr noundef nonnull align 4 dereferenceable(4) %s1, i32 noundef 1)
  %36 = load i32, ptr %s0, align 4
  %idxprom48 = sext i32 %36 to i64
  %arrayidx49 = getelementptr inbounds [50 x [50 x [2 x i8]]], ptr %t, i64 0, i64 %idxprom48
  %37 = load i32, ptr %s1, align 4
  %idxprom50 = sext i32 %37 to i64
  %arrayidx51 = getelementptr inbounds [50 x [2 x i8]], ptr %arrayidx49, i64 0, i64 %idxprom50
  %arrayidx52 = getelementptr inbounds [2 x i8], ptr %arrayidx51, i64 0, i64 1
  %38 = load i8, ptr %arrayidx52, align 1
  %ns53 = getelementptr inbounds %"class.libzpaq::StateTable", ptr %this1, i32 0, i32 0
  %39 = load i32, ptr %s, align 4
  %mul54 = mul nsw i32 %39, 4
  %add55 = add nsw i32 %mul54, 1
  %idxprom56 = sext i32 %add55 to i64
  %arrayidx57 = getelementptr inbounds [1024 x i8], ptr %ns53, i64 0, i64 %idxprom56
  store i8 %38, ptr %arrayidx57, align 1
  %40 = load i32, ptr %n020, align 4
  %conv58 = trunc i32 %40 to i8
  %ns59 = getelementptr inbounds %"class.libzpaq::StateTable", ptr %this1, i32 0, i32 0
  %41 = load i32, ptr %s, align 4
  %mul60 = mul nsw i32 %41, 4
  %add61 = add nsw i32 %mul60, 2
  %idxprom62 = sext i32 %add61 to i64
  %arrayidx63 = getelementptr inbounds [1024 x i8], ptr %ns59, i64 0, i64 %idxprom62
  store i8 %conv58, ptr %arrayidx63, align 1
  %42 = load i32, ptr %n124, align 4
  %conv64 = trunc i32 %42 to i8
  %ns65 = getelementptr inbounds %"class.libzpaq::StateTable", ptr %this1, i32 0, i32 0
  %43 = load i32, ptr %s, align 4
  %mul66 = mul nsw i32 %43, 4
  %add67 = add nsw i32 %mul66, 3
  %idxprom68 = sext i32 %add67 to i64
  %arrayidx69 = getelementptr inbounds [1024 x i8], ptr %ns65, i64 0, i64 %idxprom68
  store i8 %conv64, ptr %arrayidx69, align 1
  br label %for.inc70

for.inc70:                                        ; preds = %for.body31
  %44 = load i32, ptr %y, align 4
  %inc71 = add nsw i32 %44, 1
  store i32 %inc71, ptr %y, align 4
  br label %for.cond28, !llvm.loop !19

for.end72:                                        ; No predecessors!
  br label %for.inc73

for.inc73:                                        ; preds = %for.end72
  %45 = load i32, ptr %n124, align 4
  %inc74 = add nsw i32 %45, 1
  store i32 %inc74, ptr %n124, align 4
  br label %for.cond25, !llvm.loop !20

for.end75:                                        ; No predecessors!
  br label %for.inc76

for.inc76:                                        ; preds = %for.end75
  %46 = load i32, ptr %n020, align 4
  %inc77 = add nsw i32 %46, 1
  store i32 %inc77, ptr %n020, align 4
  br label %for.cond21, !llvm.loop !21

for.end78:                                        ; No predecessors!
  ret void
}

; Function Attrs: mustprogress noinline uwtable
declare noundef i32 @_ZN7libzpaq10StateTable10num_statesEii(ptr noundef nonnull align 1 dereferenceable(1024), i32 noundef, i32 noundef) #10 align 2

; Function Attrs: mustprogress noinline nounwind uwtable
declare noundef ptr @_ZN7libzpaq6memsetEPvim(ptr noundef, i32 noundef, i64 noundef) #11

; Function Attrs: mustprogress noinline uwtable
declare void @_ZN7libzpaq10StateTable10next_stateERiS1_i(ptr noundef nonnull align 1 dereferenceable(1024), ptr noundef nonnull align 4 dereferenceable(4), ptr noundef nonnull align 4 dereferenceable(4), i32 noundef) #10 align 2

; Function Attrs: mustprogress noinline nounwind uwtable
declare void @_ZN7libzpaq10StateTable8discountERi(ptr noundef nonnull align 1 dereferenceable(1024), ptr noundef nonnull align 4 dereferenceable(4)) #11 align 2

; Function Attrs: noinline uwtable
declare void @_ZN7libzpaq5ArrayIhEC2Emi(ptr noundef nonnull align 8 dereferenceable(20), i64 noundef, i32 noundef) unnamed_addr #12 align 2

; Function Attrs: noinline uwtable
define void @_ZN7libzpaq5ZPAQLC2Ev(ptr noundef nonnull align 8 dereferenceable(192) %this) unnamed_addr #12 align 2 personality ptr null {
entry:
  %this.addr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %header = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 2
  call void @_ZN7libzpaq5ArrayIhEC2Emi(ptr noundef nonnull align 8 dereferenceable(20) %header, i64 noundef 0, i32 noundef 0)
  %m = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 7
  invoke void @_ZN7libzpaq5ArrayIhEC2Emi(ptr noundef nonnull align 8 dereferenceable(20) %m, i64 noundef 0, i32 noundef 0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  %h = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 8
  invoke void null(ptr noundef nonnull align 8 dereferenceable(20) %h, i64 noundef 0, i32 noundef 0)
          to label %invoke.cont3 unwind label %lpad2

invoke.cont3:                                     ; preds = %invoke.cont
  %r = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 9
  invoke void null(ptr noundef nonnull align 8 dereferenceable(20) %r, i64 noundef 0, i32 noundef 0)
          to label %invoke.cont5 unwind label %lpad4

invoke.cont5:                                     ; preds = %invoke.cont3
  %outbuf = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 10
  invoke void null(ptr noundef nonnull align 8 dereferenceable(20) %outbuf, i64 noundef 0, i32 noundef 0)
          to label %invoke.cont7 unwind label %lpad6

invoke.cont7:                                     ; preds = %invoke.cont5
  %output = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 0
  store ptr null, ptr %output, align 8
  %sha1 = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 1
  store ptr null, ptr %sha1, align 8
  %rcode = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 19
  store ptr null, ptr %rcode, align 8
  %rcode_size = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 18
  store i32 0, ptr %rcode_size, align 4
  invoke void null(ptr noundef nonnull align 8 dereferenceable(192) %this1)
          to label %invoke.cont9 unwind label %lpad8

invoke.cont9:                                     ; preds = %invoke.cont7
  %outbuf10 = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 10
  invoke void null(ptr noundef nonnull align 8 dereferenceable(20) %outbuf10, i64 noundef 16384, i32 noundef 0)
          to label %invoke.cont11 unwind label %lpad8

invoke.cont11:                                    ; preds = %invoke.cont9
  %bufptr = getelementptr inbounds %"class.libzpaq::ZPAQL", ptr %this1, i32 0, i32 11
  store i32 0, ptr %bufptr, align 8
  ret void

lpad:                                             ; preds = %entry
  %0 = landingpad { ptr, i32 }
          cleanup
  %1 = extractvalue { ptr, i32 } %0, 0
  store ptr %1, ptr %exn.slot, align 8
  %2 = extractvalue { ptr, i32 } %0, 1
  store i32 %2, ptr %ehselector.slot, align 4
  br label %ehcleanup14

lpad2:                                            ; preds = %invoke.cont
  %3 = landingpad { ptr, i32 }
          cleanup
  %4 = extractvalue { ptr, i32 } %3, 0
  store ptr %4, ptr %exn.slot, align 8
  %5 = extractvalue { ptr, i32 } %3, 1
  store i32 %5, ptr %ehselector.slot, align 4
  br label %ehcleanup13

lpad4:                                            ; preds = %invoke.cont3
  %6 = landingpad { ptr, i32 }
          cleanup
  %7 = extractvalue { ptr, i32 } %6, 0
  store ptr %7, ptr %exn.slot, align 8
  %8 = extractvalue { ptr, i32 } %6, 1
  store i32 %8, ptr %ehselector.slot, align 4
  br label %ehcleanup12

lpad6:                                            ; preds = %invoke.cont5
  %9 = landingpad { ptr, i32 }
          cleanup
  %10 = extractvalue { ptr, i32 } %9, 0
  store ptr %10, ptr %exn.slot, align 8
  %11 = extractvalue { ptr, i32 } %9, 1
  store i32 %11, ptr %ehselector.slot, align 4
  br label %ehcleanup

lpad8:                                            ; preds = %invoke.cont9, %invoke.cont7
  %12 = landingpad { ptr, i32 }
          cleanup
  %13 = extractvalue { ptr, i32 } %12, 0
  store ptr %13, ptr %exn.slot, align 8
  %14 = extractvalue { ptr, i32 } %12, 1
  store i32 %14, ptr %ehselector.slot, align 4
  call void @_ZN7libzpaq5ArrayIcED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %outbuf) #14
  br label %ehcleanup

ehcleanup:                                        ; preds = %lpad8, %lpad6
  call void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %r) #14
  br label %ehcleanup12

ehcleanup12:                                      ; preds = %ehcleanup, %lpad4
  call void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %h) #14
  br label %ehcleanup13

ehcleanup13:                                      ; preds = %ehcleanup12, %lpad2
  call void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %m) #14
  br label %ehcleanup14

ehcleanup14:                                      ; preds = %ehcleanup13, %lpad
  call void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20) %header) #14
  br label %eh.resume

eh.resume:                                        ; preds = %ehcleanup14
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val15 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val15
}

; Function Attrs: noinline uwtable
define void @_ZN7libzpaq7DecoderC2ERNS_5ZPAQLE(ptr noundef nonnull align 8 dereferenceable(110672) %this, ptr noundef nonnull align 8 dereferenceable(192) %z) unnamed_addr #12 align 2 personality ptr null {
entry:
  %this.addr = alloca ptr, align 8
  %z.addr = alloca ptr, align 8
  %exn.slot = alloca ptr, align 8
  %ehselector.slot = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  store ptr %z, ptr %z.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  %in = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 0
  store ptr null, ptr %in, align 8
  %low = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 1
  store i32 1, ptr %low, align 8
  %high = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 2
  store i32 -1, ptr %high, align 4
  %curr = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 3
  store i32 0, ptr %curr, align 8
  %pr = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 5
  %0 = load ptr, ptr %z.addr, align 8
  call void @_ZN7libzpaq9PredictorC2ERNS_5ZPAQLE(ptr noundef nonnull align 8 dereferenceable(110620) %pr, ptr noundef nonnull align 8 dereferenceable(192) %0)
  %buf = getelementptr inbounds %"class.libzpaq::Decoder", ptr %this1, i32 0, i32 6
  invoke void null(ptr noundef nonnull align 8 dereferenceable(20) %buf, i64 noundef 65536, i32 noundef 0)
          to label %invoke.cont unwind label %lpad

invoke.cont:                                      ; preds = %entry
  ret void

lpad:                                             ; preds = %entry
  %1 = landingpad { ptr, i32 }
          cleanup
  %2 = extractvalue { ptr, i32 } %1, 0
  store ptr %2, ptr %exn.slot, align 8
  %3 = extractvalue { ptr, i32 } %1, 1
  store i32 %3, ptr %ehselector.slot, align 4
  call void @_ZN7libzpaq9PredictorD2Ev(ptr noundef nonnull align 8 dereferenceable(110620) %pr) #14
  br label %eh.resume

eh.resume:                                        ; preds = %lpad
  %exn = load ptr, ptr %exn.slot, align 8
  %sel = load i32, ptr %ehselector.slot, align 4
  %lpad.val = insertvalue { ptr, i32 } poison, ptr %exn, 0
  %lpad.val2 = insertvalue { ptr, i32 } %lpad.val, i32 %sel, 1
  resume { ptr, i32 } %lpad.val2
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: readwrite)
declare void @llvm.memmove.p0.p0.i64(ptr nocapture writeonly, ptr nocapture readonly, i64, i1 immarg) #1

; uselistorder directives
uselistorder ptr null, { 1, 2, 87, 88, 0, 4, 5, 6, 7, 8, 9, 10, 11, 89, 90, 3, 13, 14, 15, 16, 91, 92, 12, 18, 19, 93, 94, 17, 21, 22, 95, 96, 20, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86 }
uselistorder i32 2, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 17, 18, 19, 20, 15, 16 }
uselistorder i32 1, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 96, 97, 98, 99, 108, 109, 110, 111, 100, 101, 102, 103, 104, 105, 106, 107 }
uselistorder ptr @.str.50, { 1, 0 }
uselistorder ptr @.str.59, { 1, 0 }
uselistorder ptr @sha4_process, { 1, 0 }
uselistorder ptr @_ZN7libzpaq5ArrayIjED2Ev, { 0, 1, 3, 2 }
uselistorder ptr @_ZN7libzpaq5ArrayIhED2Ev, { 0, 1, 3, 2 }
uselistorder ptr @_ZN7libzpaq10StateTable10num_statesEii, { 1, 0 }
uselistorder ptr @_ZN7libzpaq10StateTable10next_stateERiS1_i, { 1, 0 }

attributes #0 = { noreturn nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #1 = { nocallback nofree nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind willreturn }
attributes #3 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #4 = { nounwind "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #5 = { "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #6 = { nounwind allocsize(0,1) "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #7 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #8 = { cold noreturn nounwind }
attributes #9 = { noinline noreturn nounwind uwtable "frame-pointer"="all" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #10 = { mustprogress noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #11 = { mustprogress noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #12 = { noinline uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
attributes #13 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #14 = { nounwind }
attributes #15 = { noreturn nounwind }

!llvm.ident = !{!0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0, !0}
!llvm.module.flags = !{!1, !2, !3, !4, !5}

!0 = !{!"clang version 18.0.0 (https://github.com/llvm/llvm-project.git cd7280b6e6c43e3c236200bc026f45d33f54f059)"}
!1 = !{i32 1, !"wchar_size", i32 4}
!2 = !{i32 8, !"PIC Level", i32 2}
!3 = !{i32 7, !"PIE Level", i32 2}
!4 = !{i32 7, !"uwtable", i32 2}
!5 = !{i32 7, !"frame-pointer", i32 2}
!6 = distinct !{!6, !7}
!7 = !{!"llvm.loop.mustprogress"}
!8 = distinct !{!8, !7}
!9 = distinct !{!9, !7}
!10 = distinct !{!10, !7}
!11 = distinct !{!11, !7}
!12 = distinct !{!12, !7}
!13 = distinct !{!13, !7}
!14 = distinct !{!14, !7}
!15 = distinct !{!15, !7}
!16 = distinct !{!16, !7}
!17 = distinct !{!17, !7}
!18 = distinct !{!18, !7}
!19 = distinct !{!19, !7}
!20 = distinct !{!20, !7}
!21 = distinct !{!21, !7}
