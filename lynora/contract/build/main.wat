(module
 (type $0 (func (param i32) (result i32)))
 (type $1 (func (param i32 i32) (result i32)))
 (type $2 (func (param i32 i32)))
 (type $3 (func (param i32)))
 (type $4 (func (result i32)))
 (type $5 (func (param i32 i32 i32) (result i32)))
 (type $6 (func (result i64)))
 (type $7 (func (param i64) (result i32)))
 (type $8 (func (param i64 i32 i32) (result i32)))
 (type $9 (func (param i32 i32 i32 i32)))
 (type $10 (func (param i32 i32 i32 i32) (result i32)))
 (type $11 (func (param i64 i32 i32 i32 i64) (result i32)))
 (type $12 (func (param i32 i32 i32)))
 (type $13 (func (param i64 i32 i32 i64) (result i32)))
 (type $14 (func (param i32 i64)))
 (type $15 (func))
 (import "env" "abort" (func $~lib/builtins/abort (param i32 i32 i32 i32)))
 (import "massa" "assembly_script_get_call_stack" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.callStack (result i32)))
 (import "massa" "assembly_script_has_data" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.has (param i32) (result i32)))
 (import "massa" "assembly_script_set_data" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set (param i32 i32)))
 (import "massa" "assembly_script_get_data" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.get (param i32) (result i32)))
 (import "massa" "assembly_script_get_time" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time (result i64)))
 (import "massa" "assembly_script_generate_event" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.generateEvent (param i32)))
 (import "massa" "assembly_script_get_call_coins" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.callCoins (result i64)))
 (import "massa" "assembly_script_transfer_coins" (func $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.transferCoins (param i32 i64)))
 (global $~lib/rt/stub/offset (mut i32) (i32.const 0))
 (global $~argumentsLength (mut i32) (i32.const 0))
 (global $assembly/main/NEXT_MARKET_ID_KEY (mut i32) (i32.const 0))
 (global $assembly/main/MARKET_PREFIX (mut i32) (i32.const 0))
 (global $assembly/main/USER_BET_PREFIX (mut i32) (i32.const 0))
 (memory $0 1)
 (data $0 (i32.const 1036) "<")
 (data $0.1 (i32.const 1048) "\02\00\00\00(\00\00\00A\00l\00l\00o\00c\00a\00t\00i\00o\00n\00 \00t\00o\00o\00 \00l\00a\00r\00g\00e")
 (data $1 (i32.const 1100) "<")
 (data $1.1 (i32.const 1112) "\02\00\00\00\1e\00\00\00~\00l\00i\00b\00/\00r\00t\00/\00s\00t\00u\00b\00.\00t\00s")
 (data $2 (i32.const 1164) ",")
 (data $2.1 (i32.const 1176) "\02\00\00\00\1c\00\00\00I\00n\00v\00a\00l\00i\00d\00 \00l\00e\00n\00g\00t\00h")
 (data $3 (i32.const 1212) "<")
 (data $3.1 (i32.const 1224) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00s\00t\00a\00t\00i\00c\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $4 (i32.const 1276) "\1c")
 (data $4.1 (i32.const 1288) "\05")
 (data $5 (i32.const 1308) "l")
 (data $5.1 (i32.const 1320) "\02\00\00\00R\00\00\00A\00U\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\001\002\00m\001\00s\009\00K")
 (data $6 (i32.const 1420) "\1c")
 (data $6.1 (i32.const 1432) "\02\00\00\00\04\00\00\00:\00:")
 (data $7 (i32.const 1452) ",")
 (data $7.1 (i32.const 1464) "\02\00\00\00\1c\00\00\00N\00E\00X\00T\00_\00M\00A\00R\00K\00E\00T\00_\00I\00D")
 (data $8 (i32.const 1500) "\1c")
 (data $8.1 (i32.const 1512) "\05")
 (data $9 (i32.const 1532) "<")
 (data $9.1 (i32.const 1544) "\02\00\00\00$\00\00\00U\00n\00p\00a\00i\00r\00e\00d\00 \00s\00u\00r\00r\00o\00g\00a\00t\00e")
 (data $10 (i32.const 1596) ",")
 (data $10.1 (i32.const 1608) "\02\00\00\00\1c\00\00\00~\00l\00i\00b\00/\00s\00t\00r\00i\00n\00g\00.\00t\00s")
 (data $11 (i32.const 1644) ",")
 (data $11.1 (i32.const 1656) "\02\00\00\00\0e\00\00\00M\00A\00R\00K\00E\00T\00_")
 (data $12 (i32.const 1692) "\1c")
 (data $12.1 (i32.const 1704) "\02\00\00\00\08\00\00\00B\00E\00T\00_")
 (data $13 (i32.const 1724) ",")
 (data $13.1 (i32.const 1736) "\02\00\00\00\12\00\00\00U\00S\00E\00R\00_\00B\00E\00T\00_")
 (data $14 (i32.const 1772) "\8c")
 (data $14.1 (i32.const 1784) "\02\00\00\00n\00\00\00c\00a\00n\00\'\00t\00 \00d\00e\00s\00e\00r\00i\00a\00l\00i\00z\00e\00 \00u\003\002\00 \00f\00r\00o\00m\00 \00g\00i\00v\00e\00n\00 \00a\00r\00g\00u\00m\00e\00n\00t\00:\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $15 (i32.const 1916) "|")
 (data $15.1 (i32.const 1928) "\02\00\00\00^\00\00\00U\00n\00e\00x\00p\00e\00c\00t\00e\00d\00 \00\'\00n\00u\00l\00l\00\'\00 \00(\00n\00o\00t\00 \00a\00s\00s\00i\00g\00n\00e\00d\00 \00o\00r\00 \00f\00a\00i\00l\00e\00d\00 \00c\00a\00s\00t\00)")
 (data $16 (i32.const 2044) "l")
 (data $16.1 (i32.const 2056) "\02\00\00\00V\00\00\00~\00l\00i\00b\00/\00@\00m\00a\00s\00s\00a\00l\00a\00b\00s\00/\00a\00s\00-\00t\00y\00p\00e\00s\00/\00a\00s\00s\00e\00m\00b\00l\00y\00/\00r\00e\00s\00u\00l\00t\00.\00t\00s")
 (data $17 (i32.const 2156) "\1c")
 (data $17.1 (i32.const 2168) "\02")
 (data $18 (i32.const 2188) "\8c")
 (data $18.1 (i32.const 2200) "\02\00\00\00t\00\00\00c\00a\00n\00\'\00t\00 \00d\00e\00s\00e\00r\00i\00a\00l\00i\00z\00e\00 \00s\00t\00r\00i\00n\00g\00 \00f\00r\00o\00m\00 \00g\00i\00v\00e\00n\00 \00a\00r\00g\00u\00m\00e\00n\00t\00:\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $19 (i32.const 2332) "\8c")
 (data $19.1 (i32.const 2344) "\02\00\00\00n\00\00\00c\00a\00n\00\'\00t\00 \00d\00e\00s\00e\00r\00i\00a\00l\00i\00z\00e\00 \00u\006\004\00 \00f\00r\00o\00m\00 \00g\00i\00v\00e\00n\00 \00a\00r\00g\00u\00m\00e\00n\00t\00:\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $20 (i32.const 2476) "\1c")
 (data $20.1 (i32.const 2488) "\02\00\00\00\02\00\00\00,")
 (data $21 (i32.const 2508) "<")
 (data $21.1 (i32.const 2520) "\02\00\00\00$\00\00\00I\00n\00d\00e\00x\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $22 (i32.const 2572) ",")
 (data $22.1 (i32.const 2584) "\02\00\00\00\1a\00\00\00~\00l\00i\00b\00/\00a\00r\00r\00a\00y\00.\00t\00s")
 (data $23 (i32.const 2620) "\1c")
 (data $23.1 (i32.const 2632) "\10\00\00\00\08\00\00\00\01")
 (data $24 (i32.const 2652) "|")
 (data $24.1 (i32.const 2664) "\02\00\00\00^\00\00\00E\00l\00e\00m\00e\00n\00t\00 \00t\00y\00p\00e\00 \00m\00u\00s\00t\00 \00b\00e\00 \00n\00u\00l\00l\00a\00b\00l\00e\00 \00i\00f\00 \00a\00r\00r\00a\00y\00 \00i\00s\00 \00h\00o\00l\00e\00y")
 (data $25 (i32.const 2780) "|")
 (data $25.1 (i32.const 2792) "\02\00\00\00d\00\00\00t\00o\00S\00t\00r\00i\00n\00g\00(\00)\00 \00r\00a\00d\00i\00x\00 \00a\00r\00g\00u\00m\00e\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00b\00e\00t\00w\00e\00e\00n\00 \002\00 \00a\00n\00d\00 \003\006")
 (data $26 (i32.const 2908) "<")
 (data $26.1 (i32.const 2920) "\02\00\00\00&\00\00\00~\00l\00i\00b\00/\00u\00t\00i\00l\00/\00n\00u\00m\00b\00e\00r\00.\00t\00s")
 (data $27 (i32.const 2972) "\1c")
 (data $27.1 (i32.const 2984) "\02\00\00\00\02\00\00\000")
 (data $28 (i32.const 3004) "0\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009")
 (data $29 (i32.const 3404) "\1c\04")
 (data $29.1 (i32.const 3416) "\02\00\00\00\00\04\00\000\000\000\001\000\002\000\003\000\004\000\005\000\006\000\007\000\008\000\009\000\00a\000\00b\000\00c\000\00d\000\00e\000\00f\001\000\001\001\001\002\001\003\001\004\001\005\001\006\001\007\001\008\001\009\001\00a\001\00b\001\00c\001\00d\001\00e\001\00f\002\000\002\001\002\002\002\003\002\004\002\005\002\006\002\007\002\008\002\009\002\00a\002\00b\002\00c\002\00d\002\00e\002\00f\003\000\003\001\003\002\003\003\003\004\003\005\003\006\003\007\003\008\003\009\003\00a\003\00b\003\00c\003\00d\003\00e\003\00f\004\000\004\001\004\002\004\003\004\004\004\005\004\006\004\007\004\008\004\009\004\00a\004\00b\004\00c\004\00d\004\00e\004\00f\005\000\005\001\005\002\005\003\005\004\005\005\005\006\005\007\005\008\005\009\005\00a\005\00b\005\00c\005\00d\005\00e\005\00f\006\000\006\001\006\002\006\003\006\004\006\005\006\006\006\007\006\008\006\009\006\00a\006\00b\006\00c\006\00d\006\00e\006\00f\007\000\007\001\007\002\007\003\007\004\007\005\007\006\007\007\007\008\007\009\007\00a\007\00b\007\00c\007\00d\007\00e\007\00f\008\000\008\001\008\002\008\003\008\004\008\005\008\006\008\007\008\008\008\009\008\00a\008\00b\008\00c\008\00d\008\00e\008\00f\009\000\009\001\009\002\009\003\009\004\009\005\009\006\009\007\009\008\009\009\009\00a\009\00b\009\00c\009\00d\009\00e\009\00f\00a\000\00a\001\00a\002\00a\003\00a\004\00a\005\00a\006\00a\007\00a\008\00a\009\00a\00a\00a\00b\00a\00c\00a\00d\00a\00e\00a\00f\00b\000\00b\001\00b\002\00b\003\00b\004\00b\005\00b\006\00b\007\00b\008\00b\009\00b\00a\00b\00b\00b\00c\00b\00d\00b\00e\00b\00f\00c\000\00c\001\00c\002\00c\003\00c\004\00c\005\00c\006\00c\007\00c\008\00c\009\00c\00a\00c\00b\00c\00c\00c\00d\00c\00e\00c\00f\00d\000\00d\001\00d\002\00d\003\00d\004\00d\005\00d\006\00d\007\00d\008\00d\009\00d\00a\00d\00b\00d\00c\00d\00d\00d\00e\00d\00f\00e\000\00e\001\00e\002\00e\003\00e\004\00e\005\00e\006\00e\007\00e\008\00e\009\00e\00a\00e\00b\00e\00c\00e\00d\00e\00e\00e\00f\00f\000\00f\001\00f\002\00f\003\00f\004\00f\005\00f\006\00f\007\00f\008\00f\009\00f\00a\00f\00b\00f\00c\00f\00d\00f\00e\00f\00f")
 (data $30 (i32.const 4460) "\\")
 (data $30.1 (i32.const 4472) "\02\00\00\00H\00\00\000\001\002\003\004\005\006\007\008\009\00a\00b\00c\00d\00e\00f\00g\00h\00i\00j\00k\00l\00m\00n\00o\00p\00q\00r\00s\00t\00u\00v\00w\00x\00y\00z")
 (data $31 (i32.const 4556) "<")
 (data $31.1 (i32.const 4568) "\02\00\00\00 \00\00\00M\00a\00r\00k\00e\00t\00 \00c\00r\00e\00a\00t\00e\00d\00:\00 ")
 (data $32 (i32.const 4620) "|")
 (data $32.1 (i32.const 4632) "\02\00\00\00l\00\00\00c\00a\00n\00\'\00t\00 \00d\00e\00s\00e\00r\00i\00a\00l\00i\00z\00e\00 \00u\008\00 \00f\00r\00o\00m\00 \00g\00i\00v\00e\00n\00 \00a\00r\00g\00u\00m\00e\00n\00t\00:\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $33 (i32.const 4748) "\\")
 (data $33.1 (i32.const 4760) "\02\00\00\00B\00\00\00B\00e\00t\00 \00a\00m\00o\00u\00n\00t\00 \00m\00u\00s\00t\00 \00b\00e\00 \00g\00r\00e\00a\00t\00e\00r\00 \00t\00h\00a\00n\00 \000")
 (data $34 (i32.const 4844) "<")
 (data $34.1 (i32.const 4856) "\02\00\00\00 \00\00\00a\00s\00s\00e\00m\00b\00l\00y\00/\00m\00a\00i\00n\00.\00t\00s")
 (data $35 (i32.const 4908) "\8c")
 (data $35.1 (i32.const 4920) "\02\00\00\00n\00\00\00c\00a\00n\00\'\00t\00 \00d\00e\00s\00e\00r\00i\00a\00l\00i\00z\00e\00 \00i\003\002\00 \00f\00r\00o\00m\00 \00g\00i\00v\00e\00n\00 \00a\00r\00g\00u\00m\00e\00n\00t\00:\00 \00o\00u\00t\00 \00o\00f\00 \00r\00a\00n\00g\00e")
 (data $36 (i32.const 5052) "<")
 (data $36.1 (i32.const 5064) "\02\00\00\00 \00\00\00M\00a\00r\00k\00e\00t\00 \00n\00o\00t\00 \00f\00o\00u\00n\00d")
 (data $37 (i32.const 5116) "<")
 (data $37.1 (i32.const 5128) "\02\00\00\00(\00\00\00M\00a\00r\00k\00e\00t\00 \00i\00s\00 \00n\00o\00t\00 \00a\00c\00t\00i\00v\00e")
 (data $38 (i32.const 5180) "<")
 (data $38.1 (i32.const 5192) "\02\00\00\00 \00\00\00M\00a\00r\00k\00e\00t\00 \00h\00a\00s\00 \00e\00n\00d\00e\00d")
 (data $39 (i32.const 5244) "\1c")
 (data $39.1 (i32.const 5256) "\02\00\00\00\02\00\00\00_")
 (data $40 (i32.const 5276) "\1c")
 (data $40.1 (i32.const 5288) "\02\00\00\00\04\00\00\00U\00P")
 (data $41 (i32.const 5308) "\1c")
 (data $41.1 (i32.const 5320) "\02\00\00\00\08\00\00\00D\00O\00W\00N")
 (data $42 (i32.const 5340) ",")
 (data $42.1 (i32.const 5352) "\02\00\00\00\0e\00\00\00O\00p\00t\00i\00o\00n\00 ")
 (data $43 (i32.const 5388) ",")
 (data $43.1 (i32.const 5400) "\02\00\00\00\18\00\00\00B\00e\00t\00 \00p\00l\00a\00c\00e\00d\00:\00 ")
 (data $44 (i32.const 5436) "\1c")
 (data $44.1 (i32.const 5448) "\02\00\00\00\n\00\00\00 \00b\00e\00t\00 ")
 (data $45 (i32.const 5468) "\1c")
 (data $45.1 (i32.const 5480) "\02\00\00\00\08\00\00\00 \00o\00n\00 ")
 (data $46 (i32.const 5500) ",")
 (data $46.1 (i32.const 5512) "\02\00\00\00\12\00\00\00 \00(\00i\00n\00d\00e\00x\00:\00 ")
 (data $47 (i32.const 5548) ",")
 (data $47.1 (i32.const 5560) "\02\00\00\00\1a\00\00\00)\00 \00f\00o\00r\00 \00m\00a\00r\00k\00e\00t\00 ")
 (data $48 (i32.const 5596) "<\00\00\00\03\00\00\00\00\00\00\00\16\00\00\00(\00\00\00 \15\00\00\00\00\00\00P\15\00\00\00\00\00\00p\15\00\00\00\00\00\00\90\15\00\00\00\00\00\00\c0\15")
 (data $49 (i32.const 5660) "\\")
 (data $49.1 (i32.const 5672) "\02\00\00\00>\00\00\00O\00n\00l\00y\00 \00c\00r\00e\00a\00t\00o\00r\00 \00c\00a\00n\00 \00r\00e\00s\00o\00l\00v\00e\00 \00m\00a\00r\00k\00e\00t")
 (data $50 (i32.const 5756) "L")
 (data $50.1 (i32.const 5768) "\02\00\00\00.\00\00\00M\00a\00r\00k\00e\00t\00 \00a\00l\00r\00e\00a\00d\00y\00 \00r\00e\00s\00o\00l\00v\00e\00d")
 (data $51 (i32.const 5836) "L")
 (data $51.1 (i32.const 5848) "\02\00\00\000\00\00\00M\00a\00r\00k\00e\00t\00 \00h\00a\00s\00 \00n\00o\00t\00 \00e\00n\00d\00e\00d\00 \00y\00e\00t")
 (data $52 (i32.const 5916) "<")
 (data $52.1 (i32.const 5928) "\02\00\00\00\"\00\00\00M\00a\00r\00k\00e\00t\00 \00r\00e\00s\00o\00l\00v\00e\00d\00:\00 ")
 (data $53 (i32.const 5980) ",")
 (data $53.1 (i32.const 5992) "\02\00\00\00\16\00\00\00 \00-\00 \00W\00i\00n\00n\00e\00r\00:\00 ")
 (data $54 (i32.const 6028) ",")
 (data $54.1 (i32.const 6040) "\02\00\00\00\12\00\00\00,\00 \00P\00r\00i\00c\00e\00:\00 ")
 (data $55 (i32.const 6076) ",\00\00\00\03\00\00\00\00\00\00\00\16\00\00\00\18\00\00\000\17\00\00\00\00\00\00p\17\00\00\00\00\00\00\a0\17")
 (data $56 (i32.const 6124) "L")
 (data $56.1 (i32.const 6136) "\02\00\00\004\00\00\00M\00a\00r\00k\00e\00t\00 \00i\00s\00 \00n\00o\00t\00 \00r\00e\00s\00o\00l\00v\00e\00d\00 \00y\00e\00t")
 (data $57 (i32.const 6204) "L")
 (data $57.1 (i32.const 6216) "\02\00\00\004\00\00\00N\00o\00 \00b\00e\00t\00 \00f\00o\00u\00n\00d\00 \00f\00o\00r\00 \00t\00h\00i\00s\00 \00u\00s\00e\00r")
 (data $58 (i32.const 6284) "<")
 (data $58.1 (i32.const 6296) "\02\00\00\00,\00\00\00R\00e\00w\00a\00r\00d\00 \00a\00l\00r\00e\00a\00d\00y\00 \00c\00l\00a\00i\00m\00e\00d")
 (data $59 (i32.const 6348) "L")
 (data $59.1 (i32.const 6360) "\02\00\00\008\00\00\00U\00s\00e\00r\00 \00d\00i\00d\00 \00n\00o\00t\00 \00w\00i\00n\00 \00t\00h\00i\00s\00 \00m\00a\00r\00k\00e\00t")
 (data $60 (i32.const 6428) "<")
 (data $60.1 (i32.const 6440) "\02\00\00\00\1e\00\00\00N\00o\00 \00w\00i\00n\00n\00i\00n\00g\00 \00p\00o\00o\00l")
 (data $61 (i32.const 6492) "<")
 (data $61.1 (i32.const 6504) "\02\00\00\00 \00\00\00R\00e\00w\00a\00r\00d\00 \00c\00l\00a\00i\00m\00e\00d\00:\00 ")
 (data $62 (i32.const 6556) ",")
 (data $62.1 (i32.const 6568) "\02\00\00\00\14\00\00\00 \00r\00e\00c\00e\00i\00v\00e\00d\00 ")
 (data $63 (i32.const 6604) ",")
 (data $63.1 (i32.const 6616) "\02\00\00\00\1a\00\00\00 \00f\00r\00o\00m\00 \00m\00a\00r\00k\00e\00t\00 ")
 (data $64 (i32.const 6652) ",\00\00\00\03\00\00\00\00\00\00\00\16\00\00\00\18\00\00\00p\19\00\00\00\00\00\00\b0\19\00\00\00\00\00\00\e0\19")
 (data $65 (i32.const 6700) ",")
 (data $65.1 (i32.const 6712) "\02\00\00\00\1a\00\00\00B\00e\00t\00 \00n\00o\00t\00 \00f\00o\00u\00n\00d")
 (table $0 2 2 funcref)
 (elem $0 (i32.const 1) $~lib/@massalabs/massa-as-sdk/assembly/std/utils/address/json2Address~anonymous|0)
 (export "createMarket" (func $assembly/main/createMarket))
 (export "placeBet" (func $assembly/main/placeBet))
 (export "resolveMarket" (func $assembly/main/resolveMarket))
 (export "claimReward" (func $assembly/main/claimReward))
 (export "getMarketDetails" (func $assembly/main/getMarketDetails))
 (export "getUserBetDetails" (func $assembly/main/getUserBetDetails))
 (export "getMarketCount" (func $assembly/main/getMarketCount))
 (export "memory" (memory $0))
 (start $~start)
 (func $~lib/rt/stub/__alloc (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1056
   i32.const 1120
   i32.const 33
   i32.const 29
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/stub/offset
  local.set $1
  global.get $~lib/rt/stub/offset
  i32.const 4
  i32.add
  local.tee $2
  local.get $0
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.tee $0
  i32.add
  local.tee $3
  memory.size
  local.tee $4
  i32.const 16
  i32.shl
  i32.const 15
  i32.add
  i32.const -16
  i32.and
  local.tee $5
  i32.gt_u
  if
   local.get $4
   local.get $3
   local.get $5
   i32.sub
   i32.const 65535
   i32.add
   i32.const -65536
   i32.and
   i32.const 16
   i32.shr_u
   local.tee $5
   local.get $4
   local.get $5
   i32.gt_s
   select
   memory.grow
   i32.const 0
   i32.lt_s
   if
    local.get $5
    memory.grow
    i32.const 0
    i32.lt_s
    if
     unreachable
    end
   end
  end
  local.get $3
  global.set $~lib/rt/stub/offset
  local.get $1
  local.get $0
  i32.store
  local.get $2
 )
 (func $~lib/rt/stub/__new (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.const 1073741804
  i32.gt_u
  if
   i32.const 1056
   i32.const 1120
   i32.const 86
   i32.const 30
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 16
  i32.add
  call $~lib/rt/stub/__alloc
  local.tee $3
  i32.const 4
  i32.sub
  local.tee $2
  i32.const 0
  i32.store offset=4
  local.get $2
  i32.const 0
  i32.store offset=8
  local.get $2
  local.get $1
  i32.store offset=12
  local.get $2
  local.get $0
  i32.store offset=16
  local.get $3
  i32.const 16
  i32.add
 )
 (func $~lib/staticarray/StaticArray<u8>#constructor (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1184
   i32.const 1232
   i32.const 51
   i32.const 60
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 5
  call $~lib/rt/stub/__new
  local.tee $1
  i32.const 0
  local.get $0
  memory.fill
  local.get $1
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#constructor (param $0 i32) (result i32)
  (local $1 i32)
  i32.const 8
  i32.const 4
  call $~lib/rt/stub/__new
  local.tee $1
  i32.const 0
  i32.store
  local.get $1
  i32.const 0
  call $~lib/staticarray/StaticArray<u8>#constructor
  i32.store offset=4
  local.get $1
  local.get $0
  i32.store offset=4
  local.get $1
  i32.const 0
  i32.store
  local.get $1
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#constructor@varargs (result i32)
  (local $0 i32)
  block $2of2
   block $0of2
    block $outOfRange
     global.get $~argumentsLength
     br_table $0of2 $2of2 $2of2 $outOfRange
    end
    unreachable
   end
   i32.const 0
   i32.const 5
   call $~lib/rt/stub/__new
   local.tee $0
   i32.const 1296
   i32.const 0
   memory.copy
  end
  local.get $0
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
 )
 (func $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.eqz
  if
   i32.const 0
   i32.const 5
   call $~lib/rt/stub/__new
   local.tee $0
   i32.const 1520
   i32.const 0
   memory.copy
   local.get $0
   return
  end
  local.get $0
  local.set $2
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  local.get $0
  i32.add
  local.set $3
  loop $while-continue|0
   local.get $2
   local.get $3
   i32.lt_u
   if
    local.get $2
    i32.load16_u
    local.tee $4
    i32.const 128
    i32.lt_u
    if (result i32)
     local.get $1
     i32.const 1
     i32.add
    else
     local.get $4
     i32.const 2048
     i32.lt_u
     if (result i32)
      local.get $1
      i32.const 2
      i32.add
     else
      local.get $4
      i32.const 64512
      i32.and
      i32.const 55296
      i32.eq
      local.get $2
      i32.const 2
      i32.add
      local.get $3
      i32.lt_u
      i32.and
      if
       local.get $2
       i32.load16_u offset=2
       i32.const 64512
       i32.and
       i32.const 56320
       i32.eq
       if
        local.get $1
        i32.const 4
        i32.add
        local.set $1
        local.get $2
        i32.const 4
        i32.add
        local.set $2
        br $while-continue|0
       end
      end
      local.get $1
      i32.const 3
      i32.add
     end
    end
    local.set $1
    local.get $2
    i32.const 2
    i32.add
    local.set $2
    br $while-continue|0
   end
  end
  local.get $1
  i32.const 1
  call $~lib/rt/stub/__new
  local.set $2
  local.get $0
  local.tee $1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  i32.add
  local.set $4
  local.get $2
  local.set $0
  loop $while-continue|00
   local.get $1
   local.get $4
   i32.lt_u
   if
    local.get $1
    i32.load16_u
    local.tee $5
    i32.const 128
    i32.lt_u
    if (result i32)
     local.get $0
     local.get $5
     i32.store8
     local.get $0
     i32.const 1
     i32.add
    else
     local.get $5
     i32.const 2048
     i32.lt_u
     if (result i32)
      local.get $0
      local.get $5
      i32.const 6
      i32.shr_u
      i32.const 192
      i32.or
      local.get $5
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.const 8
      i32.shl
      i32.or
      i32.store16
      local.get $0
      i32.const 2
      i32.add
     else
      local.get $5
      i32.const 63488
      i32.and
      i32.const 55296
      i32.eq
      if
       local.get $5
       i32.const 56320
       i32.lt_u
       local.get $1
       i32.const 2
       i32.add
       local.get $4
       i32.lt_u
       i32.and
       if
        local.get $1
        i32.load16_u offset=2
        local.tee $3
        i32.const 64512
        i32.and
        i32.const 56320
        i32.eq
        if
         local.get $0
         local.get $5
         i32.const 1023
         i32.and
         i32.const 10
         i32.shl
         i32.const 65536
         i32.add
         local.get $3
         i32.const 1023
         i32.and
         i32.or
         local.tee $3
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 24
         i32.shl
         local.get $3
         i32.const 6
         i32.shr_u
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 16
         i32.shl
         i32.or
         local.get $3
         i32.const 12
         i32.shr_u
         i32.const 63
         i32.and
         i32.const 128
         i32.or
         i32.const 8
         i32.shl
         i32.or
         local.get $3
         i32.const 18
         i32.shr_u
         i32.const 240
         i32.or
         i32.or
         i32.store
         local.get $0
         i32.const 4
         i32.add
         local.set $0
         local.get $1
         i32.const 4
         i32.add
         local.set $1
         br $while-continue|00
        end
       end
       i32.const 1552
       i32.const 1616
       i32.const 742
       i32.const 49
       call $~lib/builtins/abort
       unreachable
      end
      local.get $0
      local.get $5
      i32.const 12
      i32.shr_u
      i32.const 224
      i32.or
      local.get $5
      i32.const 6
      i32.shr_u
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.const 8
      i32.shl
      i32.or
      i32.store16
      local.get $0
      local.get $5
      i32.const 63
      i32.and
      i32.const 128
      i32.or
      i32.store8 offset=2
      local.get $0
      i32.const 3
      i32.add
     end
    end
    local.set $0
    local.get $1
    i32.const 2
    i32.add
    local.set $1
    br $while-continue|00
   end
  end
  local.get $2
 )
 (func $~lib/rt/__newArray (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  local.get $0
  local.get $1
  i32.shl
  local.tee $1
  i32.const 1
  call $~lib/rt/stub/__new
  local.set $3
  i32.const 16
  local.get $2
  call $~lib/rt/stub/__new
  local.tee $2
  local.get $3
  i32.store
  local.get $2
  local.get $3
  i32.store offset=4
  local.get $2
  local.get $1
  i32.store offset=8
  local.get $2
  local.get $0
  i32.store offset=12
  local.get $2
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#getNextData (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  i32.load
  local.tee $2
  local.get $1
  i32.add
  local.set $3
  local.get $0
  i32.load offset=4
  local.tee $4
  i32.const 20
  i32.sub
  i32.load offset=16
  local.set $5
  local.get $2
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $2
   local.get $5
   i32.add
   local.tee $2
   i32.const 0
   local.get $2
   i32.const 0
   i32.gt_s
   select
  else
   local.get $2
   local.get $5
   local.get $2
   local.get $5
   i32.lt_s
   select
  end
  local.set $2
  local.get $3
  i32.const 0
  i32.lt_s
  if (result i32)
   local.get $3
   local.get $5
   i32.add
   local.tee $3
   i32.const 0
   local.get $3
   i32.const 0
   i32.gt_s
   select
  else
   local.get $3
   local.get $5
   local.get $3
   local.get $5
   i32.lt_s
   select
  end
  local.get $2
  i32.sub
  local.tee $3
  i32.const 0
  local.get $3
  i32.const 0
  i32.gt_s
  select
  local.tee $3
  i32.const 0
  i32.const 9
  call $~lib/rt/__newArray
  local.tee $5
  i32.load offset=4
  local.get $2
  local.get $4
  i32.add
  local.get $3
  memory.copy
  local.get $5
  i32.load offset=4
  local.set $2
  local.get $0
  local.get $0
  i32.load
  local.get $1
  i32.add
  i32.store
  local.get $2
 )
 (func $~lib/rt/stub/__renew (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $1
  i32.const 1073741804
  i32.gt_u
  if
   i32.const 1056
   i32.const 1120
   i32.const 99
   i32.const 30
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 16
  i32.sub
  local.tee $0
  i32.const 15
  i32.and
  i32.const 1
  local.get $0
  select
  if
   i32.const 0
   i32.const 1120
   i32.const 45
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  global.get $~lib/rt/stub/offset
  local.get $0
  i32.const 4
  i32.sub
  local.tee $3
  i32.load
  local.tee $4
  local.get $0
  i32.add
  i32.eq
  local.set $5
  local.get $1
  i32.const 16
  i32.add
  local.tee $6
  i32.const 19
  i32.add
  i32.const -16
  i32.and
  i32.const 4
  i32.sub
  local.set $2
  local.get $4
  local.get $6
  i32.lt_u
  if
   local.get $5
   if
    local.get $6
    i32.const 1073741820
    i32.gt_u
    if
     i32.const 1056
     i32.const 1120
     i32.const 52
     i32.const 33
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i32.add
    local.tee $4
    memory.size
    local.tee $5
    i32.const 16
    i32.shl
    i32.const 15
    i32.add
    i32.const -16
    i32.and
    local.tee $6
    i32.gt_u
    if
     local.get $5
     local.get $4
     local.get $6
     i32.sub
     i32.const 65535
     i32.add
     i32.const -65536
     i32.and
     i32.const 16
     i32.shr_u
     local.tee $6
     local.get $5
     local.get $6
     i32.gt_s
     select
     memory.grow
     i32.const 0
     i32.lt_s
     if
      local.get $6
      memory.grow
      i32.const 0
      i32.lt_s
      if
       unreachable
      end
     end
    end
    local.get $4
    global.set $~lib/rt/stub/offset
    local.get $3
    local.get $2
    i32.store
   else
    local.get $2
    local.get $4
    i32.const 1
    i32.shl
    local.tee $3
    local.get $2
    local.get $3
    i32.gt_u
    select
    call $~lib/rt/stub/__alloc
    local.tee $2
    local.get $0
    local.get $4
    memory.copy
    local.get $2
    local.set $0
   end
  else
   local.get $5
   if
    local.get $0
    local.get $2
    i32.add
    global.set $~lib/rt/stub/offset
    local.get $3
    local.get $2
    i32.store
   end
  end
  local.get $0
  i32.const 4
  i32.sub
  local.get $1
  i32.store offset=16
  local.get $0
  i32.const 16
  i32.add
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#nextString (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  block $__inlined_func$~lib/@massalabs/as-types/assembly/argument/Args#nextU32$465
   local.get $0
   local.tee $1
   i32.load offset=4
   i32.const 20
   i32.sub
   i32.load offset=16
   local.get $0
   i32.load
   i32.const 4
   i32.add
   i32.lt_s
   if
    i32.const 8
    i32.const 8
    call $~lib/rt/stub/__new
    local.tee $0
    i32.const 0
    i32.store
    local.get $0
    i32.const 1792
    i32.store offset=4
    br $__inlined_func$~lib/@massalabs/as-types/assembly/argument/Args#nextU32$465
   end
   local.get $1
   i32.const 4
   call $~lib/@massalabs/as-types/assembly/argument/Args#getNextData
   i32.load
   local.set $2
   i32.const 8
   i32.const 8
   call $~lib/rt/stub/__new
   local.tee $0
   local.get $2
   i32.store
   local.get $0
   i32.const 0
   i32.store offset=4
  end
  block $folding-inner1
   block $folding-inner0
    local.get $0
    i32.load offset=4
    local.tee $2
    if (result i32)
     local.get $2
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if (result i32)
     i32.const 1
    else
     local.get $1
     i32.load
     local.set $2
     local.get $0
     i32.load offset=4
     local.tee $3
     if (result i32)
      local.get $3
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $0
      i32.load offset=4
      local.tee $0
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     i32.load offset=4
     i32.const 20
     i32.sub
     i32.load offset=16
     local.get $2
     local.get $0
     i32.load
     i32.add
     i32.lt_s
    end
    if
     i32.const 8
     i32.const 7
     call $~lib/rt/stub/__new
     local.tee $0
     i32.const 2176
     i32.store
     local.get $0
     i32.const 2208
     i32.store offset=4
     local.get $0
     return
    end
    block $__inlined_func$~lib/@massalabs/as-types/assembly/serialization/strings/bytesToString$51 (result i32)
     local.get $0
     i32.load offset=4
     local.tee $2
     if (result i32)
      local.get $2
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $0
      i32.load offset=4
      local.tee $0
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     i32.const 2176
     local.get $1
     local.get $0
     i32.load
     call $~lib/@massalabs/as-types/assembly/argument/Args#getNextData
     local.tee $0
     i32.const 20
     i32.sub
     i32.load offset=16
     local.tee $1
     i32.eqz
     br_if $__inlined_func$~lib/@massalabs/as-types/assembly/serialization/strings/bytesToString$51
     drop
     local.get $0
     local.get $1
     i32.add
     local.tee $3
     local.get $0
     i32.lt_u
     if
      i32.const 0
      i32.const 1616
      i32.const 770
      i32.const 7
      call $~lib/builtins/abort
      unreachable
     end
     local.get $1
     i32.const 1
     i32.shl
     i32.const 2
     call $~lib/rt/stub/__new
     local.tee $5
     local.set $2
     loop $while-continue|0
      local.get $0
      local.get $3
      i32.lt_u
      if
       block $while-break|0
        local.get $0
        i32.load8_u
        local.set $4
        local.get $0
        i32.const 1
        i32.add
        local.set $0
        local.get $4
        i32.const 128
        i32.and
        if
         local.get $0
         local.get $3
         i32.eq
         br_if $while-break|0
         local.get $0
         i32.load8_u
         i32.const 63
         i32.and
         local.set $6
         local.get $0
         i32.const 1
         i32.add
         local.set $0
         local.get $4
         i32.const 224
         i32.and
         i32.const 192
         i32.eq
         if
          local.get $2
          local.get $4
          i32.const 31
          i32.and
          i32.const 6
          i32.shl
          local.get $6
          i32.or
          i32.store16
         else
          local.get $0
          local.get $3
          i32.eq
          br_if $while-break|0
          local.get $0
          i32.load8_u
          i32.const 63
          i32.and
          local.set $1
          local.get $0
          i32.const 1
          i32.add
          local.set $0
          local.get $4
          i32.const 240
          i32.and
          i32.const 224
          i32.eq
          if
           local.get $4
           i32.const 15
           i32.and
           i32.const 12
           i32.shl
           local.get $6
           i32.const 6
           i32.shl
           i32.or
           local.get $1
           i32.or
           local.set $1
          else
           local.get $0
           local.get $3
           i32.eq
           br_if $while-break|0
           local.get $0
           i32.load8_u
           i32.const 63
           i32.and
           local.get $4
           i32.const 7
           i32.and
           i32.const 18
           i32.shl
           local.get $6
           i32.const 12
           i32.shl
           i32.or
           local.get $1
           i32.const 6
           i32.shl
           i32.or
           i32.or
           local.set $1
           local.get $0
           i32.const 1
           i32.add
           local.set $0
          end
          local.get $1
          i32.const 65536
          i32.lt_u
          if
           local.get $2
           local.get $1
           i32.store16
          else
           local.get $2
           local.get $1
           i32.const 65536
           i32.sub
           local.tee $1
           i32.const 10
           i32.shr_u
           i32.const 55296
           i32.or
           local.get $1
           i32.const 1023
           i32.and
           i32.const 56320
           i32.or
           i32.const 16
           i32.shl
           i32.or
           i32.store
           local.get $2
           i32.const 2
           i32.add
           local.set $2
          end
         end
        else
         local.get $2
         local.get $4
         i32.store16
        end
        local.get $2
        i32.const 2
        i32.add
        local.set $2
        br $while-continue|0
       end
      end
     end
     local.get $5
     local.get $2
     local.get $5
     i32.sub
     call $~lib/rt/stub/__renew
    end
    local.set $0
    i32.const 8
    i32.const 7
    call $~lib/rt/stub/__new
    local.tee $1
    local.get $0
    i32.store
    local.get $1
    i32.const 0
    i32.store offset=4
    local.get $1
    return
   end
   i32.const 1936
   i32.const 2064
   i32.const 70
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#nextU64 (param $0 i32) (result i32)
  (local $1 i64)
  local.get $0
  i32.load offset=4
  i32.const 20
  i32.sub
  i32.load offset=16
  local.get $0
  i32.load
  i32.const 8
  i32.add
  i32.lt_s
  if
   i32.const 12
   i32.const 11
   call $~lib/rt/stub/__new
   local.tee $0
   i64.const 0
   i64.store
   local.get $0
   i32.const 2352
   i32.store offset=8
   local.get $0
   return
  end
  local.get $0
  i32.const 8
  call $~lib/@massalabs/as-types/assembly/argument/Args#getNextData
  i64.load
  local.set $1
  i32.const 12
  i32.const 11
  call $~lib/rt/stub/__new
  local.tee $0
  local.get $1
  i64.store
  local.get $0
  i32.const 0
  i32.store offset=8
  local.get $0
 )
 (func $~lib/string/String#substring (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  i32.const 1
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.tee $2
  local.get $2
  i32.const 1
  i32.gt_u
  select
  local.tee $3
  local.get $1
  i32.const 0
  local.get $1
  i32.const 0
  i32.gt_s
  select
  local.tee $1
  local.get $2
  local.get $1
  local.get $2
  i32.lt_s
  select
  local.tee $1
  local.get $1
  local.get $3
  i32.gt_s
  select
  i32.const 1
  i32.shl
  local.set $4
  local.get $3
  local.get $1
  local.get $1
  local.get $3
  i32.lt_s
  select
  i32.const 1
  i32.shl
  local.tee $1
  local.get $4
  i32.sub
  local.tee $3
  i32.eqz
  if
   i32.const 2176
   return
  end
  local.get $4
  i32.eqz
  local.get $1
  local.get $2
  i32.const 1
  i32.shl
  i32.eq
  i32.and
  if
   local.get $0
   return
  end
  local.get $3
  i32.const 2
  call $~lib/rt/stub/__new
  local.tee $1
  local.get $0
  local.get $4
  i32.add
  local.get $3
  memory.copy
  local.get $1
 )
 (func $~lib/util/string/compareImpl (param $0 i32) (param $1 i32) (param $2 i32) (param $3 i32) (result i32)
  (local $4 i32)
  local.get $0
  local.get $1
  i32.const 1
  i32.shl
  i32.add
  local.set $1
  local.get $3
  i32.const 4
  i32.ge_u
  if (result i32)
   local.get $1
   i32.const 7
   i32.and
   local.get $2
   i32.const 7
   i32.and
   i32.or
  else
   i32.const 1
  end
  i32.eqz
  if
   loop $do-loop|0
    local.get $1
    i64.load
    local.get $2
    i64.load
    i64.eq
    if
     local.get $1
     i32.const 8
     i32.add
     local.set $1
     local.get $2
     i32.const 8
     i32.add
     local.set $2
     local.get $3
     i32.const 4
     i32.sub
     local.tee $3
     i32.const 4
     i32.ge_u
     br_if $do-loop|0
    end
   end
  end
  loop $while-continue|1
   local.get $3
   local.tee $0
   i32.const 1
   i32.sub
   local.set $3
   local.get $0
   if
    local.get $1
    i32.load16_u
    local.tee $0
    local.get $2
    i32.load16_u
    local.tee $4
    i32.ne
    if
     local.get $0
     local.get $4
     i32.sub
     return
    end
    local.get $1
    i32.const 2
    i32.add
    local.set $1
    local.get $2
    i32.const 2
    i32.add
    local.set $2
    br $while-continue|1
   end
  end
  i32.const 0
 )
 (func $~lib/array/Array<~lib/string/String>#push (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  local.get $0
  i32.load offset=12
  local.tee $3
  i32.const 1
  i32.add
  local.tee $4
  local.get $0
  i32.load offset=8
  local.tee $2
  i32.const 2
  i32.shr_u
  i32.gt_u
  if
   local.get $4
   i32.const 268435455
   i32.gt_u
   if
    i32.const 1184
    i32.const 2592
    i32.const 19
    i32.const 48
    call $~lib/builtins/abort
    unreachable
   end
   local.get $2
   local.get $0
   i32.load
   local.tee $5
   i32.const 1073741820
   local.get $2
   i32.const 1
   i32.shl
   local.tee $6
   local.get $6
   i32.const 1073741820
   i32.ge_u
   select
   local.tee $6
   i32.const 8
   local.get $4
   local.get $4
   i32.const 8
   i32.le_u
   select
   i32.const 2
   i32.shl
   local.tee $7
   local.get $6
   local.get $7
   i32.gt_u
   select
   local.tee $6
   call $~lib/rt/stub/__renew
   local.tee $7
   i32.add
   i32.const 0
   local.get $6
   local.get $2
   i32.sub
   memory.fill
   local.get $5
   local.get $7
   i32.ne
   if
    local.get $0
    local.get $7
    i32.store
    local.get $0
    local.get $7
    i32.store offset=4
   end
   local.get $0
   local.get $6
   i32.store offset=8
  end
  local.get $0
  i32.load offset=4
  local.get $3
  i32.const 2
  i32.shl
  i32.add
  local.get $1
  i32.store
  local.get $0
  local.get $4
  i32.store offset=12
 )
 (func $~lib/string/String#split (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  (local $8 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  local.set $5
  block $folding-inner0
   i32.const 2492
   i32.load
   i32.const 1
   i32.shr_u
   local.tee $6
   if
    local.get $5
    i32.eqz
    if
     i32.const 1
     i32.const 2
     i32.const 15
     call $~lib/rt/__newArray
     local.tee $0
     i32.load offset=4
     i32.const 2176
     i32.store
     local.get $0
     return
    end
   else
    local.get $5
    i32.eqz
    br_if $folding-inner0
    i32.const 2147483647
    local.get $5
    local.get $5
    i32.const 2147483647
    i32.eq
    select
    local.tee $2
    i32.const 2
    i32.const 15
    call $~lib/rt/__newArray
    local.tee $3
    i32.load offset=4
    local.set $4
    loop $for-loop|0
     local.get $1
     local.get $2
     i32.lt_s
     if
      i32.const 2
      i32.const 2
      call $~lib/rt/stub/__new
      local.tee $5
      local.get $0
      local.get $1
      i32.const 1
      i32.shl
      i32.add
      i32.load16_u
      i32.store16
      local.get $4
      local.get $1
      i32.const 2
      i32.shl
      i32.add
      local.get $5
      i32.store
      local.get $1
      i32.const 1
      i32.add
      local.set $1
      br $for-loop|0
     end
    end
    local.get $3
    return
   end
   i32.const 0
   i32.const 2
   i32.const 15
   call $~lib/rt/__newArray
   local.set $4
   loop $while-continue|1
    i32.const 0
    local.set $1
    block $__inlined_func$~lib/string/String#indexOf$71
     i32.const 2492
     i32.load
     i32.const 1
     i32.shr_u
     local.tee $7
     i32.eqz
     br_if $__inlined_func$~lib/string/String#indexOf$71
     i32.const -1
     local.set $1
     local.get $0
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
     local.tee $8
     i32.eqz
     br_if $__inlined_func$~lib/string/String#indexOf$71
     local.get $2
     i32.const 0
     local.get $2
     i32.const 0
     i32.gt_s
     select
     local.tee $1
     local.get $8
     local.get $1
     local.get $8
     i32.lt_s
     select
     local.set $1
     local.get $8
     local.get $7
     i32.sub
     local.set $8
     loop $for-loop|00
      local.get $1
      local.get $8
      i32.le_s
      if
       local.get $0
       local.get $1
       i32.const 2496
       local.get $7
       call $~lib/util/string/compareImpl
       i32.eqz
       br_if $__inlined_func$~lib/string/String#indexOf$71
       local.get $1
       i32.const 1
       i32.add
       local.set $1
       br $for-loop|00
      end
     end
     i32.const -1
     local.set $1
    end
    local.get $1
    i32.const -1
    i32.xor
    if
     local.get $1
     local.get $2
     i32.sub
     local.tee $7
     i32.const 0
     i32.gt_s
     if
      local.get $7
      i32.const 1
      i32.shl
      local.tee $7
      i32.const 2
      call $~lib/rt/stub/__new
      local.tee $8
      local.get $0
      local.get $2
      i32.const 1
      i32.shl
      i32.add
      local.get $7
      memory.copy
      local.get $4
      local.get $8
      call $~lib/array/Array<~lib/string/String>#push
     else
      local.get $4
      i32.const 2176
      call $~lib/array/Array<~lib/string/String>#push
     end
     local.get $3
     i32.const 1
     i32.add
     local.tee $3
     i32.const 2147483647
     i32.eq
     if
      local.get $4
      return
     end
     local.get $1
     local.get $6
     i32.add
     local.set $2
     br $while-continue|1
    end
   end
   local.get $2
   i32.eqz
   if
    local.get $4
    local.get $0
    call $~lib/array/Array<~lib/string/String>#push
    local.get $4
    return
   end
   local.get $5
   local.get $2
   i32.sub
   local.tee $1
   i32.const 0
   i32.gt_s
   if
    local.get $1
    i32.const 1
    i32.shl
    local.tee $1
    i32.const 2
    call $~lib/rt/stub/__new
    local.tee $3
    local.get $0
    local.get $2
    i32.const 1
    i32.shl
    i32.add
    local.get $1
    memory.copy
    local.get $4
    local.get $3
    call $~lib/array/Array<~lib/string/String>#push
   else
    local.get $4
    i32.const 2176
    call $~lib/array/Array<~lib/string/String>#push
   end
   local.get $4
   return
  end
  i32.const 0
  i32.const 2
  i32.const 15
  call $~lib/rt/__newArray
 )
 (func $~lib/@massalabs/massa-as-sdk/assembly/std/utils/address/json2Address~anonymous|0 (param $0 i32) (param $1 i32) (param $2 i32) (result i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 1
  i32.sub
  call $~lib/string/String#substring
  local.set $1
  i32.const 4
  i32.const 12
  call $~lib/rt/stub/__new
  local.tee $0
  local.get $1
  i32.store
  local.get $0
 )
 (func $~lib/@massalabs/massa-as-sdk/assembly/std/utils/address/json2Address (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  local.get $0
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const 1
  i32.shr_u
  i32.const 1
  i32.sub
  call $~lib/string/String#substring
  local.set $0
  i32.const 1
  global.set $~argumentsLength
  local.get $0
  call $~lib/string/String#split
  local.tee $1
  i32.load offset=12
  local.tee $2
  i32.const 2
  i32.const 14
  call $~lib/rt/__newArray
  local.tee $3
  i32.load offset=4
  local.set $4
  i32.const 0
  local.set $0
  loop $for-loop|0
   local.get $0
   local.get $2
   local.get $1
   i32.load offset=12
   local.tee $5
   local.get $2
   local.get $5
   i32.lt_s
   select
   i32.lt_s
   if
    local.get $0
    i32.const 2
    i32.shl
    local.tee $5
    local.get $1
    i32.load offset=4
    i32.add
    i32.load
    local.set $6
    i32.const 3
    global.set $~argumentsLength
    local.get $4
    local.get $5
    i32.add
    local.get $6
    local.get $0
    local.get $1
    i32.const 2640
    i32.load
    call_indirect (type $5)
    i32.store
    local.get $0
    i32.const 1
    i32.add
    local.set $0
    br $for-loop|0
   end
  end
  local.get $3
 )
 (func $~lib/array/Array<~lib/@massalabs/massa-as-sdk/assembly/std/address/Address>#__get (param $0 i32) (param $1 i32) (result i32)
  local.get $1
  local.get $0
  i32.load offset=12
  i32.ge_u
  if
   i32.const 2528
   i32.const 2592
   i32.const 114
   i32.const 42
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=4
  local.get $1
  i32.const 2
  i32.shl
  i32.add
  i32.load
  local.tee $0
  i32.eqz
  if
   i32.const 2672
   i32.const 2592
   i32.const 118
   i32.const 40
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
 )
 (func $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller (result i32)
  (local $0 i32)
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.callStack
  call $~lib/@massalabs/massa-as-sdk/assembly/std/utils/address/json2Address
  local.tee $0
  i32.load offset=12
  i32.const 2
  i32.lt_s
  if (result i32)
   call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.callStack
   call $~lib/@massalabs/massa-as-sdk/assembly/std/utils/address/json2Address
   local.tee $0
   local.get $0
   i32.load offset=12
   i32.const 1
   i32.sub
   call $~lib/array/Array<~lib/@massalabs/massa-as-sdk/assembly/std/address/Address>#__get
  else
   local.get $0
   local.get $0
   i32.load offset=12
   i32.const 2
   i32.sub
   call $~lib/array/Array<~lib/@massalabs/massa-as-sdk/assembly/std/address/Address>#__get
  end
 )
 (func $assembly/main/Market#constructor (param $0 i64) (param $1 i32) (param $2 i32) (param $3 i32) (param $4 i64) (result i32)
  (local $5 i32)
  i32.const 80
  i32.const 17
  call $~lib/rt/stub/__new
  local.tee $5
  i64.const 0
  i64.store
  local.get $5
  i32.const 0
  i32.store offset=8
  local.get $5
  i32.const 0
  i32.store offset=12
  local.get $5
  i32.const 0
  i32.store offset=16
  local.get $5
  i64.const 0
  i64.store offset=24
  local.get $5
  i32.const 0
  i32.store offset=32
  local.get $5
  i64.const 0
  i64.store offset=40
  local.get $5
  i64.const 0
  i64.store offset=48
  local.get $5
  i32.const 0
  i32.store offset=56
  local.get $5
  i64.const 0
  i64.store offset=64
  local.get $5
  i64.const 0
  i64.store offset=72
  local.get $5
  local.get $0
  i64.store
  local.get $5
  local.get $1
  i32.store offset=8
  local.get $5
  local.get $2
  i32.store offset=12
  local.get $5
  local.get $3
  i32.store offset=16
  local.get $5
  local.get $4
  i64.store offset=24
  local.get $5
  i32.const 0
  i32.store offset=32
  local.get $5
  i64.const 0
  i64.store offset=40
  local.get $5
  i64.const 0
  i64.store offset=48
  local.get $5
  i32.const -1
  i32.store offset=56
  local.get $5
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time
  i64.store offset=64
  local.get $5
  i64.const 0
  i64.store offset=72
  local.get $5
 )
 (func $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>> (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  local.tee $2
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  local.tee $3
  i32.add
  local.tee $4
  i32.const 1073741820
  i32.gt_u
  if
   i32.const 1184
   i32.const 1232
   i32.const 178
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.const 5
  call $~lib/rt/stub/__new
  local.tee $4
  local.get $0
  local.get $2
  memory.copy
  local.get $2
  local.get $4
  i32.add
  local.get $1
  local.get $3
  memory.copy
  local.get $4
 )
 (func $"~lib/@massalabs/as-types/assembly/argument/Args#add<u32,void>" (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=4
  local.set $2
  i32.const 4
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $3
  local.get $1
  i32.store
  local.get $0
  local.get $2
  local.get $3
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
 )
 (func $"~lib/@massalabs/as-types/assembly/argument/Args#add<~lib/string/String,void>" (param $0 i32) (param $1 i32)
  local.get $0
  local.get $1
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  local.tee $1
  i32.const 20
  i32.sub
  i32.load offset=16
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<u32,void>"
  local.get $0
  local.get $0
  i32.load offset=4
  local.get $1
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
 )
 (func $~lib/staticarray/StaticArray<u8>#__set (param $0 i32) (param $1 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.eqz
  if
   i32.const 2528
   i32.const 1232
   i32.const 93
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.store8
 )
 (func $"~lib/@massalabs/as-types/assembly/argument/Args#add<u8,void>" (param $0 i32) (param $1 i32)
  (local $2 i32)
  (local $3 i32)
  local.get $0
  i32.load offset=4
  local.set $2
  i32.const 1
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $3
  local.get $1
  call $~lib/staticarray/StaticArray<u8>#__set
  local.get $0
  local.get $2
  local.get $3
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
 )
 (func $assembly/main/Market#serialize (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  i32.const 0
  global.set $~argumentsLength
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor@varargs
  local.set $1
  local.get $0
  i64.load
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  local.get $0
  i32.load offset=8
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<~lib/string/String,void>"
  local.get $1
  local.get $0
  i32.load offset=12
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<~lib/string/String,void>"
  local.get $1
  local.get $0
  i32.load offset=16
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<~lib/string/String,void>"
  local.get $0
  i64.load offset=24
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  local.get $0
  i32.load offset=32
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<u8,void>"
  local.get $0
  i64.load offset=40
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $0
  i64.load offset=48
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  local.get $0
  i32.load offset=56
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<u32,void>"
  local.get $0
  i64.load offset=64
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $0
  i64.load offset=72
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $0
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $3
  local.get $2
  i64.store
  local.get $1
  local.get $0
  local.get $3
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  i32.load offset=4
 )
 (func $assembly/main/saveMarket (param $0 i32)
  (local $1 i64)
  (local $2 i32)
  global.get $assembly/main/MARKET_PREFIX
  local.get $0
  i64.load
  local.set $1
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $2
  local.get $1
  i64.store
  local.get $2
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  local.get $0
  call $assembly/main/Market#serialize
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set
 )
 (func $~lib/util/number/utoa32_dec_lut (param $0 i32) (param $1 i32) (param $2 i32)
  (local $3 i32)
  loop $while-continue|0
   local.get $1
   i32.const 10000
   i32.ge_u
   if
    local.get $1
    i32.const 10000
    i32.rem_u
    local.set $3
    local.get $1
    i32.const 10000
    i32.div_u
    local.set $1
    local.get $0
    local.get $2
    i32.const 4
    i32.sub
    local.tee $2
    i32.const 1
    i32.shl
    i32.add
    local.get $3
    i32.const 100
    i32.div_u
    i32.const 2
    i32.shl
    i32.const 3004
    i32.add
    i64.load32_u
    local.get $3
    i32.const 100
    i32.rem_u
    i32.const 2
    i32.shl
    i32.const 3004
    i32.add
    i64.load32_u
    i64.const 32
    i64.shl
    i64.or
    i64.store
    br $while-continue|0
   end
  end
  local.get $1
  i32.const 100
  i32.ge_u
  if
   local.get $0
   local.get $2
   i32.const 2
   i32.sub
   local.tee $2
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 100
   i32.rem_u
   i32.const 2
   i32.shl
   i32.const 3004
   i32.add
   i32.load
   i32.store
   local.get $1
   i32.const 100
   i32.div_u
   local.set $1
  end
  local.get $1
  i32.const 10
  i32.ge_u
  if
   local.get $0
   local.get $2
   i32.const 2
   i32.sub
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 2
   i32.shl
   i32.const 3004
   i32.add
   i32.load
   i32.store
  else
   local.get $0
   local.get $2
   i32.const 1
   i32.sub
   i32.const 1
   i32.shl
   i32.add
   local.get $1
   i32.const 48
   i32.add
   i32.store16
  end
 )
 (func $~lib/util/number/utoa64 (param $0 i64) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i64.eqz
  if
   i32.const 2992
   return
  end
  local.get $0
  i64.const 4294967295
  i64.le_u
  if
   local.get $0
   i32.wrap_i64
   local.tee $1
   i32.const 100000
   i32.lt_u
   if (result i32)
    local.get $1
    i32.const 100
    i32.lt_u
    if (result i32)
     local.get $1
     i32.const 10
     i32.ge_u
     i32.const 1
     i32.add
    else
     local.get $1
     i32.const 10000
     i32.ge_u
     i32.const 3
     i32.add
     local.get $1
     i32.const 1000
     i32.ge_u
     i32.add
    end
   else
    local.get $1
    i32.const 10000000
    i32.lt_u
    if (result i32)
     local.get $1
     i32.const 1000000
     i32.ge_u
     i32.const 6
     i32.add
    else
     local.get $1
     i32.const 1000000000
     i32.ge_u
     i32.const 8
     i32.add
     local.get $1
     i32.const 100000000
     i32.ge_u
     i32.add
    end
   end
   local.tee $3
   i32.const 1
   i32.shl
   i32.const 2
   call $~lib/rt/stub/__new
   local.tee $2
   local.get $1
   local.get $3
   call $~lib/util/number/utoa32_dec_lut
  else
   local.get $0
   i64.const 1000000000000000
   i64.lt_u
   if (result i32)
    local.get $0
    i64.const 1000000000000
    i64.lt_u
    if (result i32)
     local.get $0
     i64.const 100000000000
     i64.ge_u
     i32.const 10
     i32.add
     local.get $0
     i64.const 10000000000
     i64.ge_u
     i32.add
    else
     local.get $0
     i64.const 100000000000000
     i64.ge_u
     i32.const 13
     i32.add
     local.get $0
     i64.const 10000000000000
     i64.ge_u
     i32.add
    end
   else
    local.get $0
    i64.const 100000000000000000
    i64.lt_u
    if (result i32)
     local.get $0
     i64.const 10000000000000000
     i64.ge_u
     i32.const 16
     i32.add
    else
     local.get $0
     i64.const -8446744073709551616
     i64.ge_u
     i32.const 18
     i32.add
     local.get $0
     i64.const 1000000000000000000
     i64.ge_u
     i32.add
    end
   end
   local.tee $1
   i32.const 1
   i32.shl
   i32.const 2
   call $~lib/rt/stub/__new
   local.set $2
   loop $while-continue|0
    local.get $0
    i64.const 100000000
    i64.ge_u
    if
     local.get $2
     local.get $1
     i32.const 4
     i32.sub
     local.tee $1
     i32.const 1
     i32.shl
     i32.add
     local.get $0
     local.get $0
     i64.const 100000000
     i64.div_u
     local.tee $0
     i64.const 100000000
     i64.mul
     i64.sub
     i32.wrap_i64
     local.tee $3
     i32.const 10000
     i32.rem_u
     local.tee $4
     i32.const 100
     i32.div_u
     i32.const 2
     i32.shl
     i32.const 3004
     i32.add
     i64.load32_u
     local.get $4
     i32.const 100
     i32.rem_u
     i32.const 2
     i32.shl
     i32.const 3004
     i32.add
     i64.load32_u
     i64.const 32
     i64.shl
     i64.or
     i64.store
     local.get $2
     local.get $1
     i32.const 4
     i32.sub
     local.tee $1
     i32.const 1
     i32.shl
     i32.add
     local.get $3
     i32.const 10000
     i32.div_u
     local.tee $3
     i32.const 100
     i32.div_u
     i32.const 2
     i32.shl
     i32.const 3004
     i32.add
     i64.load32_u
     local.get $3
     i32.const 100
     i32.rem_u
     i32.const 2
     i32.shl
     i32.const 3004
     i32.add
     i64.load32_u
     i64.const 32
     i64.shl
     i64.or
     i64.store
     br $while-continue|0
    end
   end
   local.get $2
   local.get $0
   i32.wrap_i64
   local.get $1
   call $~lib/util/number/utoa32_dec_lut
  end
  local.get $2
 )
 (func $~lib/string/String#concat (param $0 i32) (param $1 i32) (result i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  local.get $0
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $2
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.const -2
  i32.and
  local.tee $3
  i32.add
  local.tee $4
  i32.eqz
  if
   i32.const 2176
   return
  end
  local.get $4
  i32.const 2
  call $~lib/rt/stub/__new
  local.tee $4
  local.get $0
  local.get $2
  memory.copy
  local.get $2
  local.get $4
  i32.add
  local.get $1
  local.get $3
  memory.copy
  local.get $4
 )
 (func $assembly/main/createMarket (param $0 i32)
  (local $1 i64)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  block $folding-inner1
   block $folding-inner0
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
    local.tee $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $3
    i32.load offset=4
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $3
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    i32.load
    local.set $3
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $4
    i32.load offset=4
    local.tee $5
    if (result i32)
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $4
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $4
    i32.load
    local.set $4
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $5
    if (result i32)
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i64.load
    local.set $2
    call $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller
    i32.load
    local.set $0
    block $__inlined_func$assembly/main/getNextMarketId$147
     global.get $assembly/main/NEXT_MARKET_ID_KEY
     call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.has
     i32.eqz
     if
      global.get $assembly/main/NEXT_MARKET_ID_KEY
      i32.const 8
      call $~lib/staticarray/StaticArray<u8>#constructor
      local.tee $5
      i64.const 1
      i64.store
      local.get $5
      call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set
      i64.const 1
      local.set $1
      br $__inlined_func$assembly/main/getNextMarketId$147
     end
     global.get $assembly/main/NEXT_MARKET_ID_KEY
     call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.get
     i64.load
     local.set $1
     global.get $assembly/main/NEXT_MARKET_ID_KEY
     i32.const 8
     call $~lib/staticarray/StaticArray<u8>#constructor
     local.tee $5
     local.get $1
     i64.const 1
     i64.add
     i64.store
     local.get $5
     call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set
    end
    local.get $1
    local.get $0
    local.get $3
    local.get $4
    call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time
    local.get $2
    i64.const 60000
    i64.mul
    i64.add
    call $assembly/main/Market#constructor
    call $assembly/main/saveMarket
    i32.const 4576
    local.get $1
    call $~lib/util/number/utoa64
    call $~lib/string/String#concat
    call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.generateEvent
    return
   end
   i32.const 1936
   i32.const 2064
   i32.const 70
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $~lib/@massalabs/as-types/assembly/argument/Args#nextU8 (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  i32.load offset=4
  i32.const 20
  i32.sub
  i32.load offset=16
  local.get $0
  i32.load
  i32.const 1
  i32.add
  i32.lt_s
  if
   i32.const 8
   i32.const 19
   call $~lib/rt/stub/__new
   local.tee $0
   i32.const 0
   i32.store8
   local.get $0
   i32.const 4640
   i32.store offset=4
   local.get $0
   return
  end
  local.get $0
  i32.load offset=4
  local.set $1
  local.get $0
  local.get $0
  i32.load
  local.tee $0
  i32.const 1
  i32.add
  i32.store
  local.get $0
  local.get $1
  i32.const 20
  i32.sub
  i32.load offset=16
  i32.ge_u
  if
   i32.const 2528
   i32.const 1232
   i32.const 78
   i32.const 41
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  local.get $1
  i32.add
  i32.load8_u
  local.set $0
  i32.const 8
  i32.const 19
  call $~lib/rt/stub/__new
  local.tee $1
  local.get $0
  i32.store8
  local.get $1
  i32.const 0
  i32.store offset=4
  local.get $1
 )
 (func $assembly/main/Market.deserialize (param $0 i32) (result i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  block $folding-inner1
   block $folding-inner0
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
    local.tee $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $3
    if (result i32)
     local.get $3
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i64.load
    local.set $1
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $0
    i32.load offset=4
    local.tee $3
    if (result i32)
     local.get $3
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i32.load
    local.set $3
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $0
    i32.load offset=4
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i32.load
    local.set $4
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $0
    i32.load offset=4
    local.tee $5
    if (result i32)
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i32.load
    local.set $5
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $6
    i32.load offset=8
    local.tee $0
    if (result i32)
     local.get $0
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $6
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $1
    local.get $3
    local.get $4
    local.get $5
    local.get $6
    i64.load
    call $assembly/main/Market#constructor
    local.set $3
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU8
    local.tee $0
    i32.load offset=4
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i32.load8_u
    i32.store offset=32
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i64.load
    i64.store offset=40
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i64.load
    i64.store offset=48
    block $__inlined_func$~lib/@massalabs/as-types/assembly/argument/Args#nextI32$467
     local.get $2
     i32.load offset=4
     i32.const 20
     i32.sub
     i32.load offset=16
     local.get $2
     i32.load
     i32.const 4
     i32.add
     i32.lt_s
     if
      i32.const 8
      i32.const 20
      call $~lib/rt/stub/__new
      local.tee $0
      i32.const 0
      i32.store
      local.get $0
      i32.const 4928
      i32.store offset=4
      br $__inlined_func$~lib/@massalabs/as-types/assembly/argument/Args#nextI32$467
     end
     local.get $2
     i32.const 4
     call $~lib/@massalabs/as-types/assembly/argument/Args#getNextData
     i32.load
     local.set $4
     i32.const 8
     i32.const 20
     call $~lib/rt/stub/__new
     local.tee $0
     local.get $4
     i32.store
     local.get $0
     i32.const 0
     i32.store offset=4
    end
    local.get $0
    i32.load offset=4
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i32.load
    i32.store offset=56
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i64.load
    i64.store offset=64
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $2
    if (result i32)
     local.get $2
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $3
    local.get $0
    i64.load
    i64.store offset=72
    local.get $3
    return
   end
   i32.const 1936
   i32.const 2064
   i32.const 70
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/main/getMarket (param $0 i64) (result i32)
  (local $1 i32)
  global.get $assembly/main/MARKET_PREFIX
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $1
  local.get $0
  i64.store
  local.get $1
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  local.tee $1
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.has
  i32.eqz
  if
   i32.const 0
   return
  end
  local.get $1
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.get
  call $assembly/main/Market.deserialize
 )
 (func $assembly/main/getUserBetKey (param $0 i64) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  global.get $assembly/main/USER_BET_PREFIX
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $3
  local.get $0
  i64.store
  local.get $3
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.const 5264
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  local.get $1
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.const 5264
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $1
  local.get $2
  i32.const 255
  i32.and
  i64.extend_i32_u
  i64.store
  local.get $1
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
 )
 (func $assembly/main/Bet#constructor (param $0 i64) (param $1 i32) (param $2 i32) (param $3 i64) (result i32)
  (local $4 i32)
  i32.const 33
  i32.const 21
  call $~lib/rt/stub/__new
  local.tee $4
  i64.const 0
  i64.store
  local.get $4
  i32.const 0
  i32.store offset=8
  local.get $4
  i32.const 0
  i32.store offset=12
  local.get $4
  i64.const 0
  i64.store offset=16
  local.get $4
  i64.const 0
  i64.store offset=24
  local.get $4
  i32.const 0
  i32.store8 offset=32
  local.get $4
  local.get $0
  i64.store
  local.get $4
  local.get $1
  i32.store offset=8
  local.get $4
  local.get $2
  i32.store offset=12
  local.get $4
  local.get $3
  i64.store offset=16
  local.get $4
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time
  i64.store offset=24
  local.get $4
  i32.const 0
  i32.store8 offset=32
  local.get $4
 )
 (func $assembly/main/getUserBet (param $0 i64) (param $1 i32) (param $2 i32) (result i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  local.get $0
  local.get $1
  local.get $2
  call $assembly/main/getUserBetKey
  local.tee $1
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.has
  i32.eqz
  if
   i32.const 0
   return
  end
  block $folding-inner1
   block $__inlined_func$assembly/main/Bet.deserialize$19
    block $folding-inner0
     local.get $1
     call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.get
     call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
     local.tee $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
     local.tee $1
     i32.load offset=8
     local.tee $3
     if (result i32)
      local.get $3
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $1
      i32.load offset=8
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     i64.load
     local.set $0
     local.get $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
     local.tee $1
     i32.load offset=4
     local.tee $3
     if (result i32)
      local.get $3
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $1
      i32.load offset=4
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     i32.load
     local.set $3
     local.get $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextU8
     local.tee $1
     i32.load offset=4
     local.tee $4
     if (result i32)
      local.get $4
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $1
      i32.load offset=4
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     i32.load8_u
     local.set $4
     local.get $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
     local.tee $5
     i32.load offset=8
     local.tee $1
     if (result i32)
      local.get $1
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $5
      i32.load offset=8
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $0
     local.get $3
     local.get $4
     local.get $5
     i64.load
     call $assembly/main/Bet#constructor
     local.set $1
     local.get $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
     local.tee $3
     i32.load offset=8
     local.tee $4
     if (result i32)
      local.get $4
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $3
      i32.load offset=8
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     local.get $3
     i64.load
     i64.store offset=24
     local.get $2
     call $~lib/@massalabs/as-types/assembly/argument/Args#nextU8
     local.tee $2
     i32.load offset=4
     local.tee $3
     if (result i32)
      local.get $3
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
     else
      i32.const 0
     end
     if
      local.get $2
      i32.load offset=4
      local.tee $1
      i32.eqz
      br_if $folding-inner0
      br $folding-inner1
     end
     local.get $1
     local.get $2
     i32.load8_u
     i32.const 0
     i32.ne
     i32.store8 offset=32
     br $__inlined_func$assembly/main/Bet.deserialize$19
    end
    i32.const 1936
    i32.const 2064
    i32.const 70
    i32.const 21
    call $~lib/builtins/abort
    unreachable
   end
   local.get $1
   return
  end
  local.get $1
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/main/Bet#serialize (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  i32.const 0
  global.set $~argumentsLength
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor@varargs
  local.set $1
  local.get $0
  i64.load
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  local.get $0
  i32.load offset=8
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<~lib/string/String,void>"
  local.get $1
  local.get $0
  i32.load offset=12
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<u8,void>"
  local.get $0
  i64.load offset=16
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $0
  i64.load offset=24
  local.set $2
  local.get $1
  i32.load offset=4
  local.set $3
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $4
  local.get $2
  i64.store
  local.get $1
  local.get $3
  local.get $4
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $0
  i32.load8_u offset=32
  local.set $0
  i32.const 1
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $3
  local.get $0
  i32.const 0
  i32.ne
  call $~lib/staticarray/StaticArray<u8>#__set
  local.get $1
  local.get $3
  i32.const 20
  i32.sub
  i32.load offset=16
  call $"~lib/@massalabs/as-types/assembly/argument/Args#add<u32,void>"
  local.get $1
  local.get $1
  i32.load offset=4
  local.get $3
  call $~lib/staticarray/StaticArray<u8>#concat<~lib/staticarray/StaticArray<u8>>
  i32.store offset=4
  local.get $1
  i32.load offset=4
 )
 (func $~lib/util/number/utoa32 (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  local.get $0
  i32.eqz
  if
   i32.const 2992
   return
  end
  local.get $0
  i32.const 100000
  i32.lt_u
  if (result i32)
   local.get $0
   i32.const 100
   i32.lt_u
   if (result i32)
    local.get $0
    i32.const 10
    i32.ge_u
    i32.const 1
    i32.add
   else
    local.get $0
    i32.const 10000
    i32.ge_u
    i32.const 3
    i32.add
    local.get $0
    i32.const 1000
    i32.ge_u
    i32.add
   end
  else
   local.get $0
   i32.const 10000000
   i32.lt_u
   if (result i32)
    local.get $0
    i32.const 1000000
    i32.ge_u
    i32.const 6
    i32.add
   else
    local.get $0
    i32.const 1000000000
    i32.ge_u
    i32.const 8
    i32.add
    local.get $0
    i32.const 100000000
    i32.ge_u
    i32.add
   end
  end
  local.tee $2
  i32.const 1
  i32.shl
  i32.const 2
  call $~lib/rt/stub/__new
  local.tee $1
  local.get $0
  local.get $2
  call $~lib/util/number/utoa32_dec_lut
  local.get $1
 )
 (func $~lib/staticarray/StaticArray<~lib/string/String>#join (param $0 i32) (result i32)
  (local $1 i32)
  (local $2 i32)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  i32.const 2176
  local.set $3
  block $__inlined_func$~lib/util/string/joinStringArray$265
   local.get $0
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 2
   i32.shr_u
   local.tee $7
   i32.const 1
   i32.sub
   local.tee $5
   i32.const 0
   i32.lt_s
   br_if $__inlined_func$~lib/util/string/joinStringArray$265
   local.get $5
   i32.eqz
   if
    local.get $0
    i32.load
    local.tee $3
    i32.eqz
    if
     i32.const 2176
     local.set $3
    end
    br $__inlined_func$~lib/util/string/joinStringArray$265
   end
   loop $for-loop|0
    local.get $4
    local.get $7
    i32.lt_s
    if
     local.get $0
     local.get $4
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $3
     if
      local.get $1
      local.get $3
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      i32.add
      local.set $1
     end
     local.get $4
     i32.const 1
     i32.add
     local.set $4
     br $for-loop|0
    end
   end
   local.get $1
   local.get $5
   i32.const 2172
   i32.load
   i32.const 1
   i32.shr_u
   local.tee $1
   i32.mul
   i32.add
   i32.const 1
   i32.shl
   i32.const 2
   call $~lib/rt/stub/__new
   local.set $3
   loop $for-loop|1
    local.get $5
    local.get $6
    i32.gt_s
    if
     local.get $0
     local.get $6
     i32.const 2
     i32.shl
     i32.add
     i32.load
     local.tee $4
     if
      local.get $3
      local.get $2
      i32.const 1
      i32.shl
      i32.add
      local.get $4
      local.get $4
      i32.const 20
      i32.sub
      i32.load offset=16
      i32.const 1
      i32.shr_u
      local.tee $4
      i32.const 1
      i32.shl
      memory.copy
      local.get $2
      local.get $4
      i32.add
      local.set $2
     end
     local.get $1
     if
      local.get $3
      local.get $2
      i32.const 1
      i32.shl
      i32.add
      i32.const 2176
      local.get $1
      i32.const 1
      i32.shl
      memory.copy
      local.get $1
      local.get $2
      i32.add
      local.set $2
     end
     local.get $6
     i32.const 1
     i32.add
     local.set $6
     br $for-loop|1
    end
   end
   local.get $0
   local.get $5
   i32.const 2
   i32.shl
   i32.add
   i32.load
   local.tee $0
   if
    local.get $3
    local.get $2
    i32.const 1
    i32.shl
    i32.add
    local.get $0
    local.get $0
    i32.const 20
    i32.sub
    i32.load offset=16
    i32.const -2
    i32.and
    memory.copy
   end
  end
  local.get $3
 )
 (func $assembly/main/placeBet (param $0 i32)
  (local $1 i64)
  (local $2 i64)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  block $folding-inner3
   block $folding-inner2
    block $folding-inner1
     block $folding-inner0
      local.get $0
      call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
      local.tee $0
      call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
      local.tee $4
      i32.load offset=8
      local.tee $5
      if (result i32)
       local.get $5
       i32.const 20
       i32.sub
       i32.load offset=16
       i32.const 1
       i32.shr_u
      else
       i32.const 0
      end
      if
       local.get $4
       i32.load offset=8
       local.tee $0
       i32.eqz
       br_if $folding-inner0
       br $folding-inner3
      end
      local.get $4
      i64.load
      local.set $1
      local.get $0
      call $~lib/@massalabs/as-types/assembly/argument/Args#nextU8
      local.tee $0
      i32.load offset=4
      local.tee $4
      if (result i32)
       local.get $4
       i32.const 20
       i32.sub
       i32.load offset=16
       i32.const 1
       i32.shr_u
      else
       i32.const 0
      end
      if
       local.get $0
       i32.load offset=4
       local.tee $0
       i32.eqz
       br_if $folding-inner0
       br $folding-inner3
      end
      local.get $0
      i32.load8_u
      local.set $0
      call $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller
      i32.load
      local.set $4
      call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.callCoins
      local.tee $2
      i64.eqz
      if
       i32.const 4768
       i32.const 4864
       i32.const 297
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      local.get $1
      call $assembly/main/getMarket
      local.tee $5
      i32.eqz
      if
       i32.const 5072
       i32.const 4864
       i32.const 301
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      local.get $5
      i32.eqz
      if
       i32.const 1936
       i32.const 4864
       i32.const 302
       i32.const 10
       call $~lib/builtins/abort
       unreachable
      end
      local.get $5
      i32.load offset=32
      if
       i32.const 5136
       i32.const 4864
       i32.const 302
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time
      local.set $3
      local.get $5
      i32.eqz
      if
       i32.const 1936
       i32.const 4864
       i32.const 306
       i32.const 24
       call $~lib/builtins/abort
       unreachable
      end
      local.get $3
      local.get $5
      i64.load offset=24
      i64.ge_u
      if
       i32.const 5200
       i32.const 4864
       i32.const 306
       i32.const 3
       call $~lib/builtins/abort
       unreachable
      end
      local.get $1
      local.get $4
      local.get $0
      call $assembly/main/getUserBet
      drop
      local.get $0
      if
       local.get $0
       i32.const 1
       i32.eq
       if
        local.get $5
        i32.eqz
        local.tee $6
        br_if $folding-inner1
        local.get $6
        br_if $folding-inner1
        local.get $5
        local.get $2
        local.get $5
        i64.load offset=48
        i64.add
        i64.store offset=48
       end
      else
       local.get $5
       i32.eqz
       local.tee $6
       br_if $folding-inner2
       local.get $6
       br_if $folding-inner2
       local.get $5
       local.get $2
       local.get $5
       i64.load offset=40
       i64.add
       i64.store offset=40
      end
      local.get $5
      i32.eqz
      if
       i32.const 1936
       i32.const 4864
       i32.const 324
       i32.const 14
       call $~lib/builtins/abort
       unreachable
      end
      local.get $5
      call $assembly/main/saveMarket
      local.get $1
      local.get $4
      local.get $0
      i32.const 0
      local.get $0
      i32.const 2
      i32.lt_u
      select
      local.get $2
      call $assembly/main/Bet#constructor
      local.tee $5
      i64.load
      local.get $5
      i32.load offset=8
      local.get $0
      call $assembly/main/getUserBetKey
      local.get $5
      call $assembly/main/Bet#serialize
      call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set
      local.get $0
      if (result i32)
       local.get $0
       i32.const 1
       i32.eq
       if (result i32)
        i32.const 5328
       else
        i32.const 5360
        local.get $0
        call $~lib/util/number/utoa32
        call $~lib/string/String#concat
       end
      else
       i32.const 5296
      end
      local.set $5
      local.get $2
      call $~lib/util/number/utoa64
      local.set $6
      local.get $0
      call $~lib/util/number/utoa32
      local.set $0
      local.get $1
      call $~lib/util/number/utoa64
      local.set $7
      i32.const 5620
      local.get $4
      i32.store
      i32.const 5628
      local.get $6
      i32.store
      i32.const 5636
      local.get $5
      i32.store
      i32.const 5644
      local.get $0
      i32.store
      i32.const 5652
      local.get $7
      i32.store
      i32.const 5616
      call $~lib/staticarray/StaticArray<~lib/string/String>#join
      call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.generateEvent
      return
     end
     i32.const 1936
     i32.const 2064
     i32.const 70
     i32.const 21
     call $~lib/builtins/abort
     unreachable
    end
    i32.const 1936
    i32.const 4864
    i32.const 320
    i32.const 5
    call $~lib/builtins/abort
    unreachable
   end
   i32.const 1936
   i32.const 4864
   i32.const 318
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/main/resolveMarket (param $0 i32)
  (local $1 i64)
  (local $2 i64)
  (local $3 i64)
  (local $4 i32)
  (local $5 i32)
  (local $6 i32)
  (local $7 i32)
  block $folding-inner1
   block $folding-inner0
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
    local.tee $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $4
    i32.load offset=8
    local.tee $5
    if (result i32)
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $4
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $4
    i64.load
    local.set $1
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU8
    local.tee $4
    i32.load offset=4
    local.tee $5
    if (result i32)
     local.get $5
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $4
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $4
    i32.load8_u
    local.set $5
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $4
    if (result i32)
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i64.load
    local.set $2
    call $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller
    i32.load
    local.set $6
    local.get $1
    call $assembly/main/getMarket
    local.tee $0
    i32.eqz
    if
     i32.const 5072
     i32.const 4864
     i32.const 355
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    block $__inlined_func$~lib/string/String.__eq$300 (result i32)
     local.get $0
     i32.eqz
     if
      i32.const 1936
      i32.const 4864
      i32.const 356
      i32.const 10
      call $~lib/builtins/abort
      unreachable
     end
     i32.const 1
     local.get $0
     i32.load offset=8
     local.tee $4
     local.get $6
     i32.eq
     br_if $__inlined_func$~lib/string/String.__eq$300
     drop
     i32.const 0
     local.get $6
     i32.eqz
     local.get $4
     i32.eqz
     i32.or
     br_if $__inlined_func$~lib/string/String.__eq$300
     drop
     i32.const 0
     local.get $4
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
     local.tee $7
     local.get $6
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
     i32.ne
     br_if $__inlined_func$~lib/string/String.__eq$300
     drop
     local.get $4
     i32.const 0
     local.get $6
     local.get $7
     call $~lib/util/string/compareImpl
     i32.eqz
    end
    i32.eqz
    if
     i32.const 5680
     i32.const 4864
     i32.const 356
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 357
     i32.const 11
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.load offset=32
    i32.const 2
    i32.eq
    if
     i32.const 5776
     i32.const 4864
     i32.const 357
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.time
    local.set $3
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 361
     i32.const 25
     call $~lib/builtins/abort
     unreachable
    end
    local.get $3
    local.get $0
    i64.load offset=24
    i64.lt_u
    if
     i32.const 5856
     i32.const 4864
     i32.const 361
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 364
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.const 2
    i32.store offset=32
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 365
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $5
    i32.store offset=56
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 366
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    local.get $2
    i64.store offset=72
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 367
     i32.const 14
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    call $assembly/main/saveMarket
    local.get $1
    call $~lib/util/number/utoa64
    local.set $0
    local.get $2
    call $~lib/util/number/utoa64
    local.set $4
    i32.const 6100
    local.get $0
    i32.store
    i32.const 6108
    i32.const 5328
    i32.const 5296
    local.get $5
    select
    i32.store
    i32.const 6116
    local.get $4
    i32.store
    i32.const 6096
    call $~lib/staticarray/StaticArray<~lib/string/String>#join
    call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.generateEvent
    return
   end
   i32.const 1936
   i32.const 2064
   i32.const 70
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/main/claimReward (param $0 i32)
  (local $1 i64)
  (local $2 i64)
  (local $3 i32)
  (local $4 i32)
  (local $5 i32)
  (local $6 i64)
  local.get $0
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
  call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
  local.tee $0
  i32.load offset=8
  local.tee $3
  if (result i32)
   local.get $3
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
  else
   i32.const 0
  end
  if
   local.get $0
   i32.load offset=8
   local.tee $0
   i32.eqz
   if
    i32.const 1936
    i32.const 2064
    i32.const 70
    i32.const 21
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2064
   i32.const 70
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.load
  local.set $1
  call $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller
  i32.load
  local.set $3
  local.get $1
  call $assembly/main/getMarket
  local.tee $4
  i32.eqz
  if
   i32.const 5072
   i32.const 4864
   i32.const 387
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 388
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.load offset=32
  i32.const 2
  i32.ne
  if
   i32.const 6144
   i32.const 4864
   i32.const 388
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $1
  local.get $3
  i32.const 0
  call $assembly/main/getUserBet
  local.tee $0
  i32.eqz
  if
   i32.const 6224
   i32.const 4864
   i32.const 392
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 393
   i32.const 11
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load8_u offset=32
  if
   i32.const 6304
   i32.const 4864
   i32.const 393
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 397
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.load offset=12
  local.set $5
  local.get $4
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 397
   i32.const 27
   call $~lib/builtins/abort
   unreachable
  end
  local.get $5
  local.get $4
  i32.load offset=56
  i32.ne
  if
   i32.const 6368
   i32.const 4864
   i32.const 396
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 402
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i64.load offset=40
  local.get $4
  i64.load offset=48
  i64.add
  local.set $6
  local.get $4
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 404
   i32.const 5
   call $~lib/builtins/abort
   unreachable
  end
  local.get $4
  i32.load offset=56
  if (result i64)
   local.get $4
   i32.eqz
   if
    i32.const 1936
    i32.const 4864
    i32.const 406
    i32.const 9
    call $~lib/builtins/abort
    unreachable
   end
   local.get $4
   i64.load offset=48
  else
   local.get $4
   i32.eqz
   if
    i32.const 1936
    i32.const 4864
    i32.const 405
    i32.const 9
    call $~lib/builtins/abort
    unreachable
   end
   local.get $4
   i64.load offset=40
  end
  local.tee $2
  i64.eqz
  if
   i32.const 6448
   i32.const 4864
   i32.const 408
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 411
   i32.const 19
   call $~lib/builtins/abort
   unreachable
  end
  local.get $6
  local.get $0
  i64.load offset=16
  i64.mul
  local.get $2
  i64.div_u
  local.set $2
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 414
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 1
  i32.store8 offset=32
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 415
   i32.const 15
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.load
  local.get $0
  i32.load offset=8
  i32.const 0
  call $assembly/main/getUserBetKey
  local.get $0
  call $assembly/main/Bet#serialize
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.set
  call $~lib/@massalabs/massa-as-sdk/assembly/std/context/caller
  i32.load
  local.get $2
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.transferCoins
  local.get $2
  call $~lib/util/number/utoa64
  local.set $0
  local.get $1
  call $~lib/util/number/utoa64
  local.set $4
  i32.const 6676
  local.get $3
  i32.store
  i32.const 6684
  local.get $0
  i32.store
  i32.const 6692
  local.get $4
  i32.store
  i32.const 6672
  call $~lib/staticarray/StaticArray<~lib/string/String>#join
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.generateEvent
 )
 (func $assembly/main/getMarketDetails (param $0 i32) (result i32)
  (local $1 i32)
  local.get $0
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
  call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
  local.tee $0
  i32.load offset=8
  local.tee $1
  if (result i32)
   local.get $1
   i32.const 20
   i32.sub
   i32.load offset=16
   i32.const 1
   i32.shr_u
  else
   i32.const 0
  end
  if
   local.get $0
   i32.load offset=8
   local.tee $0
   i32.eqz
   if
    i32.const 1936
    i32.const 2064
    i32.const 70
    i32.const 21
    call $~lib/builtins/abort
    unreachable
   end
   local.get $0
   i32.const 2064
   i32.const 70
   i32.const 7
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i64.load
  call $assembly/main/getMarket
  local.tee $0
  i32.eqz
  if
   i32.const 5072
   i32.const 4864
   i32.const 433
   i32.const 3
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.eqz
  if
   i32.const 1936
   i32.const 4864
   i32.const 435
   i32.const 10
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  call $assembly/main/Market#serialize
 )
 (func $assembly/main/getUserBetDetails (param $0 i32) (result i32)
  (local $1 i64)
  (local $2 i32)
  (local $3 i32)
  block $folding-inner1
   block $folding-inner0
    local.get $0
    call $~lib/@massalabs/as-types/assembly/argument/Args#constructor
    local.tee $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextU64
    local.tee $0
    i32.load offset=8
    local.tee $3
    if (result i32)
     local.get $3
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=8
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $0
    i64.load
    local.set $1
    local.get $2
    call $~lib/@massalabs/as-types/assembly/argument/Args#nextString
    local.tee $0
    i32.load offset=4
    local.tee $2
    if (result i32)
     local.get $2
     i32.const 20
     i32.sub
     i32.load offset=16
     i32.const 1
     i32.shr_u
    else
     i32.const 0
    end
    if
     local.get $0
     i32.load offset=4
     local.tee $0
     i32.eqz
     br_if $folding-inner0
     br $folding-inner1
    end
    local.get $1
    local.get $0
    i32.load
    i32.const 0
    call $assembly/main/getUserBet
    local.tee $0
    i32.eqz
    if
     i32.const 6720
     i32.const 4864
     i32.const 447
     i32.const 3
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    i32.eqz
    if
     i32.const 1936
     i32.const 4864
     i32.const 449
     i32.const 10
     call $~lib/builtins/abort
     unreachable
    end
    local.get $0
    call $assembly/main/Bet#serialize
    return
   end
   i32.const 1936
   i32.const 2064
   i32.const 70
   i32.const 21
   call $~lib/builtins/abort
   unreachable
  end
  local.get $0
  i32.const 2064
  i32.const 70
  i32.const 7
  call $~lib/builtins/abort
  unreachable
 )
 (func $assembly/main/getMarketCount (param $0 i32) (result i32)
  (local $1 i64)
  global.get $assembly/main/NEXT_MARKET_ID_KEY
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.has
  i32.eqz
  if
   i32.const 8
   call $~lib/staticarray/StaticArray<u8>#constructor
   local.tee $0
   i64.const 0
   i64.store
   local.get $0
   return
  end
  global.get $assembly/main/NEXT_MARKET_ID_KEY
  call $~lib/@massalabs/massa-as-sdk/assembly/env/env/env.get
  i64.load
  local.set $1
  i32.const 8
  call $~lib/staticarray/StaticArray<u8>#constructor
  local.tee $0
  local.get $1
  i64.const 1
  i64.sub
  i64.const 0
  local.get $1
  i64.const 0
  i64.ne
  select
  i64.store
  local.get $0
 )
 (func $~start
  i32.const 6748
  global.set $~lib/rt/stub/offset
  i32.const 0
  global.set $~argumentsLength
  call $~lib/@massalabs/as-types/assembly/argument/Args#constructor@varargs
  drop
  i32.const 1472
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  global.set $assembly/main/NEXT_MARKET_ID_KEY
  i32.const 1664
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  global.set $assembly/main/MARKET_PREFIX
  i32.const 1712
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  drop
  i32.const 1744
  call $~lib/@massalabs/as-types/assembly/serialization/strings/stringToBytes
  global.set $assembly/main/USER_BET_PREFIX
 )
)
