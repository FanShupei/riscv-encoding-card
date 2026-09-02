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
#let fs3 = table.cell(colspan: 5)[fs3]
#let fd = table.cell(colspan: 5)[*fd*]
#let vs1 = table.cell(colspan: 5)[vs1]
#let vs2 = table.cell(colspan: 5)[vs2]
#let vs3 = table.cell(colspan: 5)[vs3]
#let vd = table.cell(colspan: 5)[*vd*]

#let aq = table.cell(colspan: 1)[a]
#let rl = table.cell(colspan: 1)[r]
#let aqrl = table.cell(colspan: 2)[aqrl]

#let rm = table.cell(colspan: 3)[rm]

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

// Zfa extension, fli.{s|d|h|q}
#let fimm = imm(5, "fimm")

#let opc-load      = table.cell(colspan: 7)[`0000011`]
#let opc-load-fp   = table.cell(colspan: 7)[`0000111`]
#let opc-misc-mem  = table.cell(colspan: 7)[`0001111`]
#let opc-op-imm    = table.cell(colspan: 7)[`0010011`]
#let opc-auipc     = table.cell(colspan: 7)[`0010111`]
#let opc-op-imm32  = table.cell(colspan: 7)[`001`#strong[`1`]`011`]

#let opc-store     = table.cell(colspan: 7)[`0100011`]
#let opc-store-fp  = table.cell(colspan: 7)[`0100111`]
#let opc-amo       = table.cell(colspan: 7)[`0101111`]
#let opc-op        = table.cell(colspan: 7)[`0110011`]
#let opc-lui       = table.cell(colspan: 7)[`0110111`]
#let opc-op32      = table.cell(colspan: 7)[`011`#strong[`1`]`011`]

#let opc-madd      = table.cell(colspan: 7)[`100`#strong[`00`]`11`]
#let opc-msub      = table.cell(colspan: 7)[`100`#strong[`01`]`11`]
#let opc-nmsub     = table.cell(colspan: 7)[`100`#strong[`10`]`11`]
#let opc-nmadd     = table.cell(colspan: 7)[`100`#strong[`11`]`11`]
#let opc-fp        = table.cell(colspan: 7)[`1010011`]
#let opc-v         = table.cell(colspan: 7)[`1010111`]

#let opc-branch    = table.cell(colspan: 7)[`1100011`]
#let opc-jalr      = table.cell(colspan: 7)[`1100111`]
#let opc-jal       = table.cell(colspan: 7)[`1101111`]
#let opc-system    = table.cell(colspan: 7)[`1110011`]

#let opc-op-or-imm = table.cell(colspan: 7)[`0-10011`]

#let table-header = table.header(
  [31], [30], [29], [28], [27], [26], [25], [24],
  [23], [22], [21], [20], [19], [18], [17], [16],
  [15], [14], [13], [12], [11], [10], [9], [8],
  [7], [6], [5], [4], [3], [2], [1], [0],
  [],
)

#let inst-table(..contents) = {
  set text(size: 12pt)
  show table.cell.where(x: 32): set text(size: 9pt)
  show table.cell.where(y: 0): set text(size: 8pt)
  table(
    columns: (1fr,) * 32 + (8fr,),
    align: (center+horizon,) * 32 + (left+horizon,),
    stroke: 0.5pt,
    
    table-header,

    ..contents,
  )
}

#inst-table(
  subtitle[JAL (opcode = `1101111`)],
  imm-j-20, xd, opc-jal, [`jal`],

  subtitle[JALR (opcode = `1100111`)],
  imm-i-12, xs1, lit("000"), xd, opc-jalr, [`jalr`],

  subtitle[BRANCH (opcode = `1100011`)],
  imm-b1-7, xs2, xs1, lit("000"), imm-b2-5, opc-branch, [`beq`],
  imm-b1-7, xs2, xs1, lit("001"), imm-b2-5, opc-branch, [`bne`],
  imm-b1-7, cimm, xs1, lit("010"), imm-b2-5, opc-branch, [`beqi` #super[Zibi]],
  imm-b1-7, cimm, xs1, lit("011"), imm-b2-5, opc-branch, [`bnei` #super[Zibi]],
  imm-b1-7, xs2, xs1, lit("100"), imm-b2-5, opc-branch, [`blt`],
  imm-b1-7, xs2, xs1, lit("101"), imm-b2-5, opc-branch, [`bge`],
  imm-b1-7, xs2, xs1, lit("110"), imm-b2-5, opc-branch, [`bltu`],
  imm-b1-7, xs2, xs1, lit("111"), imm-b2-5, opc-branch, [`bgeu`],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[INTEGER LOAD (opcode = `0000011`)],
  imm-i-12, xs1, lit("000"), xd, opc-load, [`lb`],
  imm-i-12, xs1, lit("001"), xd, opc-load, [`lh`],
  imm-i-12, xs1, lit("010"), xd, opc-load, [`lw`],
  imm-i-12, xs1, lit("011"), xd, opc-load, [`ld` #super[64]],
  imm-i-12, xs1, lit("100"), xd, opc-load, [`lbu`],
  imm-i-12, xs1, lit("101"), xd, opc-load, [`lhu`],
  imm-i-12, xs1, lit("110"), xd, opc-load, [`lwu` #super[64]],

  subtitle[INTEGER STORE (opcode = `0100011`)],
  imm-s1-7, xs2, xs1, lit("000"), imm-s2-5, opc-store, [`sb`],
  imm-s1-7, xs2, xs1, lit("001"), imm-s2-5, opc-store, [`sh`],
  imm-s1-7, xs2, xs1, lit("010"), imm-s2-5, opc-store, [`sw`],
  imm-s1-7, xs2, xs1, lit("011"), imm-s2-5, opc-store, [`sd` #super[64]],

  subtitle[FP/VECTOR LOAD (opcode = `0000111`)],
  empty(12), xs1, lit("000"), vd, opc-load-fp, [VECTOR[e8]],
  imm-i-12, xs1, lit("001"), fd, opc-load-fp, [`flh`],
  imm-i-12, xs1, lit("010"), fd, opc-load-fp, [`flw`],
  imm-i-12, xs1, lit("011"), fd, opc-load-fp, [`fld`],
  imm-i-12, xs1, lit("100"), fd, opc-load-fp, [`flq`],
  empty(12), xs1, lit("101"), vd, opc-load-fp, [VECTOR[e16]],
  empty(12), xs1, lit("110"), vd, opc-load-fp, [VECTOR[e32]],
  empty(12), xs1, lit("111"), vd, opc-load-fp, [VECTOR[e64]],

  subtitle[FP/VECTOR STORE (opcode = `0100111`)],
  empty(12), xs1, lit("000"), vs3, opc-store-fp, [VECTOR[e8]],
  imm-s1-7, fs2, xs1, lit("001"), imm-s2-5, opc-store-fp, [`fsh`],
  imm-s1-7, fs2, xs1, lit("010"), imm-s2-5, opc-store-fp, [`fsw`],
  imm-s1-7, fs2, xs1, lit("011"), imm-s2-5, opc-store-fp, [`fsd`],
  imm-s1-7, fs2, xs1, lit("100"), imm-s2-5, opc-store-fp, [`fsq`],
  empty(12), xs1, lit("101"), vs3, opc-store-fp, [VECTOR[e16]],
  empty(12), xs1, lit("110"), vs3, opc-store-fp, [VECTOR[e32]],
  empty(12), xs1, lit("111"), vs3, opc-store-fp, [VECTOR[e64]],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[ATOMIC (opcode = `0101111`)],
  lit("00010"), aq, rl, lit("00000"), xs1, lit("010"), xd, opc-amo, [`lr.w`],
  lit("00010"), aq, rl, lit("00000"), xs1, lit("011"), xd, opc-amo, [`lr.d` #super[64]],
  lit("00011"), aq, rl, xs2, xs1, lit("010"), xd, opc-amo, [`lr.w`],
  lit("00011"), aq, rl, xs2, xs1, lit("011"), xd, opc-amo, [`lr.d` #super[64]],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("000"), xd, opc-amo, [`lb.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("001"), xd, opc-amo, [`lh.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("010"), xd, opc-amo, [`lw.aq(rl)`],
  lit("00110"), aq, rl, lit("00000"), xs1, lit("011"), xd, opc-amo, [`ld.aq(rl)` #super[64]],
  lit("00111"), aq, rl, xs2, xs1, lit("000"), lit("00000"), opc-amo, [`sb.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("001"), lit("00000"), opc-amo, [`sh.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("010"), lit("00000"), opc-amo, [`sw.(aq)rl`],
  lit("00111"), aq, rl, xs2, xs1, lit("011"), lit("00000"), opc-amo, [`sd.(aq)rl` #super[64]],
  lit("00101"), aq, rl, xs2, xs1, lit("010"), xd, opc-amo, [`amocas.w`],
  lit("00101"), aq, rl, xs2, xs1, lit("011"), xd, opc-amo, [`amocas.d`],
  lit("00101"), aq, rl, xs2, xs1, lit("100"), xd, opc-amo, [`amocas.q` #super[64]],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[AUIPC (opcode = `0010111`)],
  imm-u-20, xd, opc-auipc, [`auipc`],

  subtitle[LUI (opcode = `0110111`)],
  imm-u-20, xd, opc-lui, [`lui`],

  subtitle[INTEGER IMMEDIATE (opcode = `001-011`)],
  imm-i-12, xs1, lit("000"), xd, opc-op-imm, [`addi`],
  imm-i-12, xs1, lit("000"), xd, opc-op-imm32, [`addiw` #super[64]],
  imm-i-12, xs1, lit("010"), xd, opc-op-imm, [`slti`],
  imm-i-12, xs1, lit("011"), xd, opc-op-imm, [`sltiu`],
  imm-i-12, xs1, lit("100"), xd, opc-op-imm, [`xori`],
  imm-i-12, xs1, lit("110"), xd, opc-op-imm, [`ori`],
  imm-i-12, xs1, lit("111"), xd, opc-op-imm, [`andi`],
  ..comment("..."),
  lit("0000000"), shamt5, xs1, lit("001"), xd, opc-op-imm, [`slli` #super[32]],
  lit("0010100"), shamt5, xs1, lit("001"), xd, opc-op-imm, [`bseti` #super[32]],
  lit("0100100"), shamt5, xs1, lit("001"), xd, opc-op-imm, [`bclri` #super[32]],
  lit("0110100"), shamt5, xs1, lit("001"), xd, opc-op-imm, [`binvi` #super[32]],
  lit("000000"), shamt6, xs1, lit("001"), xd, opc-op-imm, [`slli` #super[64]],
  lit("001010"), shamt6, xs1, lit("001"), xd, opc-op-imm, [`bseti` #super[64]],
  lit("010010"), shamt6, xs1, lit("001"), xd, opc-op-imm, [`bclri` #super[64]],
  lit("011010"), shamt6, xs1, lit("001"), xd, opc-op-imm, [`binvi` #super[64]],
  lit("0000000"), shamt5, xs1, lit("001"), xd, opc-op-imm32, [`slliw` #super[64]],
  lit("000010"), shamt6, xs1, lit("001"), xd, opc-op-imm32, [`slli.uw` #super[64]],
  lit("0110000"), lit("00000"), xs1, lit("001"), xd, opc-op-imm, [`clz`],
  lit("0110000"), lit("00000"), xs1, lit("001"), xd, opc-op-imm32, [`clzw` #super[64]],
  lit("0110000"), lit("00001"), xs1, lit("001"), xd, opc-op-imm, [`ctz`],
  lit("0110000"), lit("00001"), xs1, lit("001"), xd, opc-op-imm32, [`ctzw` #super[64]],
  lit("0110000"), lit("00010"), xs1, lit("001"), xd, opc-op-imm, [`cpop`],
  lit("0110000"), lit("00010"), xs1, lit("001"), xd, opc-op-imm32, [`cpopw` #super[64]],
  lit("0110000"), lit("00100"), xs1, lit("001"), xd, opc-op-imm, [`sext.b`],
  lit("0110000"), lit("00101"), xs1, lit("001"), xd, opc-op-imm, [`sext.h`],
  ..comment("..."),
  lit("0000000"), shamt5, xs1, lit("101"), xd, opc-op-imm, [`srli` #super[32]],
  lit("0100000"), shamt5, xs1, lit("101"), xd, opc-op-imm, [`srai` #super[32]],
  lit("0110000"), shamt5, xs1, lit("101"), xd, opc-op-imm, [`rori` #super[32]],
  lit("0100100"), shamt5, xs1, lit("101"), xd, opc-op-imm, [`bexti` #super[32]],
  lit("000000"), shamt6, xs1, lit("101"), xd, opc-op-imm, [`srli` #super[64]],
  lit("010000"), shamt6, xs1, lit("101"), xd, opc-op-imm, [`srai` #super[64]],
  lit("011000"), shamt6, xs1, lit("101"), xd, opc-op-imm, [`rori` #super[64]],
  lit("010010"), shamt6, xs1, lit("101"), xd, opc-op-imm, [`bexti` #super[64]],
  lit("0000000"), shamt5, xs1, lit("101"), xd, opc-op-imm32, [`srliw` #super[64]],
  lit("0100000"), shamt5, xs1, lit("101"), xd, opc-op-imm32, [`sraiw` #super[64]],
  lit("0110000"), shamt5, xs1, lit("101"), xd, opc-op-imm32, [`roriw` #super[64]],
  lit("0010100"), lit("00111"), xs1, lit("101"), xd, opc-op-imm, [`orc.b`],
  lit("0110100"), lit("00111"), xs1, lit("101"), xd, opc-op-imm, [`brev8`],
  lit("0110101"), lit("11000"), xs1, lit("101"), xd, opc-op-imm, [`rev8`],
  
)

#pagebreak(weak: true)

#inst-table(
  subtitle[INTEGER (opcode = `011-011`)],
  lit("0000000"), xs2, xs1, lit("000"), xd, opc-op, [`add`],
  lit("0000000"), xs2, xs1, lit("000"), xd, opc-op32, [`addw` #super[64]],
  lit("0100000"), xs2, xs1, lit("000"), xd, opc-op, [`sub`],
  lit("0100000"), xs2, xs1, lit("000"), xd, opc-op32, [`subw` #super[64]],
  lit("0000000"), xs2, xs1, lit("001"), xd, opc-op32, [`sllw` #super[64]],
  lit("0110000"), xs2, xs1, lit("001"), xd, opc-op32, [`rolw` #super[64]],
  lit("0000000"), xs2, xs1, lit("101"), xd, opc-op32, [`srlw` #super[64]],
  lit("0100000"), xs2, xs1, lit("101"), xd, opc-op32, [`sraw` #super[64]],
  lit("0000000"), xs2, xs1, lit("010"), xd, opc-op, [`slt`],
  lit("0000000"), xs2, xs1, lit("011"), xd, opc-op, [`sltu`],
  lit("0000000"), xs2, xs1, lit("100"), xd, opc-op, [`xor`],
  lit("0100000"), xs2, xs1, lit("100"), xd, opc-op, [`xnor`],
  lit("0000000"), xs2, xs1, lit("110"), xd, opc-op, [`or`],
  lit("0100000"), xs2, xs1, lit("110"), xd, opc-op, [`orn`],
  lit("0000000"), xs2, xs1, lit("111"), xd, opc-op, [`and`],
  lit("0100000"), xs2, xs1, lit("111"), xd, opc-op, [`andn`],
  ..comment("..."),
  lit("0000001"), xs2, xs1, lit("000"), xd, opc-op, [`mul`],
  lit("0000001"), xs2, xs1, lit("000"), xd, opc-op32, [`mulw`],
  lit("0000001"), xs2, xs1, lit("001"), xd, opc-op, [`mulh`],
  lit("0000001"), xs2, xs1, lit("010"), xd, opc-op, [`mulhsu`],
  lit("0000001"), xs2, xs1, lit("011"), xd, opc-op, [`mulhu`],
  lit("0000001"), xs2, xs1, lit("100"), xd, opc-op, [`div`],
  lit("0000001"), xs2, xs1, lit("100"), xd, opc-op32, [`divw`],
  lit("0000001"), xs2, xs1, lit("101"), xd, opc-op, [`divu`],
  lit("0000001"), xs2, xs1, lit("101"), xd, opc-op32, [`divuw`],
  lit("0000001"), xs2, xs1, lit("110"), xd, opc-op, [`rem`],
  lit("0000001"), xs2, xs1, lit("110"), xd, opc-op32, [`remw`],
  lit("0000001"), xs2, xs1, lit("111"), xd, opc-op, [`remu`],
  lit("0000001"), xs2, xs1, lit("111"), xd, opc-op32, [`remuw`],

  lit("0000100"), xs2, xs1, lit("000"), xd, opc-op32, [`add.uw` #super[64]],
  lit("0000100"), lit("00000"), xs1, lit("100"), xd, opc-op, [`zext.h` #super[32]],
  lit("0000100"), lit("00000"), xs1, lit("100"), xd, opc-op32, [`zext.h` #super[64]],

  lit("0000101"), xs2, xs1, lit("001"), xd, opc-op, [`clmul`],
  lit("0000101"), xs2, xs1, lit("010"), xd, opc-op, [`clmulr`],
  lit("0000101"), xs2, xs1, lit("011"), xd, opc-op, [`clmulh`],
  lit("0000101"), xs2, xs1, lit("100"), xd, opc-op, [`min`],
  lit("0000101"), xs2, xs1, lit("101"), xd, opc-op, [`minu`],
  lit("0000101"), xs2, xs1, lit("110"), xd, opc-op, [`max`],
  lit("0000101"), xs2, xs1, lit("111"), xd, opc-op, [`maxu`],

  lit("0000111"), xs2, xs1, lit("101"), xd, opc-op, [`czero.eqz`],
  lit("0000111"), xs2, xs1, lit("111"), xd, opc-op, [`czero.nez`],

  lit("0010000"), xs2, xs1, lit("010"), xd, opc-op, [`sh1add`],
  lit("0010000"), xs2, xs1, lit("010"), xd, opc-op32, [`sh1add.uw` #super[64]],
  lit("0010000"), xs2, xs1, lit("100"), xd, opc-op, [`sh2add`],
  lit("0010000"), xs2, xs1, lit("100"), xd, opc-op32, [`sh2add.uw` #super[64]],
  lit("0010000"), xs2, xs1, lit("110"), xd, opc-op, [`sh3add`],
  lit("0010000"), xs2, xs1, lit("110"), xd, opc-op32, [`sh3add.uw` #super[64]],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[FP FMA (opcode = `100--11`)\ (`s=00`, `d=01`, `h=10`, `q=11`)],
  fs3, lit("--"), fs2, fs1, rm, fd, opc-madd, [`fmadd.{s|d|h|q}`],
  fs3, lit("--"), fs2, fs1, rm, fd, opc-msub, [`fmsub.{s|d|h|q}`],
  fs3, lit("--"), fs2, fs1, rm, fd, opc-nmsub, [`fnmsub.{s|d|h|q}`],
  fs3, lit("--"), fs2, fs1, rm, fd, opc-nmadd, [`fnmadd.{s|d|h|q}`],

  subtitle[FP COMPUTATION (opcode = `1010011`)\ (`s=00`, `d=01`, `h=10`, `q=11`)],
  lit("00000"), lit("--"), fs2, fs1, rm, fd, opc-fp, [`fadd.{s|d|h|q}`],
  lit("00001"), lit("--"), fs2, fs1, rm, fd, opc-fp, [`fsub.{s|d|h|q}`],
  lit("00010"), lit("--"), fs2, fs1, rm, fd, opc-fp, [`fmul.{s|d|h|q}`],
  lit("00011"), lit("--"), fs2, fs1, rm, fd, opc-fp, [`fdiv.{s|d|h|q}`],
  lit("00100"), lit("--"), fs2, fs1, lit("000"), fd, opc-fp, [`fsgnj.{s|d|h|q}`],
  lit("00100"), lit("--"), fs2, fs1, lit("001"), fd, opc-fp, [`fsgnjn.{s|d|h|q}`],
  lit("00100"), lit("--"), fs2, fs1, lit("010"), fd, opc-fp, [`fsgnjx.{s|d|h|q}`],
  lit("00101"), lit("--"), fs2, fs1, lit("000"), fd, opc-fp, [`fmin.{s|d|h|q}`],
  lit("00101"), lit("--"), fs2, fs1, lit("001"), fd, opc-fp, [`fmax.{s|d|h|q}`],
  lit("00101"), lit("--"), fs2, fs1, lit("010"), fd, opc-fp, [`fminm.{s|d|h|q}`],
  lit("00101"), lit("--"), fs2, fs1, lit("011"), fd, opc-fp, [`fmaxm.{s|d|h|q}`],
  lit("01011"), lit("--"), lit("00000"), fs1, rm, fd, opc-fp, [`fsqrt.{s|d|h|q}`],

  subtitle[FP CONVERSION/ROUNDING (opcode = `1010011`)],
  lit("01000"), lit("00"), lit("00001"), fs1, rm, fd, opc-fp, [`fcvt.s.d`],
  lit("01000"), lit("00"), lit("00010"), fs1, rm, fd, opc-fp, [`fcvt.s.h`],
  lit("01000"), lit("00"), lit("00011"), fs1, rm, fd, opc-fp, [`fcvt.s.q`],
  lit("01000"), lit("00"), lit("00110"), fs1, rm, fd, opc-fp, [`fcvt.s.bf16`],
  lit("01000"), lit("01"), lit("00000"), fs1, rm, fd, opc-fp, [`fcvt.d.s`],
  lit("01000"), lit("01"), lit("00010"), fs1, rm, fd, opc-fp, [`fcvt.d.h`],
  lit("01000"), lit("01"), lit("00011"), fs1, rm, fd, opc-fp, [`fcvt.d.q`],
  lit("01000"), lit("10"), lit("00000"), fs1, rm, fd, opc-fp, [`fcvt.h.s`],
  lit("01000"), lit("10"), lit("00001"), fs1, rm, fd, opc-fp, [`fcvt.h.d`],
  lit("01000"), lit("10"), lit("00011"), fs1, rm, fd, opc-fp, [`fcvt.h.q`],
  lit("01000"), lit("10"), lit("01000"), fs1, rm, fd, opc-fp, [`fcvt.bf16.s`],
  lit("01000"), lit("11"), lit("00000"), fs1, rm, fd, opc-fp, [`fcvt.q.s`],
  lit("01000"), lit("11"), lit("00001"), fs1, rm, fd, opc-fp, [`fcvt.q.d`],
  lit("01000"), lit("11"), lit("00010"), fs1, rm, fd, opc-fp, [`fcvt.q.h`],
  lit("01000"), lit("--"), lit("00100"), fs1, rm, fd, opc-fp, [`fround.{s|d|h|q}`],
  lit("01000"), lit("--"), lit("00101"), fs1, rm, fd, opc-fp, [`froundnx.{s|d|h|q}`],

  subtitle[FP COMPARISON (opcode = `1010011`)\ (`s=00`, `d=01`, `h=10`, `q=11`)],
  lit("10100"), lit("--"), fs2, fs1, lit("000"), fd, opc-fp, [`fle.{s|d|h|q}`],
  lit("10100"), lit("--"), fs2, fs1, lit("001"), fd, opc-fp, [`flt.{s|d|h|q}`],
  lit("10100"), lit("--"), fs2, fs1, lit("010"), fd, opc-fp, [`feq.{s|d|h|q}`],
  lit("10100"), lit("--"), fs2, fs1, lit("100"), fd, opc-fp, [`fleq.{s|d|h|q}`],
  lit("10100"), lit("--"), fs2, fs1, lit("101"), fd, opc-fp, [`fltq.{s|d|h|q}`],

  subtitle[FP/INT CONVERSION (opcode = `1010011`)\ (`s=00`, `d=01`, `h=10`, `q=11`)],
  lit("11000"), lit("--"), lit("00000"), fs1, rm, xd, opc-fp, [`fcvt.w.{s|d|h|q}`],
  lit("11000"), lit("--"), lit("00001"), fs1, rm, xd, opc-fp, [`fcvt.wu.{s|d|h|q}`],
  lit("11000"), lit("--"), lit("00010"), fs1, rm, xd, opc-fp, [`fcvt.l.{s|d|h|q}` #super[64]],
  lit("11000"), lit("--"), lit("00011"), fs1, rm, xd, opc-fp, [`fcvt.lu.{s|d|h|q}` #super[64]],
  lit("11000"), lit("01"), lit("01000"), fs1, lit("001"), xd, opc-fp, [`fcvtmod.w.d`],
  lit("11010"), lit("--"), lit("00000"), xs1, rm, fd, opc-fp, [`fcvt.{s|d|h|q}.w`],
  lit("11010"), lit("--"), lit("00001"), xs1, rm, fd, opc-fp, [`fcvt.{s|d|h|q}.wu`],
  lit("11010"), lit("--"), lit("00010"), xs1, rm, fd, opc-fp, [`fcvt.{s|d|h|q}.l` #super[64]],
  lit("11010"), lit("--"), lit("00011"), xs1, rm, fd, opc-fp, [`fcvt.{s|d|h|q}.lu` #super[64]],

  subtitle[FP MISC (opcode = `1010011`)],
  lit("11100"), lit("00"), lit("00000"), fs1, lit("000"), xd, opc-fp, [`fmv.x.w`],
  lit("11100"), lit("--"), lit("00000"), fs1, lit("001"), xd, opc-fp, [`fclass.{s|d|h|q}`],
  lit("11110"), lit("00"), lit("00000"), xs1, lit("000"), fd, opc-fp, [`fmv.w.x`],
  lit("11110"), lit("--"), lit("00001"), fimm, lit("000"), fd, opc-fp, [`fli.{s|d|h|q}`],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[Vector Configuration (opcode = `1010111`)],
  lit("0"), imm(11, "vtypei[10:0]"), xs1, lit("111"), xd, opc-v, [`vsetvli`],
  lit("1"), lit("1"), imm(10, "vtypei[9:0]"), uimm5, lit("111"), xd, opc-v, [`vsetivli`],
  lit("1"), lit("0"), lit("00000"), xs2, xs1, lit("111"), xd, opc-v, [`vsetvl`],
)

#pagebreak(weak: true)

#inst-table(
  subtitle[MISC MEM (opcode = `0001111`)],
  fm, pred, succ, xs1, lit("000"), xd, opc-misc-mem, [`fence`],
  lit("0000"), lit("0001"), lit("0000"), lit("00000"), lit("000"), lit("00000"), opc-misc-mem, [`pause` #super[hint]],
  lit("1000"), lit("0011"), lit("0011"), lit("00000"), lit("000"), lit("00000"), opc-misc-mem, [`fence.tso`],
  imm-i-12, xs1, lit("001"), xd, opc-misc-mem, [`fence.i`],
  lit("000000000000"), xs1, lit("010"), lit("00000"), opc-misc-mem, [`cbo.inval`],
  lit("000000000001"), xs1, lit("010"), lit("00000"), opc-misc-mem, [`cbo.clean`],
  lit("000000000010"), xs1, lit("010"), lit("00000"), opc-misc-mem, [`cbo.flush`],
  lit("000000000100"), xs1, lit("010"), lit("00000"), opc-misc-mem, [`cbo.zero`],

  subtitle[CSR/SYSTEM (opcode = `1110011`)],
  empty(17), lit("000"), empty(5), opc-system, [SYSTEM],
  csr, xs1, lit("001"), xd, opc-system, [`csrrw`],
  csr, xs1, lit("010"), xd, opc-system, [`csrrs`],
  csr, xs1, lit("011"), xd, opc-system, [`csrrc`],
  empty(17), lit("100"), empty(5), opc-system, [SYSTEM],
  csr, uimm5, lit("101"), xd, opc-system, [`csrrwi`],
  csr, uimm5, lit("110"), xd, opc-system, [`csrrsi`],
  csr, uimm5, lit("111"), xd, opc-system, [`csrrci`],

  subtitle[SYSTEM (opcode = `1110011`, funct = -00)],
  lit("0000000"), lit("00000"), lit("00000"), lit("000"), lit("00000"), opc-system, [`ecall`],
  lit("0000000"), lit("00001"), lit("00000"), lit("000"), lit("00000"), opc-system, [`ebreak`],
  lit("0000000"), lit("01101"), lit("00000"), lit("000"), lit("00000"), opc-system, [`wrs.nto`],
  lit("0000000"), lit("11101"), lit("00000"), lit("000"), lit("00000"), opc-system, [`wrs.sto`],

  lit("0110000"), lit("00000"), xs1, lit("100"), xd, opc-system, [`hlv.b`],
  lit("0110000"), lit("00001"), xs1, lit("100"), xd, opc-system, [`hlv.bu`],
  lit("0110010"), lit("00000"), xs1, lit("100"), xd, opc-system, [`hlv.h`],
  lit("0110010"), lit("00001"), xs1, lit("100"), xd, opc-system, [`hlv.hu`],
  lit("0110100"), lit("00000"), xs1, lit("100"), xd, opc-system, [`hlv.w`],
  lit("0110010"), lit("00011"), xs1, lit("100"), xd, opc-system, [`hlvx.hu`],
  lit("0110100"), lit("00011"), xs1, lit("100"), xd, opc-system, [`hlvx.wu`],
  lit("0110100"), lit("00001"), xs1, lit("100"), xd, opc-system, [`hlv.wu` #super[64]],
  lit("0110110"), lit("00000"), xs1, lit("100"), xd, opc-system, [`hlv.d` #super[64]],

  lit("0110001"), xs2, xs1, lit("100"), lit("00000"), opc-system, [`hsv.b`],
  lit("0110011"), xs2, xs1, lit("100"), lit("00000"), opc-system, [`hsv.h`],
  lit("0110101"), xs2, xs1, lit("100"), lit("00000"), opc-system, [`hsv.w`],
  lit("0110111"), xs2, xs1, lit("100"), lit("00000"), opc-system, [`hsv.d` #super[64]],

  lit("1-00--0"), lit("111--"), xs1, lit("100"), xd, opc-system, [`mop.r.{0-31}`],
  lit("1-00--1"), xs2, xs1, lit("100"), xd, opc-system, [`mop.rr.{0-7}`],
)

// #pagebreak(weak: true)

// #table(
//   columns: (1fr,) * 32 + (6fr,),
//   align: (center,) * 32 + (left,),
  
//   table-header,

//   subtitle[SHIFT/MISC (opcode = `0-10011`, funct3 = -01)],
//   lit("000000"), shamt-rs2, xs1, lit("001"), xd, opc-op-or-imm, [`sll(i)`],
//   lit("011000"), lit("0"), xs2, xs1, lit("001"), xd, opc-op-or-imm, [`rol`],
//   lit("001010"), shamt-rs2, xs1, lit("001"), xd, opc-op-or-imm, [`bset(i)`],
//   lit("010010"), shamt-rs2, xs1, lit("001"), xd, opc-op-or-imm, [`bclr(i)`],
//   lit("011010"), shamt-rs2, xs1, lit("001"), xd, opc-op-or-imm, [`binv(i)`],
//   lit("000000"), shamt-rs2, xs1, lit("101"), xd, opc-op-imm, [`srl(i)`],
//   lit("010000"), shamt-rs2, xs1, lit("101"), xd, opc-op-imm, [`sra(i)`],
//   lit("011000"), shamt-rs2, xs1, lit("101"), xd, opc-op-imm, [`ror(i)`],
//   lit("010010"), shamt-rs2, xs1, lit("101"), xd, opc-op-imm, [`bext(i)`],
// )
