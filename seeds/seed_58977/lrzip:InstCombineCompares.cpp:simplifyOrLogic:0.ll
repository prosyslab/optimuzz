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
%"class.libzpaq::ZPAQL" = type { ptr, ptr, %"class.libzpaq::Array.0", i32, i32, i32, [4 x i8], %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", i32, i32, i32, i32, i32, i32, i32, i32, ptr }
%"class.libzpaq::Array.0" = type <{ ptr, i64, i32, [4 x i8] }>
%"class.libzpaq::Predictor" = type <{ i32, i32, [256 x i32], [256 x i32], ptr, [256 x %"struct.libzpaq::Component"], [256 x i32], [1024 x i32], [4096 x i16], [32768 x i16], %"class.libzpaq::StateTable", ptr, i32, [4 x i8] }>
%"struct.libzpaq::Component" = type { i64, i64, i64, i64, i64, %"class.libzpaq::Array.0", %"class.libzpaq::Array.0", %"class.libzpaq::Array.0" }
%"class.libzpaq::StateTable" = type { [1024 x i8] }
%"class.libzpaq::SHA1" = type { i32, i32, [5 x i32], [80 x i32], [20 x i8] }
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

; Function Attrs: cold noreturn nounwind
declare void @llvm.trap() #7

; Function Attrs: noinline nounwind uwtable
define void @_ZN7libzpaq5ZPAQLD2Ev(ptr noundef nonnull align 8 dereferenceable(192) %this) unnamed_addr #8 align 2 personality ptr null {
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
declare void @_ZN7libzpaq5ArrayIcED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #8 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayIjED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #8 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayIhED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #8 align 2

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
define void @_ZN7libzpaq9PredictorD2Ev(ptr noundef nonnull align 8 dereferenceable(110620) %this) unnamed_addr #8 align 2 personality ptr null {
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
declare void @_ZN7libzpaq9ComponentD2Ev(ptr noundef nonnull align 8 dereferenceable(112)) unnamed_addr #8 align 2

; Function Attrs: noinline nounwind uwtable
declare void @_ZN7libzpaq5ArrayItED2Ev(ptr noundef nonnull align 8 dereferenceable(20)) unnamed_addr #8 align 2

; Function Attrs: mustprogress noinline nounwind uwtable
define void @_ZN7libzpaq4SHA17processEv(ptr noundef nonnull align 4 dereferenceable(368) %this) #11 align 2 {
entry:
  %this.addr = alloca ptr, align 8
  %i = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  %d = alloca i32, align 4
  %e = alloca i32, align 4
  %k1 = alloca i32, align 4
  %k2 = alloca i32, align 4
  %k3 = alloca i32, align 4
  %k4 = alloca i32, align 4
  store ptr %this, ptr %this.addr, align 8
  %this1 = load ptr, ptr %this.addr, align 8
  store i32 16, ptr %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, ptr %i, align 4
  %cmp = icmp slt i32 %0, 80
  br label %for.end

for.body:                                         ; No predecessors!
  %w = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %1 = load i32, ptr %i, align 4
  %sub = sub nsw i32 %1, 3
  %idxprom = sext i32 %sub to i64
  %arrayidx = getelementptr inbounds [80 x i32], ptr %w, i64 0, i64 %idxprom
  %2 = load i32, ptr %arrayidx, align 4
  %w2 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %3 = load i32, ptr %i, align 4
  %sub3 = sub nsw i32 %3, 8
  %idxprom4 = sext i32 %sub3 to i64
  %arrayidx5 = getelementptr inbounds [80 x i32], ptr %w2, i64 0, i64 %idxprom4
  %4 = load i32, ptr %arrayidx5, align 4
  %xor = xor i32 %2, %4
  %w6 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %5 = load i32, ptr %i, align 4
  %sub7 = sub nsw i32 %5, 14
  %idxprom8 = sext i32 %sub7 to i64
  %arrayidx9 = getelementptr inbounds [80 x i32], ptr %w6, i64 0, i64 %idxprom8
  %6 = load i32, ptr %arrayidx9, align 4
  %xor10 = xor i32 %xor, %6
  %w11 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %7 = load i32, ptr %i, align 4
  %sub12 = sub nsw i32 %7, 16
  %idxprom13 = sext i32 %sub12 to i64
  %arrayidx14 = getelementptr inbounds [80 x i32], ptr %w11, i64 0, i64 %idxprom13
  %8 = load i32, ptr %arrayidx14, align 4
  %xor15 = xor i32 %xor10, %8
  %w16 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %9 = load i32, ptr %i, align 4
  %idxprom17 = sext i32 %9 to i64
  %arrayidx18 = getelementptr inbounds [80 x i32], ptr %w16, i64 0, i64 %idxprom17
  store i32 %xor15, ptr %arrayidx18, align 4
  %w19 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %10 = load i32, ptr %i, align 4
  %idxprom20 = sext i32 %10 to i64
  %arrayidx21 = getelementptr inbounds [80 x i32], ptr %w19, i64 0, i64 %idxprom20
  %11 = load i32, ptr %arrayidx21, align 4
  %shl = shl i32 %11, 1
  %w22 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %12 = load i32, ptr %i, align 4
  %idxprom23 = sext i32 %12 to i64
  %arrayidx24 = getelementptr inbounds [80 x i32], ptr %w22, i64 0, i64 %idxprom23
  %13 = load i32, ptr %arrayidx24, align 4
  %shr = lshr i32 %13, 31
  %or = or i32 %shl, %shr
  %w25 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %14 = load i32, ptr %i, align 4
  %idxprom26 = sext i32 %14 to i64
  %arrayidx27 = getelementptr inbounds [80 x i32], ptr %w25, i64 0, i64 %idxprom26
  store i32 %or, ptr %arrayidx27, align 4
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %15 = load i32, ptr %i, align 4
  %inc = add nsw i32 %15, 1
  store i32 %inc, ptr %i, align 4
  br label %for.cond, !llvm.loop !6

for.end:                                          ; preds = %for.cond
  %h = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx28 = getelementptr inbounds [5 x i32], ptr %h, i64 0, i64 0
  %16 = load i32, ptr %arrayidx28, align 4
  store i32 %16, ptr %a, align 4
  %h29 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx30 = getelementptr inbounds [5 x i32], ptr %h29, i64 0, i64 1
  %17 = load i32, ptr %arrayidx30, align 4
  store i32 %17, ptr %b, align 4
  %h31 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx32 = getelementptr inbounds [5 x i32], ptr %h31, i64 0, i64 2
  %18 = load i32, ptr %arrayidx32, align 4
  store i32 %18, ptr %c, align 4
  %h33 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx34 = getelementptr inbounds [5 x i32], ptr %h33, i64 0, i64 3
  %19 = load i32, ptr %arrayidx34, align 4
  store i32 %19, ptr %d, align 4
  %h35 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx36 = getelementptr inbounds [5 x i32], ptr %h35, i64 0, i64 4
  %20 = load i32, ptr %arrayidx36, align 4
  store i32 %20, ptr %e, align 4
  store i32 1518500249, ptr %k1, align 4
  store i32 1859775393, ptr %k2, align 4
  store i32 -1894007588, ptr %k3, align 4
  store i32 -899497514, ptr %k4, align 4
  %21 = load i32, ptr %a, align 4
  %shl37 = shl i32 %21, 5
  %22 = load i32, ptr %a, align 4
  %shr38 = lshr i32 %22, 27
  %or39 = or i32 %shl37, %shr38
  %23 = load i32, ptr %b, align 4
  %24 = load i32, ptr %c, align 4
  %and = and i32 %23, %24
  %25 = load i32, ptr %b, align 4
  %not = xor i32 %25, -1
  %26 = load i32, ptr %d, align 4
  %and40 = and i32 %not, %26
  %or41 = or i32 %and, %and40
  %add = add i32 %or39, %or41
  %add42 = add i32 %add, 1518500249
  %w43 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx44 = getelementptr inbounds [80 x i32], ptr %w43, i64 0, i64 0
  %27 = load i32, ptr %arrayidx44, align 4
  %add45 = add i32 %add42, %27
  %28 = load i32, ptr %e, align 4
  %add46 = add i32 %28, %add45
  store i32 %add46, ptr %e, align 4
  %29 = load i32, ptr %b, align 4
  %shl47 = shl i32 %29, 30
  %30 = load i32, ptr %b, align 4
  %shr48 = lshr i32 %30, 2
  %or49 = or i32 %shl47, %shr48
  store i32 %or49, ptr %b, align 4
  %31 = load i32, ptr %e, align 4
  %shl50 = shl i32 %31, 5
  %32 = load i32, ptr %e, align 4
  %shr51 = lshr i32 %32, 27
  %or52 = or i32 %shl50, %shr51
  %33 = load i32, ptr %a, align 4
  %34 = load i32, ptr %b, align 4
  %and53 = and i32 %33, %34
  %35 = load i32, ptr %a, align 4
  %not54 = xor i32 %35, -1
  %36 = load i32, ptr %c, align 4
  %and55 = and i32 %not54, %36
  %or56 = or i32 %and53, %and55
  %add57 = add i32 %or52, %or56
  %add58 = add i32 %add57, 1518500249
  %w59 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx60 = getelementptr inbounds [80 x i32], ptr %w59, i64 0, i64 1
  %37 = load i32, ptr %arrayidx60, align 4
  %add61 = add i32 %add58, %37
  %38 = load i32, ptr %d, align 4
  %add62 = add i32 %38, %add61
  store i32 %add62, ptr %d, align 4
  %39 = load i32, ptr %a, align 4
  %shl63 = shl i32 %39, 30
  %40 = load i32, ptr %a, align 4
  %shr64 = lshr i32 %40, 2
  %or65 = or i32 %shl63, %shr64
  store i32 %or65, ptr %a, align 4
  %41 = load i32, ptr %d, align 4
  %shl66 = shl i32 %41, 5
  %42 = load i32, ptr %d, align 4
  %shr67 = lshr i32 %42, 27
  %or68 = or i32 %shl66, %shr67
  %43 = load i32, ptr %e, align 4
  %44 = load i32, ptr %a, align 4
  %and69 = and i32 %43, %44
  %45 = load i32, ptr %e, align 4
  %not70 = xor i32 %45, -1
  %46 = load i32, ptr %b, align 4
  %and71 = and i32 %not70, %46
  %or72 = or i32 %and69, %and71
  %add73 = add i32 %or68, %or72
  %add74 = add i32 %add73, 1518500249
  %w75 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx76 = getelementptr inbounds [80 x i32], ptr %w75, i64 0, i64 2
  %47 = load i32, ptr %arrayidx76, align 4
  %add77 = add i32 %add74, %47
  %48 = load i32, ptr %c, align 4
  %add78 = add i32 %48, %add77
  store i32 %add78, ptr %c, align 4
  %49 = load i32, ptr %e, align 4
  %shl79 = shl i32 %49, 30
  %50 = load i32, ptr %e, align 4
  %shr80 = lshr i32 %50, 2
  %or81 = or i32 %shl79, %shr80
  store i32 %or81, ptr %e, align 4
  %51 = load i32, ptr %c, align 4
  %shl82 = shl i32 %51, 5
  %52 = load i32, ptr %c, align 4
  %shr83 = lshr i32 %52, 27
  %or84 = or i32 %shl82, %shr83
  %53 = load i32, ptr %d, align 4
  %54 = load i32, ptr %e, align 4
  %and85 = and i32 %53, %54
  %55 = load i32, ptr %d, align 4
  %not86 = xor i32 %55, -1
  %56 = load i32, ptr %a, align 4
  %and87 = and i32 %not86, %56
  %or88 = or i32 %and85, %and87
  %add89 = add i32 %or84, %or88
  %add90 = add i32 %add89, 1518500249
  %w91 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx92 = getelementptr inbounds [80 x i32], ptr %w91, i64 0, i64 3
  %57 = load i32, ptr %arrayidx92, align 4
  %add93 = add i32 %add90, %57
  %58 = load i32, ptr %b, align 4
  %add94 = add i32 %58, %add93
  store i32 %add94, ptr %b, align 4
  %59 = load i32, ptr %d, align 4
  %shl95 = shl i32 %59, 30
  %60 = load i32, ptr %d, align 4
  %shr96 = lshr i32 %60, 2
  %or97 = or i32 %shl95, %shr96
  store i32 %or97, ptr %d, align 4
  %61 = load i32, ptr %b, align 4
  %shl98 = shl i32 %61, 5
  %62 = load i32, ptr %b, align 4
  %shr99 = lshr i32 %62, 27
  %or100 = or i32 %shl98, %shr99
  %63 = load i32, ptr %c, align 4
  %64 = load i32, ptr %d, align 4
  %and101 = and i32 %63, %64
  %65 = load i32, ptr %c, align 4
  %not102 = xor i32 %65, -1
  %66 = load i32, ptr %e, align 4
  %and103 = and i32 %not102, %66
  %or104 = or i32 %and101, %and103
  %add105 = add i32 %or100, %or104
  %add106 = add i32 %add105, 1518500249
  %w107 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx108 = getelementptr inbounds [80 x i32], ptr %w107, i64 0, i64 4
  %67 = load i32, ptr %arrayidx108, align 4
  %add109 = add i32 %add106, %67
  %68 = load i32, ptr %a, align 4
  %add110 = add i32 %68, %add109
  store i32 %add110, ptr %a, align 4
  %69 = load i32, ptr %c, align 4
  %shl111 = shl i32 %69, 30
  %70 = load i32, ptr %c, align 4
  %shr112 = lshr i32 %70, 2
  %or113 = or i32 %shl111, %shr112
  store i32 %or113, ptr %c, align 4
  %71 = load i32, ptr %a, align 4
  %shl114 = shl i32 %71, 5
  %72 = load i32, ptr %a, align 4
  %shr115 = lshr i32 %72, 27
  %or116 = or i32 %shl114, %shr115
  %73 = load i32, ptr %b, align 4
  %74 = load i32, ptr %c, align 4
  %and117 = and i32 %73, %74
  %75 = load i32, ptr %b, align 4
  %not118 = xor i32 %75, -1
  %76 = load i32, ptr %d, align 4
  %and119 = and i32 %not118, %76
  %or120 = or i32 %and117, %and119
  %add121 = add i32 %or116, %or120
  %add122 = add i32 %add121, 1518500249
  %w123 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx124 = getelementptr inbounds [80 x i32], ptr %w123, i64 0, i64 5
  %77 = load i32, ptr %arrayidx124, align 4
  %add125 = add i32 %add122, %77
  %78 = load i32, ptr %e, align 4
  %add126 = add i32 %78, %add125
  store i32 %add126, ptr %e, align 4
  %79 = load i32, ptr %b, align 4
  %shl127 = shl i32 %79, 30
  %80 = load i32, ptr %b, align 4
  %shr128 = lshr i32 %80, 2
  %or129 = or i32 %shl127, %shr128
  store i32 %or129, ptr %b, align 4
  %81 = load i32, ptr %e, align 4
  %shl130 = shl i32 %81, 5
  %82 = load i32, ptr %e, align 4
  %shr131 = lshr i32 %82, 27
  %or132 = or i32 %shl130, %shr131
  %83 = load i32, ptr %a, align 4
  %84 = load i32, ptr %b, align 4
  %and133 = and i32 %83, %84
  %85 = load i32, ptr %a, align 4
  %not134 = xor i32 %85, -1
  %86 = load i32, ptr %c, align 4
  %and135 = and i32 %not134, %86
  %or136 = or i32 %and133, %and135
  %add137 = add i32 %or132, %or136
  %add138 = add i32 %add137, 1518500249
  %w139 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx140 = getelementptr inbounds [80 x i32], ptr %w139, i64 0, i64 6
  %87 = load i32, ptr %arrayidx140, align 4
  %add141 = add i32 %add138, %87
  %88 = load i32, ptr %d, align 4
  %add142 = add i32 %88, %add141
  store i32 %add142, ptr %d, align 4
  %89 = load i32, ptr %a, align 4
  %shl143 = shl i32 %89, 30
  %90 = load i32, ptr %a, align 4
  %shr144 = lshr i32 %90, 2
  %or145 = or i32 %shl143, %shr144
  store i32 %or145, ptr %a, align 4
  %91 = load i32, ptr %d, align 4
  %shl146 = shl i32 %91, 5
  %92 = load i32, ptr %d, align 4
  %shr147 = lshr i32 %92, 27
  %or148 = or i32 %shl146, %shr147
  %93 = load i32, ptr %e, align 4
  %94 = load i32, ptr %a, align 4
  %and149 = and i32 %93, %94
  %95 = load i32, ptr %e, align 4
  %not150 = xor i32 %95, -1
  %96 = load i32, ptr %b, align 4
  %and151 = and i32 %not150, %96
  %or152 = or i32 %and149, %and151
  %add153 = add i32 %or148, %or152
  %add154 = add i32 %add153, 1518500249
  %w155 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx156 = getelementptr inbounds [80 x i32], ptr %w155, i64 0, i64 7
  %97 = load i32, ptr %arrayidx156, align 4
  %add157 = add i32 %add154, %97
  %98 = load i32, ptr %c, align 4
  %add158 = add i32 %98, %add157
  store i32 %add158, ptr %c, align 4
  %99 = load i32, ptr %e, align 4
  %shl159 = shl i32 %99, 30
  %100 = load i32, ptr %e, align 4
  %shr160 = lshr i32 %100, 2
  %or161 = or i32 %shl159, %shr160
  store i32 %or161, ptr %e, align 4
  %101 = load i32, ptr %c, align 4
  %shl162 = shl i32 %101, 5
  %102 = load i32, ptr %c, align 4
  %shr163 = lshr i32 %102, 27
  %or164 = or i32 %shl162, %shr163
  %103 = load i32, ptr %d, align 4
  %104 = load i32, ptr %e, align 4
  %and165 = and i32 %103, %104
  %105 = load i32, ptr %d, align 4
  %not166 = xor i32 %105, -1
  %106 = load i32, ptr %a, align 4
  %and167 = and i32 %not166, %106
  %or168 = or i32 %and165, %and167
  %add169 = add i32 %or164, %or168
  %add170 = add i32 %add169, 1518500249
  %w171 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx172 = getelementptr inbounds [80 x i32], ptr %w171, i64 0, i64 8
  %107 = load i32, ptr %arrayidx172, align 4
  %add173 = add i32 %add170, %107
  %108 = load i32, ptr %b, align 4
  %add174 = add i32 %108, %add173
  store i32 %add174, ptr %b, align 4
  %109 = load i32, ptr %d, align 4
  %shl175 = shl i32 %109, 30
  %110 = load i32, ptr %d, align 4
  %shr176 = lshr i32 %110, 2
  %or177 = or i32 %shl175, %shr176
  store i32 %or177, ptr %d, align 4
  %111 = load i32, ptr %b, align 4
  %shl178 = shl i32 %111, 5
  %112 = load i32, ptr %b, align 4
  %shr179 = lshr i32 %112, 27
  %or180 = or i32 %shl178, %shr179
  %113 = load i32, ptr %c, align 4
  %114 = load i32, ptr %d, align 4
  %and181 = and i32 %113, %114
  %115 = load i32, ptr %c, align 4
  %not182 = xor i32 %115, -1
  %116 = load i32, ptr %e, align 4
  %and183 = and i32 %not182, %116
  %or184 = or i32 %and181, %and183
  %add185 = add i32 %or180, %or184
  %add186 = add i32 %add185, 1518500249
  %w187 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx188 = getelementptr inbounds [80 x i32], ptr %w187, i64 0, i64 9
  %117 = load i32, ptr %arrayidx188, align 4
  %add189 = add i32 %add186, %117
  %118 = load i32, ptr %a, align 4
  %add190 = add i32 %118, %add189
  store i32 %add190, ptr %a, align 4
  %119 = load i32, ptr %c, align 4
  %shl191 = shl i32 %119, 30
  %120 = load i32, ptr %c, align 4
  %shr192 = lshr i32 %120, 2
  %or193 = or i32 %shl191, %shr192
  store i32 %or193, ptr %c, align 4
  %121 = load i32, ptr %a, align 4
  %shl194 = shl i32 %121, 5
  %122 = load i32, ptr %a, align 4
  %shr195 = lshr i32 %122, 27
  %or196 = or i32 %shl194, %shr195
  %123 = load i32, ptr %b, align 4
  %124 = load i32, ptr %c, align 4
  %and197 = and i32 %123, %124
  %125 = load i32, ptr %b, align 4
  %not198 = xor i32 %125, -1
  %126 = load i32, ptr %d, align 4
  %and199 = and i32 %not198, %126
  %or200 = or i32 %and197, %and199
  %add201 = add i32 %or196, %or200
  %add202 = add i32 %add201, 1518500249
  %w203 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx204 = getelementptr inbounds [80 x i32], ptr %w203, i64 0, i64 10
  %127 = load i32, ptr %arrayidx204, align 4
  %add205 = add i32 %add202, %127
  %128 = load i32, ptr %e, align 4
  %add206 = add i32 %128, %add205
  store i32 %add206, ptr %e, align 4
  %129 = load i32, ptr %b, align 4
  %shl207 = shl i32 %129, 30
  %130 = load i32, ptr %b, align 4
  %shr208 = lshr i32 %130, 2
  %or209 = or i32 %shl207, %shr208
  store i32 %or209, ptr %b, align 4
  %131 = load i32, ptr %e, align 4
  %shl210 = shl i32 %131, 5
  %132 = load i32, ptr %e, align 4
  %shr211 = lshr i32 %132, 27
  %or212 = or i32 %shl210, %shr211
  %133 = load i32, ptr %a, align 4
  %134 = load i32, ptr %b, align 4
  %and213 = and i32 %133, %134
  %135 = load i32, ptr %a, align 4
  %not214 = xor i32 %135, -1
  %136 = load i32, ptr %c, align 4
  %and215 = and i32 %not214, %136
  %or216 = or i32 %and213, %and215
  %add217 = add i32 %or212, %or216
  %add218 = add i32 %add217, 1518500249
  %w219 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx220 = getelementptr inbounds [80 x i32], ptr %w219, i64 0, i64 11
  %137 = load i32, ptr %arrayidx220, align 4
  %add221 = add i32 %add218, %137
  %138 = load i32, ptr %d, align 4
  %add222 = add i32 %138, %add221
  store i32 %add222, ptr %d, align 4
  %139 = load i32, ptr %a, align 4
  %shl223 = shl i32 %139, 30
  %140 = load i32, ptr %a, align 4
  %shr224 = lshr i32 %140, 2
  %or225 = or i32 %shl223, %shr224
  store i32 %or225, ptr %a, align 4
  %141 = load i32, ptr %d, align 4
  %shl226 = shl i32 %141, 5
  %142 = load i32, ptr %d, align 4
  %shr227 = lshr i32 %142, 27
  %or228 = or i32 %shl226, %shr227
  %143 = load i32, ptr %e, align 4
  %144 = load i32, ptr %a, align 4
  %and229 = and i32 %143, %144
  %145 = load i32, ptr %e, align 4
  %not230 = xor i32 %145, -1
  %146 = load i32, ptr %b, align 4
  %and231 = and i32 %not230, %146
  %or232 = or i32 %and229, %and231
  %add233 = add i32 %or228, %or232
  %add234 = add i32 %add233, 1518500249
  %w235 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx236 = getelementptr inbounds [80 x i32], ptr %w235, i64 0, i64 12
  %147 = load i32, ptr %arrayidx236, align 4
  %add237 = add i32 %add234, %147
  %148 = load i32, ptr %c, align 4
  %add238 = add i32 %148, %add237
  store i32 %add238, ptr %c, align 4
  %149 = load i32, ptr %e, align 4
  %shl239 = shl i32 %149, 30
  %150 = load i32, ptr %e, align 4
  %shr240 = lshr i32 %150, 2
  %or241 = or i32 %shl239, %shr240
  store i32 %or241, ptr %e, align 4
  %151 = load i32, ptr %c, align 4
  %shl242 = shl i32 %151, 5
  %152 = load i32, ptr %c, align 4
  %shr243 = lshr i32 %152, 27
  %or244 = or i32 %shl242, %shr243
  %153 = load i32, ptr %d, align 4
  %154 = load i32, ptr %e, align 4
  %and245 = and i32 %153, %154
  %155 = load i32, ptr %d, align 4
  %not246 = xor i32 %155, -1
  %156 = load i32, ptr %a, align 4
  %and247 = and i32 %not246, %156
  %or248 = or i32 %and245, %and247
  %add249 = add i32 %or244, %or248
  %add250 = add i32 %add249, 1518500249
  %w251 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx252 = getelementptr inbounds [80 x i32], ptr %w251, i64 0, i64 13
  %157 = load i32, ptr %arrayidx252, align 4
  %add253 = add i32 %add250, %157
  %158 = load i32, ptr %b, align 4
  %add254 = add i32 %158, %add253
  store i32 %add254, ptr %b, align 4
  %159 = load i32, ptr %d, align 4
  %shl255 = shl i32 %159, 30
  %160 = load i32, ptr %d, align 4
  %shr256 = lshr i32 %160, 2
  %or257 = or i32 %shl255, %shr256
  store i32 %or257, ptr %d, align 4
  %161 = load i32, ptr %b, align 4
  %shl258 = shl i32 %161, 5
  %162 = load i32, ptr %b, align 4
  %shr259 = lshr i32 %162, 27
  %or260 = or i32 %shl258, %shr259
  %163 = load i32, ptr %c, align 4
  %164 = load i32, ptr %d, align 4
  %and261 = and i32 %163, %164
  %165 = load i32, ptr %c, align 4
  %not262 = xor i32 %165, -1
  %166 = load i32, ptr %e, align 4
  %and263 = and i32 %not262, %166
  %or264 = or i32 %and261, %and263
  %add265 = add i32 %or260, %or264
  %add266 = add i32 %add265, 1518500249
  %w267 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx268 = getelementptr inbounds [80 x i32], ptr %w267, i64 0, i64 14
  %167 = load i32, ptr %arrayidx268, align 4
  %add269 = add i32 %add266, %167
  %168 = load i32, ptr %a, align 4
  %add270 = add i32 %168, %add269
  store i32 %add270, ptr %a, align 4
  %169 = load i32, ptr %c, align 4
  %shl271 = shl i32 %169, 30
  %170 = load i32, ptr %c, align 4
  %shr272 = lshr i32 %170, 2
  %or273 = or i32 %shl271, %shr272
  store i32 %or273, ptr %c, align 4
  %171 = load i32, ptr %a, align 4
  %shl274 = shl i32 %171, 5
  %172 = load i32, ptr %a, align 4
  %shr275 = lshr i32 %172, 27
  %or276 = or i32 %shl274, %shr275
  %173 = load i32, ptr %b, align 4
  %174 = load i32, ptr %c, align 4
  %and277 = and i32 %173, %174
  %175 = load i32, ptr %b, align 4
  %not278 = xor i32 %175, -1
  %176 = load i32, ptr %d, align 4
  %and279 = and i32 %not278, %176
  %or280 = or i32 %and277, %and279
  %add281 = add i32 %or276, %or280
  %add282 = add i32 %add281, 1518500249
  %w283 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx284 = getelementptr inbounds [80 x i32], ptr %w283, i64 0, i64 15
  %177 = load i32, ptr %arrayidx284, align 4
  %add285 = add i32 %add282, %177
  %178 = load i32, ptr %e, align 4
  %add286 = add i32 %178, %add285
  store i32 %add286, ptr %e, align 4
  %179 = load i32, ptr %b, align 4
  %shl287 = shl i32 %179, 30
  %180 = load i32, ptr %b, align 4
  %shr288 = lshr i32 %180, 2
  %or289 = or i32 %shl287, %shr288
  store i32 %or289, ptr %b, align 4
  %181 = load i32, ptr %e, align 4
  %shl290 = shl i32 %181, 5
  %182 = load i32, ptr %e, align 4
  %shr291 = lshr i32 %182, 27
  %or292 = or i32 %shl290, %shr291
  %183 = load i32, ptr %a, align 4
  %184 = load i32, ptr %b, align 4
  %and293 = and i32 %183, %184
  %185 = load i32, ptr %a, align 4
  %not294 = xor i32 %185, -1
  %186 = load i32, ptr %c, align 4
  %and295 = and i32 %not294, %186
  %or296 = or i32 %and293, %and295
  %add297 = add i32 %or292, %or296
  %add298 = add i32 %add297, 1518500249
  %w299 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx300 = getelementptr inbounds [80 x i32], ptr %w299, i64 0, i64 16
  %187 = load i32, ptr %arrayidx300, align 4
  %add301 = add i32 %add298, %187
  %188 = load i32, ptr %d, align 4
  %add302 = add i32 %188, %add301
  store i32 %add302, ptr %d, align 4
  %189 = load i32, ptr %a, align 4
  %shl303 = shl i32 %189, 30
  %190 = load i32, ptr %a, align 4
  %shr304 = lshr i32 %190, 2
  %or305 = or i32 %shl303, %shr304
  store i32 %or305, ptr %a, align 4
  %191 = load i32, ptr %d, align 4
  %shl306 = shl i32 %191, 5
  %192 = load i32, ptr %d, align 4
  %shr307 = lshr i32 %192, 27
  %or308 = or i32 %shl306, %shr307
  %193 = load i32, ptr %e, align 4
  %194 = load i32, ptr %a, align 4
  %and309 = and i32 %193, %194
  %195 = load i32, ptr %e, align 4
  %not310 = xor i32 %195, -1
  %196 = load i32, ptr %b, align 4
  %and311 = and i32 %not310, %196
  %or312 = or i32 %and309, %and311
  %add313 = add i32 %or308, %or312
  %add314 = add i32 %add313, 1518500249
  %w315 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx316 = getelementptr inbounds [80 x i32], ptr %w315, i64 0, i64 17
  %197 = load i32, ptr %arrayidx316, align 4
  %add317 = add i32 %add314, %197
  %198 = load i32, ptr %c, align 4
  %add318 = add i32 %198, %add317
  store i32 %add318, ptr %c, align 4
  %199 = load i32, ptr %e, align 4
  %shl319 = shl i32 %199, 30
  %200 = load i32, ptr %e, align 4
  %shr320 = lshr i32 %200, 2
  %or321 = or i32 %shl319, %shr320
  store i32 %or321, ptr %e, align 4
  %201 = load i32, ptr %c, align 4
  %shl322 = shl i32 %201, 5
  %202 = load i32, ptr %c, align 4
  %shr323 = lshr i32 %202, 27
  %or324 = or i32 %shl322, %shr323
  %203 = load i32, ptr %d, align 4
  %204 = load i32, ptr %e, align 4
  %and325 = and i32 %203, %204
  %205 = load i32, ptr %d, align 4
  %not326 = xor i32 %205, -1
  %206 = load i32, ptr %a, align 4
  %and327 = and i32 %not326, %206
  %or328 = or i32 %and325, %and327
  %add329 = add i32 %or324, %or328
  %add330 = add i32 %add329, 1518500249
  %w331 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx332 = getelementptr inbounds [80 x i32], ptr %w331, i64 0, i64 18
  %207 = load i32, ptr %arrayidx332, align 4
  %add333 = add i32 %add330, %207
  %208 = load i32, ptr %b, align 4
  %add334 = add i32 %208, %add333
  store i32 %add334, ptr %b, align 4
  %209 = load i32, ptr %d, align 4
  %shl335 = shl i32 %209, 30
  %210 = load i32, ptr %d, align 4
  %shr336 = lshr i32 %210, 2
  %or337 = or i32 %shl335, %shr336
  store i32 %or337, ptr %d, align 4
  %211 = load i32, ptr %b, align 4
  %shl338 = shl i32 %211, 5
  %212 = load i32, ptr %b, align 4
  %shr339 = lshr i32 %212, 27
  %or340 = or i32 %shl338, %shr339
  %213 = load i32, ptr %c, align 4
  %214 = load i32, ptr %d, align 4
  %and341 = and i32 %213, %214
  %215 = load i32, ptr %c, align 4
  %not342 = xor i32 %215, -1
  %216 = load i32, ptr %e, align 4
  %and343 = and i32 %not342, %216
  %or344 = or i32 %and341, %and343
  %add345 = add i32 %or340, %or344
  %add346 = add i32 %add345, 1518500249
  %w347 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx348 = getelementptr inbounds [80 x i32], ptr %w347, i64 0, i64 19
  %217 = load i32, ptr %arrayidx348, align 4
  %add349 = add i32 %add346, %217
  %218 = load i32, ptr %a, align 4
  %add350 = add i32 %218, %add349
  store i32 %add350, ptr %a, align 4
  %219 = load i32, ptr %c, align 4
  %shl351 = shl i32 %219, 30
  %220 = load i32, ptr %c, align 4
  %shr352 = lshr i32 %220, 2
  %or353 = or i32 %shl351, %shr352
  store i32 %or353, ptr %c, align 4
  %221 = load i32, ptr %a, align 4
  %shl354 = shl i32 %221, 5
  %222 = load i32, ptr %a, align 4
  %shr355 = lshr i32 %222, 27
  %or356 = or i32 %shl354, %shr355
  %223 = load i32, ptr %b, align 4
  %224 = load i32, ptr %c, align 4
  %xor357 = xor i32 %223, %224
  %225 = load i32, ptr %d, align 4
  %xor358 = xor i32 %xor357, %225
  %add359 = add i32 %or356, %xor358
  %add360 = add i32 %add359, 1859775393
  %w361 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx362 = getelementptr inbounds [80 x i32], ptr %w361, i64 0, i64 20
  %226 = load i32, ptr %arrayidx362, align 4
  %add363 = add i32 %add360, %226
  %227 = load i32, ptr %e, align 4
  %add364 = add i32 %227, %add363
  store i32 %add364, ptr %e, align 4
  %228 = load i32, ptr %b, align 4
  %shl365 = shl i32 %228, 30
  %229 = load i32, ptr %b, align 4
  %shr366 = lshr i32 %229, 2
  %or367 = or i32 %shl365, %shr366
  store i32 %or367, ptr %b, align 4
  %230 = load i32, ptr %e, align 4
  %shl368 = shl i32 %230, 5
  %231 = load i32, ptr %e, align 4
  %shr369 = lshr i32 %231, 27
  %or370 = or i32 %shl368, %shr369
  %232 = load i32, ptr %a, align 4
  %233 = load i32, ptr %b, align 4
  %xor371 = xor i32 %232, %233
  %234 = load i32, ptr %c, align 4
  %xor372 = xor i32 %xor371, %234
  %add373 = add i32 %or370, %xor372
  %add374 = add i32 %add373, 1859775393
  %w375 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx376 = getelementptr inbounds [80 x i32], ptr %w375, i64 0, i64 21
  %235 = load i32, ptr %arrayidx376, align 4
  %add377 = add i32 %add374, %235
  %236 = load i32, ptr %d, align 4
  %add378 = add i32 %236, %add377
  store i32 %add378, ptr %d, align 4
  %237 = load i32, ptr %a, align 4
  %shl379 = shl i32 %237, 30
  %238 = load i32, ptr %a, align 4
  %shr380 = lshr i32 %238, 2
  %or381 = or i32 %shl379, %shr380
  store i32 %or381, ptr %a, align 4
  %239 = load i32, ptr %d, align 4
  %shl382 = shl i32 %239, 5
  %240 = load i32, ptr %d, align 4
  %shr383 = lshr i32 %240, 27
  %or384 = or i32 %shl382, %shr383
  %241 = load i32, ptr %e, align 4
  %242 = load i32, ptr %a, align 4
  %xor385 = xor i32 %241, %242
  %243 = load i32, ptr %b, align 4
  %xor386 = xor i32 %xor385, %243
  %add387 = add i32 %or384, %xor386
  %add388 = add i32 %add387, 1859775393
  %w389 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx390 = getelementptr inbounds [80 x i32], ptr %w389, i64 0, i64 22
  %244 = load i32, ptr %arrayidx390, align 4
  %add391 = add i32 %add388, %244
  %245 = load i32, ptr %c, align 4
  %add392 = add i32 %245, %add391
  store i32 %add392, ptr %c, align 4
  %246 = load i32, ptr %e, align 4
  %shl393 = shl i32 %246, 30
  %247 = load i32, ptr %e, align 4
  %shr394 = lshr i32 %247, 2
  %or395 = or i32 %shl393, %shr394
  store i32 %or395, ptr %e, align 4
  %248 = load i32, ptr %c, align 4
  %shl396 = shl i32 %248, 5
  %249 = load i32, ptr %c, align 4
  %shr397 = lshr i32 %249, 27
  %or398 = or i32 %shl396, %shr397
  %250 = load i32, ptr %d, align 4
  %251 = load i32, ptr %e, align 4
  %xor399 = xor i32 %250, %251
  %252 = load i32, ptr %a, align 4
  %xor400 = xor i32 %xor399, %252
  %add401 = add i32 %or398, %xor400
  %add402 = add i32 %add401, 1859775393
  %w403 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx404 = getelementptr inbounds [80 x i32], ptr %w403, i64 0, i64 23
  %253 = load i32, ptr %arrayidx404, align 4
  %add405 = add i32 %add402, %253
  %254 = load i32, ptr %b, align 4
  %add406 = add i32 %254, %add405
  store i32 %add406, ptr %b, align 4
  %255 = load i32, ptr %d, align 4
  %shl407 = shl i32 %255, 30
  %256 = load i32, ptr %d, align 4
  %shr408 = lshr i32 %256, 2
  %or409 = or i32 %shl407, %shr408
  store i32 %or409, ptr %d, align 4
  %257 = load i32, ptr %b, align 4
  %shl410 = shl i32 %257, 5
  %258 = load i32, ptr %b, align 4
  %shr411 = lshr i32 %258, 27
  %or412 = or i32 %shl410, %shr411
  %259 = load i32, ptr %c, align 4
  %260 = load i32, ptr %d, align 4
  %xor413 = xor i32 %259, %260
  %261 = load i32, ptr %e, align 4
  %xor414 = xor i32 %xor413, %261
  %add415 = add i32 %or412, %xor414
  %add416 = add i32 %add415, 1859775393
  %w417 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx418 = getelementptr inbounds [80 x i32], ptr %w417, i64 0, i64 24
  %262 = load i32, ptr %arrayidx418, align 4
  %add419 = add i32 %add416, %262
  %263 = load i32, ptr %a, align 4
  %add420 = add i32 %263, %add419
  store i32 %add420, ptr %a, align 4
  %264 = load i32, ptr %c, align 4
  %shl421 = shl i32 %264, 30
  %265 = load i32, ptr %c, align 4
  %shr422 = lshr i32 %265, 2
  %or423 = or i32 %shl421, %shr422
  store i32 %or423, ptr %c, align 4
  %266 = load i32, ptr %a, align 4
  %shl424 = shl i32 %266, 5
  %267 = load i32, ptr %a, align 4
  %shr425 = lshr i32 %267, 27
  %or426 = or i32 %shl424, %shr425
  %268 = load i32, ptr %b, align 4
  %269 = load i32, ptr %c, align 4
  %xor427 = xor i32 %268, %269
  %270 = load i32, ptr %d, align 4
  %xor428 = xor i32 %xor427, %270
  %add429 = add i32 %or426, %xor428
  %add430 = add i32 %add429, 1859775393
  %w431 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx432 = getelementptr inbounds [80 x i32], ptr %w431, i64 0, i64 25
  %271 = load i32, ptr %arrayidx432, align 4
  %add433 = add i32 %add430, %271
  %272 = load i32, ptr %e, align 4
  %add434 = add i32 %272, %add433
  store i32 %add434, ptr %e, align 4
  %273 = load i32, ptr %b, align 4
  %shl435 = shl i32 %273, 30
  %274 = load i32, ptr %b, align 4
  %shr436 = lshr i32 %274, 2
  %or437 = or i32 %shl435, %shr436
  store i32 %or437, ptr %b, align 4
  %275 = load i32, ptr %e, align 4
  %shl438 = shl i32 %275, 5
  %276 = load i32, ptr %e, align 4
  %shr439 = lshr i32 %276, 27
  %or440 = or i32 %shl438, %shr439
  %277 = load i32, ptr %a, align 4
  %278 = load i32, ptr %b, align 4
  %xor441 = xor i32 %277, %278
  %279 = load i32, ptr %c, align 4
  %xor442 = xor i32 %xor441, %279
  %add443 = add i32 %or440, %xor442
  %add444 = add i32 %add443, 1859775393
  %w445 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx446 = getelementptr inbounds [80 x i32], ptr %w445, i64 0, i64 26
  %280 = load i32, ptr %arrayidx446, align 4
  %add447 = add i32 %add444, %280
  %281 = load i32, ptr %d, align 4
  %add448 = add i32 %281, %add447
  store i32 %add448, ptr %d, align 4
  %282 = load i32, ptr %a, align 4
  %shl449 = shl i32 %282, 30
  %283 = load i32, ptr %a, align 4
  %shr450 = lshr i32 %283, 2
  %or451 = or i32 %shl449, %shr450
  store i32 %or451, ptr %a, align 4
  %284 = load i32, ptr %d, align 4
  %shl452 = shl i32 %284, 5
  %285 = load i32, ptr %d, align 4
  %shr453 = lshr i32 %285, 27
  %or454 = or i32 %shl452, %shr453
  %286 = load i32, ptr %e, align 4
  %287 = load i32, ptr %a, align 4
  %xor455 = xor i32 %286, %287
  %288 = load i32, ptr %b, align 4
  %xor456 = xor i32 %xor455, %288
  %add457 = add i32 %or454, %xor456
  %add458 = add i32 %add457, 1859775393
  %w459 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx460 = getelementptr inbounds [80 x i32], ptr %w459, i64 0, i64 27
  %289 = load i32, ptr %arrayidx460, align 4
  %add461 = add i32 %add458, %289
  %290 = load i32, ptr %c, align 4
  %add462 = add i32 %290, %add461
  store i32 %add462, ptr %c, align 4
  %291 = load i32, ptr %e, align 4
  %shl463 = shl i32 %291, 30
  %292 = load i32, ptr %e, align 4
  %shr464 = lshr i32 %292, 2
  %or465 = or i32 %shl463, %shr464
  store i32 %or465, ptr %e, align 4
  %293 = load i32, ptr %c, align 4
  %shl466 = shl i32 %293, 5
  %294 = load i32, ptr %c, align 4
  %shr467 = lshr i32 %294, 27
  %or468 = or i32 %shl466, %shr467
  %295 = load i32, ptr %d, align 4
  %296 = load i32, ptr %e, align 4
  %xor469 = xor i32 %295, %296
  %297 = load i32, ptr %a, align 4
  %xor470 = xor i32 %xor469, %297
  %add471 = add i32 %or468, %xor470
  %add472 = add i32 %add471, 1859775393
  %w473 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx474 = getelementptr inbounds [80 x i32], ptr %w473, i64 0, i64 28
  %298 = load i32, ptr %arrayidx474, align 4
  %add475 = add i32 %add472, %298
  %299 = load i32, ptr %b, align 4
  %add476 = add i32 %299, %add475
  store i32 %add476, ptr %b, align 4
  %300 = load i32, ptr %d, align 4
  %shl477 = shl i32 %300, 30
  %301 = load i32, ptr %d, align 4
  %shr478 = lshr i32 %301, 2
  %or479 = or i32 %shl477, %shr478
  store i32 %or479, ptr %d, align 4
  %302 = load i32, ptr %b, align 4
  %shl480 = shl i32 %302, 5
  %303 = load i32, ptr %b, align 4
  %shr481 = lshr i32 %303, 27
  %or482 = or i32 %shl480, %shr481
  %304 = load i32, ptr %c, align 4
  %305 = load i32, ptr %d, align 4
  %xor483 = xor i32 %304, %305
  %306 = load i32, ptr %e, align 4
  %xor484 = xor i32 %xor483, %306
  %add485 = add i32 %or482, %xor484
  %add486 = add i32 %add485, 1859775393
  %w487 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx488 = getelementptr inbounds [80 x i32], ptr %w487, i64 0, i64 29
  %307 = load i32, ptr %arrayidx488, align 4
  %add489 = add i32 %add486, %307
  %308 = load i32, ptr %a, align 4
  %add490 = add i32 %308, %add489
  store i32 %add490, ptr %a, align 4
  %309 = load i32, ptr %c, align 4
  %shl491 = shl i32 %309, 30
  %310 = load i32, ptr %c, align 4
  %shr492 = lshr i32 %310, 2
  %or493 = or i32 %shl491, %shr492
  store i32 %or493, ptr %c, align 4
  %311 = load i32, ptr %a, align 4
  %shl494 = shl i32 %311, 5
  %312 = load i32, ptr %a, align 4
  %shr495 = lshr i32 %312, 27
  %or496 = or i32 %shl494, %shr495
  %313 = load i32, ptr %b, align 4
  %314 = load i32, ptr %c, align 4
  %xor497 = xor i32 %313, %314
  %315 = load i32, ptr %d, align 4
  %xor498 = xor i32 %xor497, %315
  %add499 = add i32 %or496, %xor498
  %add500 = add i32 %add499, 1859775393
  %w501 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx502 = getelementptr inbounds [80 x i32], ptr %w501, i64 0, i64 30
  %316 = load i32, ptr %arrayidx502, align 4
  %add503 = add i32 %add500, %316
  %317 = load i32, ptr %e, align 4
  %add504 = add i32 %317, %add503
  store i32 %add504, ptr %e, align 4
  %318 = load i32, ptr %b, align 4
  %shl505 = shl i32 %318, 30
  %319 = load i32, ptr %b, align 4
  %shr506 = lshr i32 %319, 2
  %or507 = or i32 %shl505, %shr506
  store i32 %or507, ptr %b, align 4
  %320 = load i32, ptr %e, align 4
  %shl508 = shl i32 %320, 5
  %321 = load i32, ptr %e, align 4
  %shr509 = lshr i32 %321, 27
  %or510 = or i32 %shl508, %shr509
  %322 = load i32, ptr %a, align 4
  %323 = load i32, ptr %b, align 4
  %xor511 = xor i32 %322, %323
  %324 = load i32, ptr %c, align 4
  %xor512 = xor i32 %xor511, %324
  %add513 = add i32 %or510, %xor512
  %add514 = add i32 %add513, 1859775393
  %w515 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx516 = getelementptr inbounds [80 x i32], ptr %w515, i64 0, i64 31
  %325 = load i32, ptr %arrayidx516, align 4
  %add517 = add i32 %add514, %325
  %326 = load i32, ptr %d, align 4
  %add518 = add i32 %326, %add517
  store i32 %add518, ptr %d, align 4
  %327 = load i32, ptr %a, align 4
  %shl519 = shl i32 %327, 30
  %328 = load i32, ptr %a, align 4
  %shr520 = lshr i32 %328, 2
  %or521 = or i32 %shl519, %shr520
  store i32 %or521, ptr %a, align 4
  %329 = load i32, ptr %d, align 4
  %shl522 = shl i32 %329, 5
  %330 = load i32, ptr %d, align 4
  %shr523 = lshr i32 %330, 27
  %or524 = or i32 %shl522, %shr523
  %331 = load i32, ptr %e, align 4
  %332 = load i32, ptr %a, align 4
  %xor525 = xor i32 %331, %332
  %333 = load i32, ptr %b, align 4
  %xor526 = xor i32 %xor525, %333
  %add527 = add i32 %or524, %xor526
  %add528 = add i32 %add527, 1859775393
  %w529 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx530 = getelementptr inbounds [80 x i32], ptr %w529, i64 0, i64 32
  %334 = load i32, ptr %arrayidx530, align 4
  %add531 = add i32 %add528, %334
  %335 = load i32, ptr %c, align 4
  %add532 = add i32 %335, %add531
  store i32 %add532, ptr %c, align 4
  %336 = load i32, ptr %e, align 4
  %shl533 = shl i32 %336, 30
  %337 = load i32, ptr %e, align 4
  %shr534 = lshr i32 %337, 2
  %or535 = or i32 %shl533, %shr534
  store i32 %or535, ptr %e, align 4
  %338 = load i32, ptr %c, align 4
  %shl536 = shl i32 %338, 5
  %339 = load i32, ptr %c, align 4
  %shr537 = lshr i32 %339, 27
  %or538 = or i32 %shl536, %shr537
  %340 = load i32, ptr %d, align 4
  %341 = load i32, ptr %e, align 4
  %xor539 = xor i32 %340, %341
  %342 = load i32, ptr %a, align 4
  %xor540 = xor i32 %xor539, %342
  %add541 = add i32 %or538, %xor540
  %add542 = add i32 %add541, 1859775393
  %w543 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx544 = getelementptr inbounds [80 x i32], ptr %w543, i64 0, i64 33
  %343 = load i32, ptr %arrayidx544, align 4
  %add545 = add i32 %add542, %343
  %344 = load i32, ptr %b, align 4
  %add546 = add i32 %344, %add545
  store i32 %add546, ptr %b, align 4
  %345 = load i32, ptr %d, align 4
  %shl547 = shl i32 %345, 30
  %346 = load i32, ptr %d, align 4
  %shr548 = lshr i32 %346, 2
  %or549 = or i32 %shl547, %shr548
  store i32 %or549, ptr %d, align 4
  %347 = load i32, ptr %b, align 4
  %shl550 = shl i32 %347, 5
  %348 = load i32, ptr %b, align 4
  %shr551 = lshr i32 %348, 27
  %or552 = or i32 %shl550, %shr551
  %349 = load i32, ptr %c, align 4
  %350 = load i32, ptr %d, align 4
  %xor553 = xor i32 %349, %350
  %351 = load i32, ptr %e, align 4
  %xor554 = xor i32 %xor553, %351
  %add555 = add i32 %or552, %xor554
  %add556 = add i32 %add555, 1859775393
  %w557 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx558 = getelementptr inbounds [80 x i32], ptr %w557, i64 0, i64 34
  %352 = load i32, ptr %arrayidx558, align 4
  %add559 = add i32 %add556, %352
  %353 = load i32, ptr %a, align 4
  %add560 = add i32 %353, %add559
  store i32 %add560, ptr %a, align 4
  %354 = load i32, ptr %c, align 4
  %shl561 = shl i32 %354, 30
  %355 = load i32, ptr %c, align 4
  %shr562 = lshr i32 %355, 2
  %or563 = or i32 %shl561, %shr562
  store i32 %or563, ptr %c, align 4
  %356 = load i32, ptr %a, align 4
  %shl564 = shl i32 %356, 5
  %357 = load i32, ptr %a, align 4
  %shr565 = lshr i32 %357, 27
  %or566 = or i32 %shl564, %shr565
  %358 = load i32, ptr %b, align 4
  %359 = load i32, ptr %c, align 4
  %xor567 = xor i32 %358, %359
  %360 = load i32, ptr %d, align 4
  %xor568 = xor i32 %xor567, %360
  %add569 = add i32 %or566, %xor568
  %add570 = add i32 %add569, 1859775393
  %w571 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx572 = getelementptr inbounds [80 x i32], ptr %w571, i64 0, i64 35
  %361 = load i32, ptr %arrayidx572, align 4
  %add573 = add i32 %add570, %361
  %362 = load i32, ptr %e, align 4
  %add574 = add i32 %362, %add573
  store i32 %add574, ptr %e, align 4
  %363 = load i32, ptr %b, align 4
  %shl575 = shl i32 %363, 30
  %364 = load i32, ptr %b, align 4
  %shr576 = lshr i32 %364, 2
  %or577 = or i32 %shl575, %shr576
  store i32 %or577, ptr %b, align 4
  %365 = load i32, ptr %e, align 4
  %shl578 = shl i32 %365, 5
  %366 = load i32, ptr %e, align 4
  %shr579 = lshr i32 %366, 27
  %or580 = or i32 %shl578, %shr579
  %367 = load i32, ptr %a, align 4
  %368 = load i32, ptr %b, align 4
  %xor581 = xor i32 %367, %368
  %369 = load i32, ptr %c, align 4
  %xor582 = xor i32 %xor581, %369
  %add583 = add i32 %or580, %xor582
  %add584 = add i32 %add583, 1859775393
  %w585 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx586 = getelementptr inbounds [80 x i32], ptr %w585, i64 0, i64 36
  %370 = load i32, ptr %arrayidx586, align 4
  %add587 = add i32 %add584, %370
  %371 = load i32, ptr %d, align 4
  %add588 = add i32 %371, %add587
  store i32 %add588, ptr %d, align 4
  %372 = load i32, ptr %a, align 4
  %shl589 = shl i32 %372, 30
  %373 = load i32, ptr %a, align 4
  %shr590 = lshr i32 %373, 2
  %or591 = or i32 %shl589, %shr590
  store i32 %or591, ptr %a, align 4
  %374 = load i32, ptr %d, align 4
  %shl592 = shl i32 %374, 5
  %375 = load i32, ptr %d, align 4
  %shr593 = lshr i32 %375, 27
  %or594 = or i32 %shl592, %shr593
  %376 = load i32, ptr %e, align 4
  %377 = load i32, ptr %a, align 4
  %xor595 = xor i32 %376, %377
  %378 = load i32, ptr %b, align 4
  %xor596 = xor i32 %xor595, %378
  %add597 = add i32 %or594, %xor596
  %add598 = add i32 %add597, 1859775393
  %w599 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx600 = getelementptr inbounds [80 x i32], ptr %w599, i64 0, i64 37
  %379 = load i32, ptr %arrayidx600, align 4
  %add601 = add i32 %add598, %379
  %380 = load i32, ptr %c, align 4
  %add602 = add i32 %380, %add601
  store i32 %add602, ptr %c, align 4
  %381 = load i32, ptr %e, align 4
  %shl603 = shl i32 %381, 30
  %382 = load i32, ptr %e, align 4
  %shr604 = lshr i32 %382, 2
  %or605 = or i32 %shl603, %shr604
  store i32 %or605, ptr %e, align 4
  %383 = load i32, ptr %c, align 4
  %shl606 = shl i32 %383, 5
  %384 = load i32, ptr %c, align 4
  %shr607 = lshr i32 %384, 27
  %or608 = or i32 %shl606, %shr607
  %385 = load i32, ptr %d, align 4
  %386 = load i32, ptr %e, align 4
  %xor609 = xor i32 %385, %386
  %387 = load i32, ptr %a, align 4
  %xor610 = xor i32 %xor609, %387
  %add611 = add i32 %or608, %xor610
  %add612 = add i32 %add611, 1859775393
  %w613 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx614 = getelementptr inbounds [80 x i32], ptr %w613, i64 0, i64 38
  %388 = load i32, ptr %arrayidx614, align 4
  %add615 = add i32 %add612, %388
  %389 = load i32, ptr %b, align 4
  %add616 = add i32 %389, %add615
  store i32 %add616, ptr %b, align 4
  %390 = load i32, ptr %d, align 4
  %shl617 = shl i32 %390, 30
  %391 = load i32, ptr %d, align 4
  %shr618 = lshr i32 %391, 2
  %or619 = or i32 %shl617, %shr618
  store i32 %or619, ptr %d, align 4
  %392 = load i32, ptr %b, align 4
  %shl620 = shl i32 %392, 5
  %393 = load i32, ptr %b, align 4
  %shr621 = lshr i32 %393, 27
  %or622 = or i32 %shl620, %shr621
  %394 = load i32, ptr %c, align 4
  %395 = load i32, ptr %d, align 4
  %xor623 = xor i32 %394, %395
  %396 = load i32, ptr %e, align 4
  %xor624 = xor i32 %xor623, %396
  %add625 = add i32 %or622, %xor624
  %add626 = add i32 %add625, 1859775393
  %w627 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx628 = getelementptr inbounds [80 x i32], ptr %w627, i64 0, i64 39
  %397 = load i32, ptr %arrayidx628, align 4
  %add629 = add i32 %add626, %397
  %398 = load i32, ptr %a, align 4
  %add630 = add i32 %398, %add629
  store i32 %add630, ptr %a, align 4
  %399 = load i32, ptr %c, align 4
  %shl631 = shl i32 %399, 30
  %400 = load i32, ptr %c, align 4
  %shr632 = lshr i32 %400, 2
  %or633 = or i32 %shl631, %shr632
  store i32 %or633, ptr %c, align 4
  %401 = load i32, ptr %a, align 4
  %shl634 = shl i32 %401, 5
  %402 = load i32, ptr %a, align 4
  %shr635 = lshr i32 %402, 27
  %or636 = or i32 %shl634, %shr635
  %403 = load i32, ptr %b, align 4
  %404 = load i32, ptr %c, align 4
  %and637 = and i32 %403, %404
  %405 = load i32, ptr %b, align 4
  %406 = load i32, ptr %d, align 4
  %and638 = and i32 %405, %406
  %or639 = or i32 %and637, %and638
  %407 = load i32, ptr %c, align 4
  %408 = load i32, ptr %d, align 4
  %and640 = and i32 %407, %408
  %or641 = or i32 %or639, %and640
  %add642 = add i32 %or636, %or641
  %add643 = add i32 %add642, -1894007588
  %w644 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx645 = getelementptr inbounds [80 x i32], ptr %w644, i64 0, i64 40
  %409 = load i32, ptr %arrayidx645, align 4
  %add646 = add i32 %add643, %409
  %410 = load i32, ptr %e, align 4
  %add647 = add i32 %410, %add646
  store i32 %add647, ptr %e, align 4
  %411 = load i32, ptr %b, align 4
  %shl648 = shl i32 %411, 30
  %412 = load i32, ptr %b, align 4
  %shr649 = lshr i32 %412, 2
  %or650 = or i32 %shl648, %shr649
  store i32 %or650, ptr %b, align 4
  %413 = load i32, ptr %e, align 4
  %shl651 = shl i32 %413, 5
  %414 = load i32, ptr %e, align 4
  %shr652 = lshr i32 %414, 27
  %or653 = or i32 %shl651, %shr652
  %415 = load i32, ptr %a, align 4
  %416 = load i32, ptr %b, align 4
  %and654 = and i32 %415, %416
  %417 = load i32, ptr %a, align 4
  %418 = load i32, ptr %c, align 4
  %and655 = and i32 %417, %418
  %or656 = or i32 %and654, %and655
  %419 = load i32, ptr %b, align 4
  %420 = load i32, ptr %c, align 4
  %and657 = and i32 %419, %420
  %or658 = or i32 %or656, %and657
  %add659 = add i32 %or653, %or658
  %add660 = add i32 %add659, -1894007588
  %w661 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx662 = getelementptr inbounds [80 x i32], ptr %w661, i64 0, i64 41
  %421 = load i32, ptr %arrayidx662, align 4
  %add663 = add i32 %add660, %421
  %422 = load i32, ptr %d, align 4
  %add664 = add i32 %422, %add663
  store i32 %add664, ptr %d, align 4
  %423 = load i32, ptr %a, align 4
  %shl665 = shl i32 %423, 30
  %424 = load i32, ptr %a, align 4
  %shr666 = lshr i32 %424, 2
  %or667 = or i32 %shl665, %shr666
  store i32 %or667, ptr %a, align 4
  %425 = load i32, ptr %d, align 4
  %shl668 = shl i32 %425, 5
  %426 = load i32, ptr %d, align 4
  %shr669 = lshr i32 %426, 27
  %or670 = or i32 %shl668, %shr669
  %427 = load i32, ptr %e, align 4
  %428 = load i32, ptr %a, align 4
  %and671 = and i32 %427, %428
  %429 = load i32, ptr %e, align 4
  %430 = load i32, ptr %b, align 4
  %and672 = and i32 %429, %430
  %or673 = or i32 %and671, %and672
  %431 = load i32, ptr %a, align 4
  %432 = load i32, ptr %b, align 4
  %and674 = and i32 %431, %432
  %or675 = or i32 %or673, %and674
  %add676 = add i32 %or670, %or675
  %add677 = add i32 %add676, -1894007588
  %w678 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx679 = getelementptr inbounds [80 x i32], ptr %w678, i64 0, i64 42
  %433 = load i32, ptr %arrayidx679, align 4
  %add680 = add i32 %add677, %433
  %434 = load i32, ptr %c, align 4
  %add681 = add i32 %434, %add680
  store i32 %add681, ptr %c, align 4
  %435 = load i32, ptr %e, align 4
  %shl682 = shl i32 %435, 30
  %436 = load i32, ptr %e, align 4
  %shr683 = lshr i32 %436, 2
  %or684 = or i32 %shl682, %shr683
  store i32 %or684, ptr %e, align 4
  %437 = load i32, ptr %c, align 4
  %shl685 = shl i32 %437, 5
  %438 = load i32, ptr %c, align 4
  %shr686 = lshr i32 %438, 27
  %or687 = or i32 %shl685, %shr686
  %439 = load i32, ptr %d, align 4
  %440 = load i32, ptr %e, align 4
  %and688 = and i32 %439, %440
  %441 = load i32, ptr %d, align 4
  %442 = load i32, ptr %a, align 4
  %and689 = and i32 %441, %442
  %or690 = or i32 %and688, %and689
  %443 = load i32, ptr %e, align 4
  %444 = load i32, ptr %a, align 4
  %and691 = and i32 %443, %444
  %or692 = or i32 %or690, %and691
  %add693 = add i32 %or687, %or692
  %add694 = add i32 %add693, -1894007588
  %w695 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx696 = getelementptr inbounds [80 x i32], ptr %w695, i64 0, i64 43
  %445 = load i32, ptr %arrayidx696, align 4
  %add697 = add i32 %add694, %445
  %446 = load i32, ptr %b, align 4
  %add698 = add i32 %446, %add697
  store i32 %add698, ptr %b, align 4
  %447 = load i32, ptr %d, align 4
  %shl699 = shl i32 %447, 30
  %448 = load i32, ptr %d, align 4
  %shr700 = lshr i32 %448, 2
  %or701 = or i32 %shl699, %shr700
  store i32 %or701, ptr %d, align 4
  %449 = load i32, ptr %b, align 4
  %shl702 = shl i32 %449, 5
  %450 = load i32, ptr %b, align 4
  %shr703 = lshr i32 %450, 27
  %or704 = or i32 %shl702, %shr703
  %451 = load i32, ptr %c, align 4
  %452 = load i32, ptr %d, align 4
  %and705 = and i32 %451, %452
  %453 = load i32, ptr %c, align 4
  %454 = load i32, ptr %e, align 4
  %and706 = and i32 %453, %454
  %or707 = or i32 %and705, %and706
  %455 = load i32, ptr %d, align 4
  %456 = load i32, ptr %e, align 4
  %and708 = and i32 %455, %456
  %or709 = or i32 %or707, %and708
  %add710 = add i32 %or704, %or709
  %add711 = add i32 %add710, -1894007588
  %w712 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx713 = getelementptr inbounds [80 x i32], ptr %w712, i64 0, i64 44
  %457 = load i32, ptr %arrayidx713, align 4
  %add714 = add i32 %add711, %457
  %458 = load i32, ptr %a, align 4
  %add715 = add i32 %458, %add714
  store i32 %add715, ptr %a, align 4
  %459 = load i32, ptr %c, align 4
  %shl716 = shl i32 %459, 30
  %460 = load i32, ptr %c, align 4
  %shr717 = lshr i32 %460, 2
  %or718 = or i32 %shl716, %shr717
  store i32 %or718, ptr %c, align 4
  %461 = load i32, ptr %a, align 4
  %shl719 = shl i32 %461, 5
  %462 = load i32, ptr %a, align 4
  %shr720 = lshr i32 %462, 27
  %or721 = or i32 %shl719, %shr720
  %463 = load i32, ptr %b, align 4
  %464 = load i32, ptr %c, align 4
  %and722 = and i32 %463, %464
  %465 = load i32, ptr %b, align 4
  %466 = load i32, ptr %d, align 4
  %and723 = and i32 %465, %466
  %or724 = or i32 %and722, %and723
  %467 = load i32, ptr %c, align 4
  %468 = load i32, ptr %d, align 4
  %and725 = and i32 %467, %468
  %or726 = or i32 %or724, %and725
  %add727 = add i32 %or721, %or726
  %add728 = add i32 %add727, -1894007588
  %w729 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx730 = getelementptr inbounds [80 x i32], ptr %w729, i64 0, i64 45
  %469 = load i32, ptr %arrayidx730, align 4
  %add731 = add i32 %add728, %469
  %470 = load i32, ptr %e, align 4
  %add732 = add i32 %470, %add731
  store i32 %add732, ptr %e, align 4
  %471 = load i32, ptr %b, align 4
  %shl733 = shl i32 %471, 30
  %472 = load i32, ptr %b, align 4
  %shr734 = lshr i32 %472, 2
  %or735 = or i32 %shl733, %shr734
  store i32 %or735, ptr %b, align 4
  %473 = load i32, ptr %e, align 4
  %shl736 = shl i32 %473, 5
  %474 = load i32, ptr %e, align 4
  %shr737 = lshr i32 %474, 27
  %or738 = or i32 %shl736, %shr737
  %475 = load i32, ptr %a, align 4
  %476 = load i32, ptr %b, align 4
  %and739 = and i32 %475, %476
  %477 = load i32, ptr %a, align 4
  %478 = load i32, ptr %c, align 4
  %and740 = and i32 %477, %478
  %or741 = or i32 %and739, %and740
  %479 = load i32, ptr %b, align 4
  %480 = load i32, ptr %c, align 4
  %and742 = and i32 %479, %480
  %or743 = or i32 %or741, %and742
  %add744 = add i32 %or738, %or743
  %add745 = add i32 %add744, -1894007588
  %w746 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx747 = getelementptr inbounds [80 x i32], ptr %w746, i64 0, i64 46
  %481 = load i32, ptr %arrayidx747, align 4
  %add748 = add i32 %add745, %481
  %482 = load i32, ptr %d, align 4
  %add749 = add i32 %482, %add748
  store i32 %add749, ptr %d, align 4
  %483 = load i32, ptr %a, align 4
  %shl750 = shl i32 %483, 30
  %484 = load i32, ptr %a, align 4
  %shr751 = lshr i32 %484, 2
  %or752 = or i32 %shl750, %shr751
  store i32 %or752, ptr %a, align 4
  %485 = load i32, ptr %d, align 4
  %shl753 = shl i32 %485, 5
  %486 = load i32, ptr %d, align 4
  %shr754 = lshr i32 %486, 27
  %or755 = or i32 %shl753, %shr754
  %487 = load i32, ptr %e, align 4
  %488 = load i32, ptr %a, align 4
  %and756 = and i32 %487, %488
  %489 = load i32, ptr %e, align 4
  %490 = load i32, ptr %b, align 4
  %and757 = and i32 %489, %490
  %or758 = or i32 %and756, %and757
  %491 = load i32, ptr %a, align 4
  %492 = load i32, ptr %b, align 4
  %and759 = and i32 %491, %492
  %or760 = or i32 %or758, %and759
  %add761 = add i32 %or755, %or760
  %add762 = add i32 %add761, -1894007588
  %w763 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx764 = getelementptr inbounds [80 x i32], ptr %w763, i64 0, i64 47
  %493 = load i32, ptr %arrayidx764, align 4
  %add765 = add i32 %add762, %493
  %494 = load i32, ptr %c, align 4
  %add766 = add i32 %494, %add765
  store i32 %add766, ptr %c, align 4
  %495 = load i32, ptr %e, align 4
  %shl767 = shl i32 %495, 30
  %496 = load i32, ptr %e, align 4
  %shr768 = lshr i32 %496, 2
  %or769 = or i32 %shl767, %shr768
  store i32 %or769, ptr %e, align 4
  %497 = load i32, ptr %c, align 4
  %shl770 = shl i32 %497, 5
  %498 = load i32, ptr %c, align 4
  %shr771 = lshr i32 %498, 27
  %or772 = or i32 %shl770, %shr771
  %499 = load i32, ptr %d, align 4
  %500 = load i32, ptr %e, align 4
  %and773 = and i32 %499, %500
  %501 = load i32, ptr %d, align 4
  %502 = load i32, ptr %a, align 4
  %and774 = and i32 %501, %502
  %or775 = or i32 %and773, %and774
  %503 = load i32, ptr %e, align 4
  %504 = load i32, ptr %a, align 4
  %and776 = and i32 %503, %504
  %or777 = or i32 %or775, %and776
  %add778 = add i32 %or772, %or777
  %add779 = add i32 %add778, -1894007588
  %w780 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx781 = getelementptr inbounds [80 x i32], ptr %w780, i64 0, i64 48
  %505 = load i32, ptr %arrayidx781, align 4
  %add782 = add i32 %add779, %505
  %506 = load i32, ptr %b, align 4
  %add783 = add i32 %506, %add782
  store i32 %add783, ptr %b, align 4
  %507 = load i32, ptr %d, align 4
  %shl784 = shl i32 %507, 30
  %508 = load i32, ptr %d, align 4
  %shr785 = lshr i32 %508, 2
  %or786 = or i32 %shl784, %shr785
  store i32 %or786, ptr %d, align 4
  %509 = load i32, ptr %b, align 4
  %shl787 = shl i32 %509, 5
  %510 = load i32, ptr %b, align 4
  %shr788 = lshr i32 %510, 27
  %or789 = or i32 %shl787, %shr788
  %511 = load i32, ptr %c, align 4
  %512 = load i32, ptr %d, align 4
  %and790 = and i32 %511, %512
  %513 = load i32, ptr %c, align 4
  %514 = load i32, ptr %e, align 4
  %and791 = and i32 %513, %514
  %or792 = or i32 %and790, %and791
  %515 = load i32, ptr %d, align 4
  %516 = load i32, ptr %e, align 4
  %and793 = and i32 %515, %516
  %or794 = or i32 %or792, %and793
  %add795 = add i32 %or789, %or794
  %add796 = add i32 %add795, -1894007588
  %w797 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx798 = getelementptr inbounds [80 x i32], ptr %w797, i64 0, i64 49
  %517 = load i32, ptr %arrayidx798, align 4
  %add799 = add i32 %add796, %517
  %518 = load i32, ptr %a, align 4
  %add800 = add i32 %518, %add799
  store i32 %add800, ptr %a, align 4
  %519 = load i32, ptr %c, align 4
  %shl801 = shl i32 %519, 30
  %520 = load i32, ptr %c, align 4
  %shr802 = lshr i32 %520, 2
  %or803 = or i32 %shl801, %shr802
  store i32 %or803, ptr %c, align 4
  %521 = load i32, ptr %a, align 4
  %shl804 = shl i32 %521, 5
  %522 = load i32, ptr %a, align 4
  %shr805 = lshr i32 %522, 27
  %or806 = or i32 %shl804, %shr805
  %523 = load i32, ptr %b, align 4
  %524 = load i32, ptr %c, align 4
  %and807 = and i32 %523, %524
  %525 = load i32, ptr %b, align 4
  %526 = load i32, ptr %d, align 4
  %and808 = and i32 %525, %526
  %or809 = or i32 %and807, %and808
  %527 = load i32, ptr %c, align 4
  %528 = load i32, ptr %d, align 4
  %and810 = and i32 %527, %528
  %or811 = or i32 %or809, %and810
  %add812 = add i32 %or806, %or811
  %add813 = add i32 %add812, -1894007588
  %w814 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx815 = getelementptr inbounds [80 x i32], ptr %w814, i64 0, i64 50
  %529 = load i32, ptr %arrayidx815, align 4
  %add816 = add i32 %add813, %529
  %530 = load i32, ptr %e, align 4
  %add817 = add i32 %530, %add816
  store i32 %add817, ptr %e, align 4
  %531 = load i32, ptr %b, align 4
  %shl818 = shl i32 %531, 30
  %532 = load i32, ptr %b, align 4
  %shr819 = lshr i32 %532, 2
  %or820 = or i32 %shl818, %shr819
  store i32 %or820, ptr %b, align 4
  %533 = load i32, ptr %e, align 4
  %shl821 = shl i32 %533, 5
  %534 = load i32, ptr %e, align 4
  %shr822 = lshr i32 %534, 27
  %or823 = or i32 %shl821, %shr822
  %535 = load i32, ptr %a, align 4
  %536 = load i32, ptr %b, align 4
  %and824 = and i32 %535, %536
  %537 = load i32, ptr %a, align 4
  %538 = load i32, ptr %c, align 4
  %and825 = and i32 %537, %538
  %or826 = or i32 %and824, %and825
  %539 = load i32, ptr %b, align 4
  %540 = load i32, ptr %c, align 4
  %and827 = and i32 %539, %540
  %or828 = or i32 %or826, %and827
  %add829 = add i32 %or823, %or828
  %add830 = add i32 %add829, -1894007588
  %w831 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx832 = getelementptr inbounds [80 x i32], ptr %w831, i64 0, i64 51
  %541 = load i32, ptr %arrayidx832, align 4
  %add833 = add i32 %add830, %541
  %542 = load i32, ptr %d, align 4
  %add834 = add i32 %542, %add833
  store i32 %add834, ptr %d, align 4
  %543 = load i32, ptr %a, align 4
  %shl835 = shl i32 %543, 30
  %544 = load i32, ptr %a, align 4
  %shr836 = lshr i32 %544, 2
  %or837 = or i32 %shl835, %shr836
  store i32 %or837, ptr %a, align 4
  %545 = load i32, ptr %d, align 4
  %shl838 = shl i32 %545, 5
  %546 = load i32, ptr %d, align 4
  %shr839 = lshr i32 %546, 27
  %or840 = or i32 %shl838, %shr839
  %547 = load i32, ptr %e, align 4
  %548 = load i32, ptr %a, align 4
  %and841 = and i32 %547, %548
  %549 = load i32, ptr %e, align 4
  %550 = load i32, ptr %b, align 4
  %and842 = and i32 %549, %550
  %or843 = or i32 %and841, %and842
  %551 = load i32, ptr %a, align 4
  %552 = load i32, ptr %b, align 4
  %and844 = and i32 %551, %552
  %or845 = or i32 %or843, %and844
  %add846 = add i32 %or840, %or845
  %add847 = add i32 %add846, -1894007588
  %w848 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx849 = getelementptr inbounds [80 x i32], ptr %w848, i64 0, i64 52
  %553 = load i32, ptr %arrayidx849, align 4
  %add850 = add i32 %add847, %553
  %554 = load i32, ptr %c, align 4
  %add851 = add i32 %554, %add850
  store i32 %add851, ptr %c, align 4
  %555 = load i32, ptr %e, align 4
  %shl852 = shl i32 %555, 30
  %556 = load i32, ptr %e, align 4
  %shr853 = lshr i32 %556, 2
  %or854 = or i32 %shl852, %shr853
  store i32 %or854, ptr %e, align 4
  %557 = load i32, ptr %c, align 4
  %shl855 = shl i32 %557, 5
  %558 = load i32, ptr %c, align 4
  %shr856 = lshr i32 %558, 27
  %or857 = or i32 %shl855, %shr856
  %559 = load i32, ptr %d, align 4
  %560 = load i32, ptr %e, align 4
  %and858 = and i32 %559, %560
  %561 = load i32, ptr %d, align 4
  %562 = load i32, ptr %a, align 4
  %and859 = and i32 %561, %562
  %or860 = or i32 %and858, %and859
  %563 = load i32, ptr %e, align 4
  %564 = load i32, ptr %a, align 4
  %and861 = and i32 %563, %564
  %or862 = or i32 %or860, %and861
  %add863 = add i32 %or857, %or862
  %add864 = add i32 %add863, -1894007588
  %w865 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx866 = getelementptr inbounds [80 x i32], ptr %w865, i64 0, i64 53
  %565 = load i32, ptr %arrayidx866, align 4
  %add867 = add i32 %add864, %565
  %566 = load i32, ptr %b, align 4
  %add868 = add i32 %566, %add867
  store i32 %add868, ptr %b, align 4
  %567 = load i32, ptr %d, align 4
  %shl869 = shl i32 %567, 30
  %568 = load i32, ptr %d, align 4
  %shr870 = lshr i32 %568, 2
  %or871 = or i32 %shl869, %shr870
  store i32 %or871, ptr %d, align 4
  %569 = load i32, ptr %b, align 4
  %shl872 = shl i32 %569, 5
  %570 = load i32, ptr %b, align 4
  %shr873 = lshr i32 %570, 27
  %or874 = or i32 %shl872, %shr873
  %571 = load i32, ptr %c, align 4
  %572 = load i32, ptr %d, align 4
  %and875 = and i32 %571, %572
  %573 = load i32, ptr %c, align 4
  %574 = load i32, ptr %e, align 4
  %and876 = and i32 %573, %574
  %or877 = or i32 %and875, %and876
  %575 = load i32, ptr %d, align 4
  %576 = load i32, ptr %e, align 4
  %and878 = and i32 %575, %576
  %or879 = or i32 %or877, %and878
  %add880 = add i32 %or874, %or879
  %add881 = add i32 %add880, -1894007588
  %w882 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx883 = getelementptr inbounds [80 x i32], ptr %w882, i64 0, i64 54
  %577 = load i32, ptr %arrayidx883, align 4
  %add884 = add i32 %add881, %577
  %578 = load i32, ptr %a, align 4
  %add885 = add i32 %578, %add884
  store i32 %add885, ptr %a, align 4
  %579 = load i32, ptr %c, align 4
  %shl886 = shl i32 %579, 30
  %580 = load i32, ptr %c, align 4
  %shr887 = lshr i32 %580, 2
  %or888 = or i32 %shl886, %shr887
  store i32 %or888, ptr %c, align 4
  %581 = load i32, ptr %a, align 4
  %shl889 = shl i32 %581, 5
  %582 = load i32, ptr %a, align 4
  %shr890 = lshr i32 %582, 27
  %or891 = or i32 %shl889, %shr890
  %583 = load i32, ptr %b, align 4
  %584 = load i32, ptr %c, align 4
  %and892 = and i32 %583, %584
  %585 = load i32, ptr %b, align 4
  %586 = load i32, ptr %d, align 4
  %and893 = and i32 %585, %586
  %or894 = or i32 %and892, %and893
  %587 = load i32, ptr %c, align 4
  %588 = load i32, ptr %d, align 4
  %and895 = and i32 %587, %588
  %or896 = or i32 %or894, %and895
  %add897 = add i32 %or891, %or896
  %add898 = add i32 %add897, -1894007588
  %w899 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx900 = getelementptr inbounds [80 x i32], ptr %w899, i64 0, i64 55
  %589 = load i32, ptr %arrayidx900, align 4
  %add901 = add i32 %add898, %589
  %590 = load i32, ptr %e, align 4
  %add902 = add i32 %590, %add901
  store i32 %add902, ptr %e, align 4
  %591 = load i32, ptr %b, align 4
  %shl903 = shl i32 %591, 30
  %592 = load i32, ptr %b, align 4
  %shr904 = lshr i32 %592, 2
  %or905 = or i32 %shl903, %shr904
  store i32 %or905, ptr %b, align 4
  %593 = load i32, ptr %e, align 4
  %shl906 = shl i32 %593, 5
  %594 = load i32, ptr %e, align 4
  %shr907 = lshr i32 %594, 27
  %or908 = or i32 %shl906, %shr907
  %595 = load i32, ptr %a, align 4
  %596 = load i32, ptr %b, align 4
  %and909 = and i32 %595, %596
  %597 = load i32, ptr %a, align 4
  %598 = load i32, ptr %c, align 4
  %and910 = and i32 %597, %598
  %or911 = or i32 %and909, %and910
  %599 = load i32, ptr %b, align 4
  %600 = load i32, ptr %c, align 4
  %and912 = and i32 %599, %600
  %or913 = or i32 %or911, %and912
  %add914 = add i32 %or908, %or913
  %add915 = add i32 %add914, -1894007588
  %w916 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx917 = getelementptr inbounds [80 x i32], ptr %w916, i64 0, i64 56
  %601 = load i32, ptr %arrayidx917, align 4
  %add918 = add i32 %add915, %601
  %602 = load i32, ptr %d, align 4
  %add919 = add i32 %602, %add918
  store i32 %add919, ptr %d, align 4
  %603 = load i32, ptr %a, align 4
  %shl920 = shl i32 %603, 30
  %604 = load i32, ptr %a, align 4
  %shr921 = lshr i32 %604, 2
  %or922 = or i32 %shl920, %shr921
  store i32 %or922, ptr %a, align 4
  %605 = load i32, ptr %d, align 4
  %shl923 = shl i32 %605, 5
  %606 = load i32, ptr %d, align 4
  %shr924 = lshr i32 %606, 27
  %or925 = or i32 %shl923, %shr924
  %607 = load i32, ptr %e, align 4
  %608 = load i32, ptr %a, align 4
  %and926 = and i32 %607, %608
  %609 = load i32, ptr %e, align 4
  %610 = load i32, ptr %b, align 4
  %and927 = and i32 %609, %610
  %or928 = or i32 %and926, %and927
  %611 = load i32, ptr %a, align 4
  %612 = load i32, ptr %b, align 4
  %and929 = and i32 %611, %612
  %or930 = or i32 %or928, %and929
  %add931 = add i32 %or925, %or930
  %add932 = add i32 %add931, -1894007588
  %w933 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx934 = getelementptr inbounds [80 x i32], ptr %w933, i64 0, i64 57
  %613 = load i32, ptr %arrayidx934, align 4
  %add935 = add i32 %add932, %613
  %614 = load i32, ptr %c, align 4
  %add936 = add i32 %614, %add935
  store i32 %add936, ptr %c, align 4
  %615 = load i32, ptr %e, align 4
  %shl937 = shl i32 %615, 30
  %616 = load i32, ptr %e, align 4
  %shr938 = lshr i32 %616, 2
  %or939 = or i32 %shl937, %shr938
  store i32 %or939, ptr %e, align 4
  %617 = load i32, ptr %c, align 4
  %shl940 = shl i32 %617, 5
  %618 = load i32, ptr %c, align 4
  %shr941 = lshr i32 %618, 27
  %or942 = or i32 %shl940, %shr941
  %619 = load i32, ptr %d, align 4
  %620 = load i32, ptr %e, align 4
  %and943 = and i32 %619, %620
  %621 = load i32, ptr %d, align 4
  %622 = load i32, ptr %a, align 4
  %and944 = and i32 %621, %622
  %or945 = or i32 %and943, %and944
  %623 = load i32, ptr %e, align 4
  %624 = load i32, ptr %a, align 4
  %and946 = and i32 %623, %624
  %or947 = or i32 %or945, %and946
  %add948 = add i32 %or942, %or947
  %add949 = add i32 %add948, -1894007588
  %w950 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx951 = getelementptr inbounds [80 x i32], ptr %w950, i64 0, i64 58
  %625 = load i32, ptr %arrayidx951, align 4
  %add952 = add i32 %add949, %625
  %626 = load i32, ptr %b, align 4
  %add953 = add i32 %626, %add952
  store i32 %add953, ptr %b, align 4
  %627 = load i32, ptr %d, align 4
  %shl954 = shl i32 %627, 30
  %628 = load i32, ptr %d, align 4
  %shr955 = lshr i32 %628, 2
  %or956 = or i32 %shl954, %shr955
  store i32 %or956, ptr %d, align 4
  %629 = load i32, ptr %b, align 4
  %shl957 = shl i32 %629, 5
  %630 = load i32, ptr %b, align 4
  %shr958 = lshr i32 %630, 27
  %or959 = or i32 %shl957, %shr958
  %631 = load i32, ptr %c, align 4
  %632 = load i32, ptr %d, align 4
  %and960 = and i32 %631, %632
  %633 = load i32, ptr %c, align 4
  %634 = load i32, ptr %e, align 4
  %and961 = and i32 %633, %634
  %or962 = or i32 %and960, %and961
  %635 = load i32, ptr %d, align 4
  %636 = load i32, ptr %e, align 4
  %and963 = and i32 %635, %636
  %or964 = or i32 %or962, %and963
  %add965 = add i32 %or959, %or964
  %add966 = add i32 %add965, -1894007588
  %w967 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx968 = getelementptr inbounds [80 x i32], ptr %w967, i64 0, i64 59
  %637 = load i32, ptr %arrayidx968, align 4
  %add969 = add i32 %add966, %637
  %638 = load i32, ptr %a, align 4
  %add970 = add i32 %638, %add969
  store i32 %add970, ptr %a, align 4
  %639 = load i32, ptr %c, align 4
  %shl971 = shl i32 %639, 30
  %640 = load i32, ptr %c, align 4
  %shr972 = lshr i32 %640, 2
  %or973 = or i32 %shl971, %shr972
  store i32 %or973, ptr %c, align 4
  %641 = load i32, ptr %a, align 4
  %shl974 = shl i32 %641, 5
  %642 = load i32, ptr %a, align 4
  %shr975 = lshr i32 %642, 27
  %or976 = or i32 %shl974, %shr975
  %643 = load i32, ptr %b, align 4
  %644 = load i32, ptr %c, align 4
  %xor977 = xor i32 %643, %644
  %645 = load i32, ptr %d, align 4
  %xor978 = xor i32 %xor977, %645
  %add979 = add i32 %or976, %xor978
  %add980 = add i32 %add979, -899497514
  %w981 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx982 = getelementptr inbounds [80 x i32], ptr %w981, i64 0, i64 60
  %646 = load i32, ptr %arrayidx982, align 4
  %add983 = add i32 %add980, %646
  %647 = load i32, ptr %e, align 4
  %add984 = add i32 %647, %add983
  store i32 %add984, ptr %e, align 4
  %648 = load i32, ptr %b, align 4
  %shl985 = shl i32 %648, 30
  %649 = load i32, ptr %b, align 4
  %shr986 = lshr i32 %649, 2
  %or987 = or i32 %shl985, %shr986
  store i32 %or987, ptr %b, align 4
  %650 = load i32, ptr %e, align 4
  %shl988 = shl i32 %650, 5
  %651 = load i32, ptr %e, align 4
  %shr989 = lshr i32 %651, 27
  %or990 = or i32 %shl988, %shr989
  %652 = load i32, ptr %a, align 4
  %653 = load i32, ptr %b, align 4
  %xor991 = xor i32 %652, %653
  %654 = load i32, ptr %c, align 4
  %xor992 = xor i32 %xor991, %654
  %add993 = add i32 %or990, %xor992
  %add994 = add i32 %add993, -899497514
  %w995 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx996 = getelementptr inbounds [80 x i32], ptr %w995, i64 0, i64 61
  %655 = load i32, ptr %arrayidx996, align 4
  %add997 = add i32 %add994, %655
  %656 = load i32, ptr %d, align 4
  %add998 = add i32 %656, %add997
  store i32 %add998, ptr %d, align 4
  %657 = load i32, ptr %a, align 4
  %shl999 = shl i32 %657, 30
  %658 = load i32, ptr %a, align 4
  %shr1000 = lshr i32 %658, 2
  %or1001 = or i32 %shl999, %shr1000
  store i32 %or1001, ptr %a, align 4
  %659 = load i32, ptr %d, align 4
  %shl1002 = shl i32 %659, 5
  %660 = load i32, ptr %d, align 4
  %shr1003 = lshr i32 %660, 27
  %or1004 = or i32 %shl1002, %shr1003
  %661 = load i32, ptr %e, align 4
  %662 = load i32, ptr %a, align 4
  %xor1005 = xor i32 %661, %662
  %663 = load i32, ptr %b, align 4
  %xor1006 = xor i32 %xor1005, %663
  %add1007 = add i32 %or1004, %xor1006
  %add1008 = add i32 %add1007, -899497514
  %w1009 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1010 = getelementptr inbounds [80 x i32], ptr %w1009, i64 0, i64 62
  %664 = load i32, ptr %arrayidx1010, align 4
  %add1011 = add i32 %add1008, %664
  %665 = load i32, ptr %c, align 4
  %add1012 = add i32 %665, %add1011
  store i32 %add1012, ptr %c, align 4
  %666 = load i32, ptr %e, align 4
  %shl1013 = shl i32 %666, 30
  %667 = load i32, ptr %e, align 4
  %shr1014 = lshr i32 %667, 2
  %or1015 = or i32 %shl1013, %shr1014
  store i32 %or1015, ptr %e, align 4
  %668 = load i32, ptr %c, align 4
  %shl1016 = shl i32 %668, 5
  %669 = load i32, ptr %c, align 4
  %shr1017 = lshr i32 %669, 27
  %or1018 = or i32 %shl1016, %shr1017
  %670 = load i32, ptr %d, align 4
  %671 = load i32, ptr %e, align 4
  %xor1019 = xor i32 %670, %671
  %672 = load i32, ptr %a, align 4
  %xor1020 = xor i32 %xor1019, %672
  %add1021 = add i32 %or1018, %xor1020
  %add1022 = add i32 %add1021, -899497514
  %w1023 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1024 = getelementptr inbounds [80 x i32], ptr %w1023, i64 0, i64 63
  %673 = load i32, ptr %arrayidx1024, align 4
  %add1025 = add i32 %add1022, %673
  %674 = load i32, ptr %b, align 4
  %add1026 = add i32 %674, %add1025
  store i32 %add1026, ptr %b, align 4
  %675 = load i32, ptr %d, align 4
  %shl1027 = shl i32 %675, 30
  %676 = load i32, ptr %d, align 4
  %shr1028 = lshr i32 %676, 2
  %or1029 = or i32 %shl1027, %shr1028
  store i32 %or1029, ptr %d, align 4
  %677 = load i32, ptr %b, align 4
  %shl1030 = shl i32 %677, 5
  %678 = load i32, ptr %b, align 4
  %shr1031 = lshr i32 %678, 27
  %or1032 = or i32 %shl1030, %shr1031
  %679 = load i32, ptr %c, align 4
  %680 = load i32, ptr %d, align 4
  %xor1033 = xor i32 %679, %680
  %681 = load i32, ptr %e, align 4
  %xor1034 = xor i32 %xor1033, %681
  %add1035 = add i32 %or1032, %xor1034
  %add1036 = add i32 %add1035, -899497514
  %w1037 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1038 = getelementptr inbounds [80 x i32], ptr %w1037, i64 0, i64 64
  %682 = load i32, ptr %arrayidx1038, align 4
  %add1039 = add i32 %add1036, %682
  %683 = load i32, ptr %a, align 4
  %add1040 = add i32 %683, %add1039
  store i32 %add1040, ptr %a, align 4
  %684 = load i32, ptr %c, align 4
  %shl1041 = shl i32 %684, 30
  %685 = load i32, ptr %c, align 4
  %shr1042 = lshr i32 %685, 2
  %or1043 = or i32 %shl1041, %shr1042
  store i32 %or1043, ptr %c, align 4
  %686 = load i32, ptr %a, align 4
  %shl1044 = shl i32 %686, 5
  %687 = load i32, ptr %a, align 4
  %shr1045 = lshr i32 %687, 27
  %or1046 = or i32 %shl1044, %shr1045
  %688 = load i32, ptr %b, align 4
  %689 = load i32, ptr %c, align 4
  %xor1047 = xor i32 %688, %689
  %690 = load i32, ptr %d, align 4
  %xor1048 = xor i32 %xor1047, %690
  %add1049 = add i32 %or1046, %xor1048
  %add1050 = add i32 %add1049, -899497514
  %w1051 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1052 = getelementptr inbounds [80 x i32], ptr %w1051, i64 0, i64 65
  %691 = load i32, ptr %arrayidx1052, align 4
  %add1053 = add i32 %add1050, %691
  %692 = load i32, ptr %e, align 4
  %add1054 = add i32 %692, %add1053
  store i32 %add1054, ptr %e, align 4
  %693 = load i32, ptr %b, align 4
  %shl1055 = shl i32 %693, 30
  %694 = load i32, ptr %b, align 4
  %shr1056 = lshr i32 %694, 2
  %or1057 = or i32 %shl1055, %shr1056
  store i32 %or1057, ptr %b, align 4
  %695 = load i32, ptr %e, align 4
  %shl1058 = shl i32 %695, 5
  %696 = load i32, ptr %e, align 4
  %shr1059 = lshr i32 %696, 27
  %or1060 = or i32 %shl1058, %shr1059
  %697 = load i32, ptr %a, align 4
  %698 = load i32, ptr %b, align 4
  %xor1061 = xor i32 %697, %698
  %699 = load i32, ptr %c, align 4
  %xor1062 = xor i32 %xor1061, %699
  %add1063 = add i32 %or1060, %xor1062
  %add1064 = add i32 %add1063, -899497514
  %w1065 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1066 = getelementptr inbounds [80 x i32], ptr %w1065, i64 0, i64 66
  %700 = load i32, ptr %arrayidx1066, align 4
  %add1067 = add i32 %add1064, %700
  %701 = load i32, ptr %d, align 4
  %add1068 = add i32 %701, %add1067
  store i32 %add1068, ptr %d, align 4
  %702 = load i32, ptr %a, align 4
  %shl1069 = shl i32 %702, 30
  %703 = load i32, ptr %a, align 4
  %shr1070 = lshr i32 %703, 2
  %or1071 = or i32 %shl1069, %shr1070
  store i32 %or1071, ptr %a, align 4
  %704 = load i32, ptr %d, align 4
  %shl1072 = shl i32 %704, 5
  %705 = load i32, ptr %d, align 4
  %shr1073 = lshr i32 %705, 27
  %or1074 = or i32 %shl1072, %shr1073
  %706 = load i32, ptr %e, align 4
  %707 = load i32, ptr %a, align 4
  %xor1075 = xor i32 %706, %707
  %708 = load i32, ptr %b, align 4
  %xor1076 = xor i32 %xor1075, %708
  %add1077 = add i32 %or1074, %xor1076
  %add1078 = add i32 %add1077, -899497514
  %w1079 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1080 = getelementptr inbounds [80 x i32], ptr %w1079, i64 0, i64 67
  %709 = load i32, ptr %arrayidx1080, align 4
  %add1081 = add i32 %add1078, %709
  %710 = load i32, ptr %c, align 4
  %add1082 = add i32 %710, %add1081
  store i32 %add1082, ptr %c, align 4
  %711 = load i32, ptr %e, align 4
  %shl1083 = shl i32 %711, 30
  %712 = load i32, ptr %e, align 4
  %shr1084 = lshr i32 %712, 2
  %or1085 = or i32 %shl1083, %shr1084
  store i32 %or1085, ptr %e, align 4
  %713 = load i32, ptr %c, align 4
  %shl1086 = shl i32 %713, 5
  %714 = load i32, ptr %c, align 4
  %shr1087 = lshr i32 %714, 27
  %or1088 = or i32 %shl1086, %shr1087
  %715 = load i32, ptr %d, align 4
  %716 = load i32, ptr %e, align 4
  %xor1089 = xor i32 %715, %716
  %717 = load i32, ptr %a, align 4
  %xor1090 = xor i32 %xor1089, %717
  %add1091 = add i32 %or1088, %xor1090
  %add1092 = add i32 %add1091, -899497514
  %w1093 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1094 = getelementptr inbounds [80 x i32], ptr %w1093, i64 0, i64 68
  %718 = load i32, ptr %arrayidx1094, align 4
  %add1095 = add i32 %add1092, %718
  %719 = load i32, ptr %b, align 4
  %add1096 = add i32 %719, %add1095
  store i32 %add1096, ptr %b, align 4
  %720 = load i32, ptr %d, align 4
  %shl1097 = shl i32 %720, 30
  %721 = load i32, ptr %d, align 4
  %shr1098 = lshr i32 %721, 2
  %or1099 = or i32 %shl1097, %shr1098
  store i32 %or1099, ptr %d, align 4
  %722 = load i32, ptr %b, align 4
  %shl1100 = shl i32 %722, 5
  %723 = load i32, ptr %b, align 4
  %shr1101 = lshr i32 %723, 27
  %or1102 = or i32 %shl1100, %shr1101
  %724 = load i32, ptr %c, align 4
  %725 = load i32, ptr %d, align 4
  %xor1103 = xor i32 %724, %725
  %726 = load i32, ptr %e, align 4
  %xor1104 = xor i32 %xor1103, %726
  %add1105 = add i32 %or1102, %xor1104
  %add1106 = add i32 %add1105, -899497514
  %w1107 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1108 = getelementptr inbounds [80 x i32], ptr %w1107, i64 0, i64 69
  %727 = load i32, ptr %arrayidx1108, align 4
  %add1109 = add i32 %add1106, %727
  %728 = load i32, ptr %a, align 4
  %add1110 = add i32 %728, %add1109
  store i32 %add1110, ptr %a, align 4
  %729 = load i32, ptr %c, align 4
  %shl1111 = shl i32 %729, 30
  %730 = load i32, ptr %c, align 4
  %shr1112 = lshr i32 %730, 2
  %or1113 = or i32 %shl1111, %shr1112
  store i32 %or1113, ptr %c, align 4
  %731 = load i32, ptr %a, align 4
  %shl1114 = shl i32 %731, 5
  %732 = load i32, ptr %a, align 4
  %shr1115 = lshr i32 %732, 27
  %or1116 = or i32 %shl1114, %shr1115
  %733 = load i32, ptr %b, align 4
  %734 = load i32, ptr %c, align 4
  %xor1117 = xor i32 %733, %734
  %735 = load i32, ptr %d, align 4
  %xor1118 = xor i32 %xor1117, %735
  %add1119 = add i32 %or1116, %xor1118
  %add1120 = add i32 %add1119, -899497514
  %w1121 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1122 = getelementptr inbounds [80 x i32], ptr %w1121, i64 0, i64 70
  %736 = load i32, ptr %arrayidx1122, align 4
  %add1123 = add i32 %add1120, %736
  %737 = load i32, ptr %e, align 4
  %add1124 = add i32 %737, %add1123
  store i32 %add1124, ptr %e, align 4
  %738 = load i32, ptr %b, align 4
  %shl1125 = shl i32 %738, 30
  %739 = load i32, ptr %b, align 4
  %shr1126 = lshr i32 %739, 2
  %or1127 = or i32 %shl1125, %shr1126
  store i32 %or1127, ptr %b, align 4
  %740 = load i32, ptr %e, align 4
  %shl1128 = shl i32 %740, 5
  %741 = load i32, ptr %e, align 4
  %shr1129 = lshr i32 %741, 27
  %or1130 = or i32 %shl1128, %shr1129
  %742 = load i32, ptr %a, align 4
  %743 = load i32, ptr %b, align 4
  %xor1131 = xor i32 %742, %743
  %744 = load i32, ptr %c, align 4
  %xor1132 = xor i32 %xor1131, %744
  %add1133 = add i32 %or1130, %xor1132
  %add1134 = add i32 %add1133, -899497514
  %w1135 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1136 = getelementptr inbounds [80 x i32], ptr %w1135, i64 0, i64 71
  %745 = load i32, ptr %arrayidx1136, align 4
  %add1137 = add i32 %add1134, %745
  %746 = load i32, ptr %d, align 4
  %add1138 = add i32 %746, %add1137
  store i32 %add1138, ptr %d, align 4
  %747 = load i32, ptr %a, align 4
  %shl1139 = shl i32 %747, 30
  %748 = load i32, ptr %a, align 4
  %shr1140 = lshr i32 %748, 2
  %or1141 = or i32 %shl1139, %shr1140
  store i32 %or1141, ptr %a, align 4
  %749 = load i32, ptr %d, align 4
  %shl1142 = shl i32 %749, 5
  %750 = load i32, ptr %d, align 4
  %shr1143 = lshr i32 %750, 27
  %or1144 = or i32 %shl1142, %shr1143
  %751 = load i32, ptr %e, align 4
  %752 = load i32, ptr %a, align 4
  %xor1145 = xor i32 %751, %752
  %753 = load i32, ptr %b, align 4
  %xor1146 = xor i32 %xor1145, %753
  %add1147 = add i32 %or1144, %xor1146
  %add1148 = add i32 %add1147, -899497514
  %w1149 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1150 = getelementptr inbounds [80 x i32], ptr %w1149, i64 0, i64 72
  %754 = load i32, ptr %arrayidx1150, align 4
  %add1151 = add i32 %add1148, %754
  %755 = load i32, ptr %c, align 4
  %add1152 = add i32 %755, %add1151
  store i32 %add1152, ptr %c, align 4
  %756 = load i32, ptr %e, align 4
  %shl1153 = shl i32 %756, 30
  %757 = load i32, ptr %e, align 4
  %shr1154 = lshr i32 %757, 2
  %or1155 = or i32 %shl1153, %shr1154
  store i32 %or1155, ptr %e, align 4
  %758 = load i32, ptr %c, align 4
  %shl1156 = shl i32 %758, 5
  %759 = load i32, ptr %c, align 4
  %shr1157 = lshr i32 %759, 27
  %or1158 = or i32 %shl1156, %shr1157
  %760 = load i32, ptr %d, align 4
  %761 = load i32, ptr %e, align 4
  %xor1159 = xor i32 %760, %761
  %762 = load i32, ptr %a, align 4
  %xor1160 = xor i32 %xor1159, %762
  %add1161 = add i32 %or1158, %xor1160
  %add1162 = add i32 %add1161, -899497514
  %w1163 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1164 = getelementptr inbounds [80 x i32], ptr %w1163, i64 0, i64 73
  %763 = load i32, ptr %arrayidx1164, align 4
  %add1165 = add i32 %add1162, %763
  %764 = load i32, ptr %b, align 4
  %add1166 = add i32 %764, %add1165
  store i32 %add1166, ptr %b, align 4
  %765 = load i32, ptr %d, align 4
  %shl1167 = shl i32 %765, 30
  %766 = load i32, ptr %d, align 4
  %shr1168 = lshr i32 %766, 2
  %or1169 = or i32 %shl1167, %shr1168
  store i32 %or1169, ptr %d, align 4
  %767 = load i32, ptr %b, align 4
  %shl1170 = shl i32 %767, 5
  %768 = load i32, ptr %b, align 4
  %shr1171 = lshr i32 %768, 27
  %or1172 = or i32 %shl1170, %shr1171
  %769 = load i32, ptr %c, align 4
  %770 = load i32, ptr %d, align 4
  %xor1173 = xor i32 %769, %770
  %771 = load i32, ptr %e, align 4
  %xor1174 = xor i32 %xor1173, %771
  %add1175 = add i32 %or1172, %xor1174
  %add1176 = add i32 %add1175, -899497514
  %w1177 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1178 = getelementptr inbounds [80 x i32], ptr %w1177, i64 0, i64 74
  %772 = load i32, ptr %arrayidx1178, align 4
  %add1179 = add i32 %add1176, %772
  %773 = load i32, ptr %a, align 4
  %add1180 = add i32 %773, %add1179
  store i32 %add1180, ptr %a, align 4
  %774 = load i32, ptr %c, align 4
  %shl1181 = shl i32 %774, 30
  %775 = load i32, ptr %c, align 4
  %shr1182 = lshr i32 %775, 2
  %or1183 = or i32 %shl1181, %shr1182
  store i32 %or1183, ptr %c, align 4
  %776 = load i32, ptr %a, align 4
  %shl1184 = shl i32 %776, 5
  %777 = load i32, ptr %a, align 4
  %shr1185 = lshr i32 %777, 27
  %or1186 = or i32 %shl1184, %shr1185
  %778 = load i32, ptr %b, align 4
  %779 = load i32, ptr %c, align 4
  %xor1187 = xor i32 %778, %779
  %780 = load i32, ptr %d, align 4
  %xor1188 = xor i32 %xor1187, %780
  %add1189 = add i32 %or1186, %xor1188
  %add1190 = add i32 %add1189, -899497514
  %w1191 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1192 = getelementptr inbounds [80 x i32], ptr %w1191, i64 0, i64 75
  %781 = load i32, ptr %arrayidx1192, align 4
  %add1193 = add i32 %add1190, %781
  %782 = load i32, ptr %e, align 4
  %add1194 = add i32 %782, %add1193
  store i32 %add1194, ptr %e, align 4
  %783 = load i32, ptr %b, align 4
  %shl1195 = shl i32 %783, 30
  %784 = load i32, ptr %b, align 4
  %shr1196 = lshr i32 %784, 2
  %or1197 = or i32 %shl1195, %shr1196
  store i32 %or1197, ptr %b, align 4
  %785 = load i32, ptr %e, align 4
  %shl1198 = shl i32 %785, 5
  %786 = load i32, ptr %e, align 4
  %shr1199 = lshr i32 %786, 27
  %or1200 = or i32 %shl1198, %shr1199
  %787 = load i32, ptr %a, align 4
  %788 = load i32, ptr %b, align 4
  %xor1201 = xor i32 %787, %788
  %789 = load i32, ptr %c, align 4
  %xor1202 = xor i32 %xor1201, %789
  %add1203 = add i32 %or1200, %xor1202
  %add1204 = add i32 %add1203, -899497514
  %w1205 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1206 = getelementptr inbounds [80 x i32], ptr %w1205, i64 0, i64 76
  %790 = load i32, ptr %arrayidx1206, align 4
  %add1207 = add i32 %add1204, %790
  %791 = load i32, ptr %d, align 4
  %add1208 = add i32 %791, %add1207
  store i32 %add1208, ptr %d, align 4
  %792 = load i32, ptr %a, align 4
  %shl1209 = shl i32 %792, 30
  %793 = load i32, ptr %a, align 4
  %shr1210 = lshr i32 %793, 2
  %or1211 = or i32 %shl1209, %shr1210
  store i32 %or1211, ptr %a, align 4
  %794 = load i32, ptr %d, align 4
  %shl1212 = shl i32 %794, 5
  %795 = load i32, ptr %d, align 4
  %shr1213 = lshr i32 %795, 27
  %or1214 = or i32 %shl1212, %shr1213
  %796 = load i32, ptr %e, align 4
  %797 = load i32, ptr %a, align 4
  %xor1215 = xor i32 %796, %797
  %798 = load i32, ptr %b, align 4
  %xor1216 = xor i32 %xor1215, %798
  %add1217 = add i32 %or1214, %xor1216
  %add1218 = add i32 %add1217, -899497514
  %w1219 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1220 = getelementptr inbounds [80 x i32], ptr %w1219, i64 0, i64 77
  %799 = load i32, ptr %arrayidx1220, align 4
  %add1221 = add i32 %add1218, %799
  %800 = load i32, ptr %c, align 4
  %add1222 = add i32 %800, %add1221
  store i32 %add1222, ptr %c, align 4
  %801 = load i32, ptr %e, align 4
  %shl1223 = shl i32 %801, 30
  %802 = load i32, ptr %e, align 4
  %shr1224 = lshr i32 %802, 2
  %or1225 = or i32 %shl1223, %shr1224
  store i32 %or1225, ptr %e, align 4
  %803 = load i32, ptr %c, align 4
  %shl1226 = shl i32 %803, 5
  %804 = load i32, ptr %c, align 4
  %shr1227 = lshr i32 %804, 27
  %or1228 = or i32 %shl1226, %shr1227
  %805 = load i32, ptr %d, align 4
  %806 = load i32, ptr %e, align 4
  %xor1229 = xor i32 %805, %806
  %807 = load i32, ptr %a, align 4
  %xor1230 = xor i32 %xor1229, %807
  %add1231 = add i32 %or1228, %xor1230
  %add1232 = add i32 %add1231, -899497514
  %w1233 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1234 = getelementptr inbounds [80 x i32], ptr %w1233, i64 0, i64 78
  %808 = load i32, ptr %arrayidx1234, align 4
  %add1235 = add i32 %add1232, %808
  %809 = load i32, ptr %b, align 4
  %add1236 = add i32 %809, %add1235
  store i32 %add1236, ptr %b, align 4
  %810 = load i32, ptr %d, align 4
  %shl1237 = shl i32 %810, 30
  %811 = load i32, ptr %d, align 4
  %shr1238 = lshr i32 %811, 2
  %or1239 = or i32 %shl1237, %shr1238
  store i32 %or1239, ptr %d, align 4
  %812 = load i32, ptr %b, align 4
  %shl1240 = shl i32 %812, 5
  %813 = load i32, ptr %b, align 4
  %shr1241 = lshr i32 %813, 27
  %or1242 = or i32 %shl1240, %shr1241
  %814 = load i32, ptr %c, align 4
  %815 = load i32, ptr %d, align 4
  %xor1243 = xor i32 %814, %815
  %816 = load i32, ptr %e, align 4
  %xor1244 = xor i32 %xor1243, %816
  %add1245 = add i32 %or1242, %xor1244
  %add1246 = add i32 %add1245, -899497514
  %w1247 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 3
  %arrayidx1248 = getelementptr inbounds [80 x i32], ptr %w1247, i64 0, i64 79
  %817 = load i32, ptr %arrayidx1248, align 4
  %add1249 = add i32 %add1246, %817
  %818 = load i32, ptr %a, align 4
  %add1250 = add i32 %818, %add1249
  store i32 %add1250, ptr %a, align 4
  %819 = load i32, ptr %c, align 4
  %shl1251 = shl i32 %819, 30
  %820 = load i32, ptr %c, align 4
  %shr1252 = lshr i32 %820, 2
  %or1253 = or i32 %shl1251, %shr1252
  store i32 %or1253, ptr %c, align 4
  %821 = load i32, ptr %a, align 4
  %h1254 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx1255 = getelementptr inbounds [5 x i32], ptr %h1254, i64 0, i64 0
  %822 = load i32, ptr %arrayidx1255, align 4
  %add1256 = add i32 %822, %821
  store i32 %add1256, ptr %arrayidx1255, align 4
  %823 = load i32, ptr %b, align 4
  %h1257 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx1258 = getelementptr inbounds [5 x i32], ptr %h1257, i64 0, i64 1
  %824 = load i32, ptr %arrayidx1258, align 4
  %add1259 = add i32 %824, %823
  store i32 %add1259, ptr %arrayidx1258, align 4
  %825 = load i32, ptr %c, align 4
  %h1260 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx1261 = getelementptr inbounds [5 x i32], ptr %h1260, i64 0, i64 2
  %826 = load i32, ptr %arrayidx1261, align 4
  %add1262 = add i32 %826, %825
  store i32 %add1262, ptr %arrayidx1261, align 4
  %827 = load i32, ptr %d, align 4
  %h1263 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx1264 = getelementptr inbounds [5 x i32], ptr %h1263, i64 0, i64 3
  %828 = load i32, ptr %arrayidx1264, align 4
  %add1265 = add i32 %828, %827
  store i32 %add1265, ptr %arrayidx1264, align 4
  %829 = load i32, ptr %e, align 4
  %h1266 = getelementptr inbounds %"class.libzpaq::SHA1", ptr %this1, i32 0, i32 2
  %arrayidx1267 = getelementptr inbounds [5 x i32], ptr %h1266, i64 0, i64 4
  %830 = load i32, ptr %arrayidx1267, align 4
  %add1268 = add i32 %830, %829
  store i32 %add1268, ptr %arrayidx1267, align 4
  ret void
}

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
  br label %for.cond, !llvm.loop !8

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
  br label %for.cond8, !llvm.loop !9

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
  br label %for.cond19, !llvm.loop !10

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
  br label %for.cond36, !llvm.loop !11

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
  br label %for.cond53, !llvm.loop !12

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
  br label %for.cond63, !llvm.loop !13

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
  br label %for.cond2, !llvm.loop !14

for.end:                                          ; No predecessors!
  br label %for.inc16

for.inc16:                                        ; preds = %for.end
  %18 = load i32, ptr %i, align 4
  %inc17 = add nsw i32 %18, 1
  store i32 %inc17, ptr %i, align 4
  br label %for.cond, !llvm.loop !15

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
  br label %for.cond28, !llvm.loop !16

for.end72:                                        ; No predecessors!
  br label %for.inc73

for.inc73:                                        ; preds = %for.end72
  %45 = load i32, ptr %n124, align 4
  %inc74 = add nsw i32 %45, 1
  store i32 %inc74, ptr %n124, align 4
  br label %for.cond25, !llvm.loop !17

for.end75:                                        ; No predecessors!
  br label %for.inc76

for.inc76:                                        ; preds = %for.end75
  %46 = load i32, ptr %n020, align 4
  %inc77 = add nsw i32 %46, 1
  store i32 %inc77, ptr %n020, align 4
  br label %for.cond21, !llvm.loop !18

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
uselistorder i32 2, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, 81, 82, 83, 84, 85, 86, 87, 88, 89, 90, 91, 92, 93, 94, 95, 98, 99, 100, 101, 96, 97 }
uselistorder i32 1, { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, 65, 66, 75, 76, 77, 78, 67, 68, 69, 70, 71, 72, 73, 74 }
uselistorder ptr @.str.50, { 1, 0 }
uselistorder ptr @.str.59, { 1, 0 }
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
attributes #7 = { cold noreturn nounwind }
attributes #8 = { noinline nounwind uwtable "frame-pointer"="all" "min-legal-vector-width"="0" "no-trapping-math"="true" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+cmov,+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "tune-cpu"="generic" }
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
