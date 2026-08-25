#set page(
  paper: "a4",
  margin: 1cm,
)

#let subtitle(label) = table.header(
  level: 2,
  repeat: false,
  table.cell(colspan: 32, label),
  [],
)
#let comment(body) = (table.cell(colspan: 32, body), [])

#let lit(lit) = table.cell(colspan: lit.len(), raw(lit))
#let imm(colspan, description) = table.cell(colspan: colspan, description)
#let empty(colspan) = table.cell(colspan: colspan)[]

#let xs1 = table.cell(colspan: 5)[xs1]
#let xs2 = table.cell(colspan: 5)[xs2]
#let xd = table.cell(colspan: 5)[*xd*]
#let fs1 = table.cell(colspan: 5)[fs1]
#let fs2 = table.cell(colspan: 5)[fs2]
#let fd = table.cell(colspan: 5)[*fd*]
#let vs1 = table.cell(colspan: 5)[vs1]
#let vs2 = table.cell(colspan: 5)[vs2]
#let vs3 = table.cell(colspan: 5)[vs3]
#let vd = table.cell(colspan: 5)[*vd*]

#let aq = table.cell(colspan: 1)[aq]
#let rl = table.cell(colspan: 1)[rl]
#let aqrl = table.cell(colspan: 2)[aqrl]

#let nf = table.cell(colspan: 3)[nf]
#let mew = table.cell(colspan: 1)[mew]
#let mop = table.cell(colspan: 2)[mop]
#let vm = table.cell(colspan: 1)[vm]
#let lumop = table.cell(colspan: 5)[lumop]

#let shamt5 = table.cell(colspan: 5)[shamt5]
#let shamt6 = table.cell(colspan: 6)[shamt6]
#let shamt-rs2 = table.cell(colspan: 6)[shamt | [0|rs2]]

#let fm = table.cell(colspan: 4)[fm]
#let pred = table.cell(colspan: 4)[pred]
#let succ = table.cell(colspan: 4)[succ]

#let csr      = imm(12, "csr")
#let uimm5    = imm(5, "uimm")
#let imm-i-12 = imm(12, "imm[11:0]")
#let imm-s1-7 = imm(7, "imm[11:5]")
#let imm-s2-5 = imm(5, "imm[4:0]")
#let imm-u-20 = imm(20, "imm[31:12]")
#let imm-b1-7 = imm(7, "imm[12|10:5]")
#let imm-b2-5 = imm(5, "imm[4:1|11]")
#let imm-j-20 = imm(20, "imm[20|10:1|11|19:12]")

// Zibi extension
#let cimm = imm(5, "cimm")

#let opcode-load      = table.cell(colspan: 7)[`0000011`]
#let opcode-load-fp   = table.cell(colspan: 7)[`0000111`]
#let opcode-misc-mem  = table.cell(colspan: 7)[`0001111`]
#let opcode-op-imm    = table.cell(colspan: 7)[`0010011`]
#let opcode-auipc     = table.cell(colspan: 7)[`0010111`]
#let opcode-op-imm32  = table.cell(colspan: 7)[`001`#strong[`1`]`011`]

#let opcode-store     = table.cell(colspan: 7)[`0100011`]
#let opcode-store-fp  = table.cell(colspan: 7)[`0100111`]
#let opcode-amo       = table.cell(colspan: 7)[`0101111`]
#let opcode-op        = table.cell(colspan: 7)[`0110011`]
#let opcode-lui       = table.cell(colspan: 7)[`0110111`]
#let opcode-op32      = table.cell(colspan: 7)[`011`#strong[`1`]`011`]

#let opcode-branch    = table.cell(colspan: 7)[`1100011`]
#let opcode-jalr      = table.cell(colspan: 7)[`1100111`]
#let opcode-jal       = table.cell(colspan: 7)[`1101111`]
#let opcode-system    = table.cell(colspan: 7)[`1110011`]

#let opcode-op-or-imm = table.cell(colspan: 7)[`0-10011`]

#let table-header = table.header(
  [31], [30], [29], [28], [27], [26], [25], [24],
  [23], [22], [21], [20], [19], [18], [17], [16],
  [15], [14], [13], [12], [11], [10], [9], [8],
  [7], [6], [5], [4], [3], [2], [1], [0],
  [],
)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[JAL (opcode = `1101111`],
  imm-j-20, xd, opcode-jal, [`jal`],

  subtitle[JALR (opcode = `1100111`],
  imm-i-12, xs1, lit("000"), xd, opcode-jalr, [`jalr`],

  subtitle[BRANCH (opcode = `1100011`],
  imm-b1-7, xs2, xs1, lit("000"), imm-b2-5, opcode-branch, [`beq`],
  imm-b1-7, xs2, xs1, lit("001"), imm-b2-5, opcode-branch, [`bne`],
  imm-b1-7, cimm, xs1, lit("010"), imm-b2-5, opcode-branch, [`beqi` #super[Zibi]],
  imm-b1-7, cimm, xs1, lit("011"), imm-b2-5, opcode-branch, [`bnei` #super[Zibi]],
  imm-b1-7, xs2, xs1, lit("100"), imm-b2-5, opcode-branch, [`blt`],
  imm-b1-7, xs2, xs1, lit("101"), imm-b2-5, opcode-branch, [`bge`],
  imm-b1-7, xs2, xs1, lit("110"), imm-b2-5, opcode-branch, [`bltu`],
  imm-b1-7, xs2, xs1, lit("111"), imm-b2-5, opcode-branch, [`bgeu`],
)

#pagebreak(weak: true)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[INTEGER LOAD (opcode = `0000011`)],
  imm-i-12, xs1, lit("000"), xd, opcode-load, [`lb`],
  imm-i-12, xs1, lit("001"), xd, opcode-load, [`lh`],
  imm-i-12, xs1, lit("010"), xd, opcode-load, [`lw`],
  imm-i-12, xs1, lit("011"), xd, opcode-load, [`ld` #super[64]],
  imm-i-12, xs1, lit("100"), xd, opcode-load, [`lbu`],
  imm-i-12, xs1, lit("101"), xd, opcode-load, [`lhu`],
  imm-i-12, xs1, lit("110"), xd, opcode-load, [`lwu` #super[64]],

  subtitle[INTEGER STORE (opcode = `0100011`)],
  imm-s1-7, xs2, xs1, lit("000"), imm-s2-5, opcode-store, [`sb`],
  imm-s1-7, xs2, xs1, lit("001"), imm-s2-5, opcode-store, [`sh`],
  imm-s1-7, xs2, xs1, lit("010"), imm-s2-5, opcode-store, [`sw`],
  imm-s1-7, xs2, xs1, lit("011"), imm-s2-5, opcode-store, [`sd` #super[64]],

  subtitle[FP/VECTOR LOAD (opcode = `0000111`)],
  empty(12), xs1, lit("000"), vd, opcode-load-fp, [VECTOR[e8]],
  imm-i-12, xs1, lit("001"), fd, opcode-load-fp, [`flh`],
  imm-i-12, xs1, lit("010"), fd, opcode-load-fp, [`flw`],
  imm-i-12, xs1, lit("011"), fd, opcode-load-fp, [`fld`],
  imm-i-12, xs1, lit("100"), fd, opcode-load-fp, [`flq`],
  empty(12), xs1, lit("101"), vd, opcode-load-fp, [VECTOR[e16]],
  empty(12), xs1, lit("110"), vd, opcode-load-fp, [VECTOR[e32]],
  empty(12), xs1, lit("111"), vd, opcode-load-fp, [VECTOR[e64]],

  subtitle[FP/VECTOR STORE (opcode = `0100111`)],
  empty(12), xs1, lit("000"), vs3, opcode-store-fp, [VECTOR[e8]],
  imm-s1-7, fs2, xs1, lit("001"), imm-s2-5, opcode-store-fp, [`fsh`],
  imm-s1-7, fs2, xs1, lit("010"), imm-s2-5, opcode-store-fp, [`fsw`],
  imm-s1-7, fs2, xs1, lit("011"), imm-s2-5, opcode-store-fp, [`fsd`],
  imm-s1-7, fs2, xs1, lit("100"), imm-s2-5, opcode-store-fp, [`fsq`],
  empty(12), xs1, lit("101"), vs3, opcode-store-fp, [VECTOR[e16]],
  empty(12), xs1, lit("110"), vs3, opcode-store-fp, [VECTOR[e32]],
  empty(12), xs1, lit("111"), vs3, opcode-store-fp, [VECTOR[e64]],
)

#pagebreak(weak: true)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[ATOMIC (opcode = `0101111`)],
  lit("00010"), aq, rl, lit("00000"), xs1, lit("010"), xd, opcode-amo, [`lr.w`],
  lit("00010"), aq, rl, lit("00000"), xs1, lit("011"), xd, opcode-amo, [`lr.d` #super[64]],
  lit("00011"), aq, rl, xs2, xs1, lit("010"), xd, opcode-amo, [`lr.w`],
  lit("00011"), aq, rl, xs2, xs1, lit("011"), xd, opcode-amo, [`lr.d` #super[64]],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("000"), xd, opcode-amo, [`lb.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("001"), xd, opcode-amo, [`lh.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("010"), xd, opcode-amo, [`lw.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("011"), xd, opcode-amo, [`ld.aq(rl)` #super[64]],
  lit("00111"), aq, rl, xs2, xs1, lit("000"), lit("00000"), opcode-amo, [`sb.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("001"), lit("00000"), opcode-amo, [`sh.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("010"), lit("00000"), opcode-amo, [`sw.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("011"), lit("00000"), opcode-amo, [`sd.(aq)rl` #super[64]],
  lit("00101"), aq, rl, xs2, xs1, lit("010"), xd, opcode-amo, [`amocas.w`],
  lit("00101"), aq, rl, xs2, xs1, lit("011"), xd, opcode-amo, [`amocas.d`],
  lit("00101"), aq, rl, xs2, xs1, lit("100"), xd, opcode-amo, [`amocas.q` #super[64]],
)

#pagebreak(weak: true)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[AUIPC (opcode = `0010111`)],
  imm-u-20, xd, opcode-auipc, [`auipc`],

  subtitle[LUI (opcode = `0110111`)],
  imm-u-20, xd, opcode-lui, [`lui`],

  subtitle[INTEGER IMMEDIATE (opcode = `001-011`)],
  imm-i-12, xs1, lit("000"), xd, opcode-op-imm, [`addi`],
  imm-i-12, xs1, lit("000"), xd, opcode-op-imm32, [`addiw` #super[64]],
  imm-i-12, xs1, lit("010"), xd, opcode-op-imm, [`slti`],
  imm-i-12, xs1, lit("011"), xd, opcode-op-imm, [`sltiu`],
  imm-i-12, xs1, lit("100"), xd, opcode-op-imm, [`xori`],
  imm-i-12, xs1, lit("110"), xd, opcode-op-imm, [`ori`],
  imm-i-12, xs1, lit("111"), xd, opcode-op-imm, [`andi`],
  ..comment("..."),
  lit("0000000"), shamt5, xs1, lit("001"), xd, opcode-op-imm, [`slli` #super[32]],
  lit("0010100"), shamt5, xs1, lit("001"), xd, opcode-op-imm, [`bseti` #super[32]],
  lit("0100100"), shamt5, xs1, lit("001"), xd, opcode-op-imm, [`bclri` #super[32]],
  lit("0110100"), shamt5, xs1, lit("001"), xd, opcode-op-imm, [`binvi` #super[32]],
  lit("000000"), shamt6, xs1, lit("001"), xd, opcode-op-imm, [`slli` #super[64]],
  lit("001010"), shamt6, xs1, lit("001"), xd, opcode-op-imm, [`bseti` #super[64]],
  lit("010010"), shamt6, xs1, lit("001"), xd, opcode-op-imm, [`bclri` #super[64]],
  lit("011010"), shamt6, xs1, lit("001"), xd, opcode-op-imm, [`binvi` #super[64]],
  lit("0000000"), shamt5, xs1, lit("001"), xd, opcode-op-imm32, [`slliw` #super[64]],
  lit("000010"), shamt6, xs1, lit("001"), xd, opcode-op-imm32, [`slli.uw` #super[64]],
  lit("0110000"), lit("00000"), xs1, lit("001"), xd, opcode-op-imm, [`clz`],
  lit("0110000"), lit("00000"), xs1, lit("001"), xd, opcode-op-imm32, [`clzw` #super[64]],
  lit("0110000"), lit("00001"), xs1, lit("001"), xd, opcode-op-imm, [`ctz`],
  lit("0110000"), lit("00001"), xs1, lit("001"), xd, opcode-op-imm32, [`ctzw` #super[64]],
  lit("0110000"), lit("00010"), xs1, lit("001"), xd, opcode-op-imm, [`cpop`],
  lit("0110000"), lit("00010"), xs1, lit("001"), xd, opcode-op-imm32, [`cpopw` #super[64]],
  lit("0110000"), lit("00100"), xs1, lit("001"), xd, opcode-op-imm, [`sext.b`],
  lit("0110000"), lit("00101"), xs1, lit("001"), xd, opcode-op-imm, [`sext.h`],
  ..comment("..."),
  lit("0000000"), shamt5, xs1, lit("101"), xd, opcode-op-imm, [`srli` #super[32]],
  lit("0100000"), shamt5, xs1, lit("101"), xd, opcode-op-imm, [`srai` #super[32]],
  lit("0110000"), shamt5, xs1, lit("101"), xd, opcode-op-imm, [`rori` #super[32]],
  lit("0100100"), shamt5, xs1, lit("101"), xd, opcode-op-imm, [`bexti` #super[32]],
  lit("000000"), shamt6, xs1, lit("101"), xd, opcode-op-imm, [`srli` #super[64]],
  lit("010000"), shamt6, xs1, lit("101"), xd, opcode-op-imm, [`srai` #super[64]],
  lit("011000"), shamt6, xs1, lit("101"), xd, opcode-op-imm, [`rori` #super[64]],
  lit("010010"), shamt6, xs1, lit("101"), xd, opcode-op-imm, [`bexti` #super[64]],
  lit("0000000"), shamt5, xs1, lit("101"), xd, opcode-op-imm32, [`srliw` #super[64]],
  lit("0100000"), shamt5, xs1, lit("101"), xd, opcode-op-imm32, [`sraiw` #super[64]],
  lit("0110000"), shamt5, xs1, lit("101"), xd, opcode-op-imm32, [`roriw` #super[64]],
  lit("0010100"), lit("00111"), xs1, lit("101"), xd, opcode-op-imm, [`orc.b`],
  lit("0110100"), lit("00111"), xs1, lit("101"), xd, opcode-op-imm, [`brev8`],
  lit("0110101"), lit("11000"), xs1, lit("101"), xd, opcode-op-imm, [`rev8`],
  
)

#pagebreak(weak: true)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[INTEGER (opcode = `011-011`)],
  lit("0000000"), xs2, xs1, lit("000"), xd, opcode-op, [`add`],
  lit("0000000"), xs2, xs1, lit("000"), xd, opcode-op32, [`addw` #super[64]],
  lit("0100000"), xs2, xs1, lit("000"), xd, opcode-op, [`sub`],
  lit("0100000"), xs2, xs1, lit("000"), xd, opcode-op32, [`subw` #super[64]],
  lit("0000000"), xs2, xs1, lit("001"), xd, opcode-op32, [`sllw` #super[64]],
  lit("0110000"), xs2, xs1, lit("001"), xd, opcode-op32, [`rolw` #super[64]],
  lit("0000000"), xs2, xs1, lit("101"), xd, opcode-op32, [`srlw` #super[64]],
  lit("0100000"), xs2, xs1, lit("101"), xd, opcode-op32, [`sraw` #super[64]],
  lit("0000000"), xs2, xs1, lit("010"), xd, opcode-op, [`slt`],
  lit("0000000"), xs2, xs1, lit("011"), xd, opcode-op, [`sltu`],
  lit("0000000"), xs2, xs1, lit("100"), xd, opcode-op, [`xor`],
  lit("0100000"), xs2, xs1, lit("100"), xd, opcode-op, [`xnor`],
  lit("0000000"), xs2, xs1, lit("110"), xd, opcode-op, [`or`],
  lit("0100000"), xs2, xs1, lit("110"), xd, opcode-op, [`orn`],
  lit("0000000"), xs2, xs1, lit("111"), xd, opcode-op, [`and`],
  lit("0100000"), xs2, xs1, lit("111"), xd, opcode-op, [`andn`],
  ..comment("..."),
  lit("0000001"), xs2, xs1, lit("000"), xd, opcode-op, [`mul`],
  lit("0000001"), xs2, xs1, lit("000"), xd, opcode-op32, [`mulw`],
  lit("0000001"), xs2, xs1, lit("001"), xd, opcode-op, [`mulh`],
  lit("0000001"), xs2, xs1, lit("010"), xd, opcode-op, [`mulhsu`],
  lit("0000001"), xs2, xs1, lit("011"), xd, opcode-op, [`mulhu`],
  lit("0000001"), xs2, xs1, lit("100"), xd, opcode-op, [`div`],
  lit("0000001"), xs2, xs1, lit("100"), xd, opcode-op32, [`divw`],
  lit("0000001"), xs2, xs1, lit("101"), xd, opcode-op, [`divu`],
  lit("0000001"), xs2, xs1, lit("101"), xd, opcode-op32, [`divuw`],
  lit("0000001"), xs2, xs1, lit("110"), xd, opcode-op, [`rem`],
  lit("0000001"), xs2, xs1, lit("110"), xd, opcode-op32, [`remw`],
  lit("0000001"), xs2, xs1, lit("111"), xd, opcode-op, [`remu`],
  lit("0000001"), xs2, xs1, lit("111"), xd, opcode-op32, [`remuw`],

  lit("0000100"), xs2, xs1, lit("000"), xd, opcode-op32, [`add.uw` #super[64]],
  lit("0000100"), lit("00000"), xs1, lit("100"), xd, opcode-op, [`zext.h` #super[32]],
  lit("0000100"), lit("00000"), xs1, lit("100"), xd, opcode-op32, [`zext.h` #super[64]],

  lit("0000101"), xs2, xs1, lit("001"), xd, opcode-op, [`clmul`],
  lit("0000101"), xs2, xs1, lit("010"), xd, opcode-op, [`clmulr`],
  lit("0000101"), xs2, xs1, lit("011"), xd, opcode-op, [`clmulh`],
  lit("0000101"), xs2, xs1, lit("100"), xd, opcode-op, [`min`],
  lit("0000101"), xs2, xs1, lit("101"), xd, opcode-op, [`minu`],
  lit("0000101"), xs2, xs1, lit("110"), xd, opcode-op, [`max`],
  lit("0000101"), xs2, xs1, lit("111"), xd, opcode-op, [`maxu`],

  lit("0000111"), xs2, xs1, lit("101"), xd, opcode-op, [`czero.eqz`],
  lit("0000111"), xs2, xs1, lit("111"), xd, opcode-op, [`czero.nez`],

  lit("0010000"), xs2, xs1, lit("010"), xd, opcode-op, [`sh1add`],
  lit("0010000"), xs2, xs1, lit("010"), xd, opcode-op32, [`sh1add.uw` #super[64]],
  lit("0010000"), xs2, xs1, lit("100"), xd, opcode-op, [`sh2add`],
  lit("0010000"), xs2, xs1, lit("100"), xd, opcode-op32, [`sh2add.uw` #super[64]],
  lit("0010000"), xs2, xs1, lit("110"), xd, opcode-op, [`sh3add`],
  lit("0010000"), xs2, xs1, lit("110"), xd, opcode-op32, [`sh3add.uw` #super[64]],
)

#pagebreak(weak: true)

#table(
  columns: (1fr,) * 32 + (6fr,),
  align: (center,) * 32 + (left,),
  
  table-header,

  subtitle[MISC MEM (opcode = `0001111`)],
  fm, pred, succ, xs1, lit("000"), xd, opcode-misc-mem, [`fence`],
  lit("0000"), lit("0001"), lit("0000"), lit("00000"), lit("000"), lit("00000"), opcode-misc-mem, [`pause` #super[hint]],
  lit("1000"), lit("0011"), lit("0011"), lit("00000"), lit("000"), lit("00000"), opcode-misc-mem, [`fence.tso`],
  imm-i-12, xs1, lit("001"), xd, opcode-misc-mem, [`fence.i`],
  lit("000000000000"), xs1, lit("010"), lit("00000"), opcode-misc-mem, [`cbo.inval`],
  lit("000000000001"), xs1, lit("010"), lit("00000"), opcode-misc-mem, [`cbo.clean`],
  lit("000000000010"), xs1, lit("010"), lit("00000"), opcode-misc-mem, [`cbo.flush`],
  lit("000000000100"), xs1, lit("010"), lit("00000"), opcode-misc-mem, [`cbo.zero`],




  subtitle[CSR/SYSTEM (opcode = `1110011`)],
  empty(17), lit("000"), empty(5), opcode-system, [SYSTEM],
  csr, xs1, lit("001"), xd, opcode-system, [`csrrw`],
  csr, xs1, lit("010"), xd, opcode-system, [`csrrs`],
  csr, xs1, lit("011"), xd, opcode-system, [`csrrc`],
  empty(17), lit("100"), empty(5), opcode-system, [SYSTEM],
  csr, uimm5, lit("101"), xd, opcode-system, [`csrrwi`],
  csr, uimm5, lit("110"), xd, opcode-system, [`csrrsi`],
  csr, uimm5, lit("111"), xd, opcode-system, [`csrrci`],

  subtitle[SYSTEM (opcode = `1110011`, funct = -00)],
  lit("0000000"), lit("00000"), lit("00000"), lit("000"), lit("00000"), opcode-system, [`ecall`],
  lit("0000000"), lit("00001"), lit("00000"), lit("000"), lit("00000"), opcode-system, [`ebreak`],
  lit("0000000"), lit("01101"), lit("00000"), lit("000"), lit("00000"), opcode-system, [`wrs.nto`],
  lit("0000000"), lit("11101"), lit("00000"), lit("000"), lit("00000"), opcode-system, [`wrs.sto`],

  lit("0110000"), lit("00000"), xs1, lit("100"), xd, opcode-system, [`hlv.b`],
  lit("0110000"), lit("00001"), xs1, lit("100"), xd, opcode-system, [`hlv.bu`],
  lit("0110010"), lit("00000"), xs1, lit("100"), xd, opcode-system, [`hlv.h`],
  lit("0110010"), lit("00001"), xs1, lit("100"), xd, opcode-system, [`hlv.hu`],
  lit("0110100"), lit("00000"), xs1, lit("100"), xd, opcode-system, [`hlv.w`],
  lit("0110010"), lit("00011"), xs1, lit("100"), xd, opcode-system, [`hlvx.hu`],
  lit("0110100"), lit("00011"), xs1, lit("100"), xd, opcode-system, [`hlvx.wu`],
  lit("0110100"), lit("00001"), xs1, lit("100"), xd, opcode-system, [`hlv.wu` #super[64]],
  lit("0110110"), lit("00000"), xs1, lit("100"), xd, opcode-system, [`hlv.d` #super[64]],

  lit("0110001"), xs2, xs1, lit("100"), lit("00000"), opcode-system, [`hsv.b`],
  lit("0110011"), xs2, xs1, lit("100"), lit("00000"), opcode-system, [`hsv.h`],
  lit("0110101"), xs2, xs1, lit("100"), lit("00000"), opcode-system, [`hsv.w`],
  lit("0110111"), xs2, xs1, lit("100"), lit("00000"), opcode-system, [`hsv.d` #super[64]],

  lit("1-00--0"), lit("111--"), xs1, lit("100"), xd, opcode-system, [`mop.r.{0-31}`],
  lit("1-00--1"), xs2, xs1, lit("100"), xd, opcode-system, [`mop.rr.{0-7}`],
)

// #pagebreak(weak: true)

// #table(
//   columns: (1fr,) * 32 + (6fr,),
//   align: (center,) * 32 + (left,),
  
//   table-header,

//   subtitle[SHIFT/MISC (opcode = `0-10011`, funct3 = -01)],
//   lit("000000"), shamt-rs2, xs1, lit("001"), xd, opcode-op-or-imm, [`sll(i)`],
//   lit("011000"), lit("0"), xs2, xs1, lit("001"), xd, opcode-op-or-imm, [`rol`],
//   lit("001010"), shamt-rs2, xs1, lit("001"), xd, opcode-op-or-imm, [`bset(i)`],
//   lit("010010"), shamt-rs2, xs1, lit("001"), xd, opcode-op-or-imm, [`bclr(i)`],
//   lit("011010"), shamt-rs2, xs1, lit("001"), xd, opcode-op-or-imm, [`binv(i)`],
//   lit("000000"), shamt-rs2, xs1, lit("101"), xd, opcode-op-imm, [`srl(i)`],
//   lit("010000"), shamt-rs2, xs1, lit("101"), xd, opcode-op-imm, [`sra(i)`],
//   lit("011000"), shamt-rs2, xs1, lit("101"), xd, opcode-op-imm, [`ror(i)`],
//   lit("010010"), shamt-rs2, xs1, lit("101"), xd, opcode-op-imm, [`bext(i)`],
// )
