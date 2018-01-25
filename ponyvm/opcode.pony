primitive Halt

class val SetRegister
    let register : U16
    let value : U16

    new val create(register' : U16, value' : U16) =>
        register = register'
        value = value'

class val Push
    let value : U16

    new val create(value' : U16) =>
        value = value'

class val Pop
    let value : U16 

    new val create(value' : U16) =>
        value = value'

class val IsEqual
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val GreaterThan
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val Jump
    let value : U16

    new val create(value' : U16) =>
        value = value'

class val JumpNotZero
    let value : U16
    let cell_result : U16

    new val create(value' : U16, cell_result' : U16) =>
        cell_result = cell_result'
        value = value'

class val JumpZero
    let value : U16
    let cell_result : U16

    new val create(value' : U16, cell_result' : U16) =>
        cell_result = cell_result'
        value = value'

class val Add
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val Multiply
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val Modulo
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val And
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val Or
    let cell_result : U16
    let first_operand : U16
    let second_operand : U16

    new val create(
            cell_result' : U16, 
            first_operand' : U16, 
            second_operand' : U16
    ) =>
        cell_result = cell_result'
        first_operand = first_operand'
        second_operand = second_operand'

class val Not
    let cell_result : U16
    let operand : U16

    new val create(
            cell_result' : U16, 
            operand' : U16
    ) =>
        cell_result = cell_result'
        operand = operand'

class val ReadMemory
    let cell_result : U16
    let operand : U16

    new val create(
            cell_result' : U16, 
            operand' : U16
    ) =>
        cell_result = cell_result'
        operand = operand'

class val WriteMemory
    let cell_result : U16
    let operand : U16

    new val create(
            cell_result' : U16, 
            operand' : U16
    ) =>
        cell_result = cell_result'
        operand = operand'

class val Call
    let value : U16

    new val create(value' : U16) =>
        value = value'

primitive Return

class val Out
    let value : U16

    new val create(value' : U16) =>
        value = value'

class val In
    let value : U16

    new val create(value' : U16) =>
        value = value'

primitive NoOp

type OpCode is (
    Halt | SetRegister | Push | Pop | 
    IsEqual | GreaterThan | 
    Jump | JumpNotZero | JumpZero |
    Add | Multiply | Modulo |
    And | Or | Not | ReadMemory | WriteMemory |
    Call | Return | Out |
    In | Out | NoOp
)

class val ParseResult
    let op_code : OpCode
    let nb_words_read : U8

    new val create(op_code' : OpCode, nb_words_read' : U8) =>
        op_code = op_code'
        nb_words_read = nb_words_read'

primitive OpCodeReader
    fun apply(words_chunck : Seq[U16]) : ParseResult =>
        try
            _apply(words_chunck)?
        else
            let u : Unreachable ref = Unreachable()
            ParseResult(NoOp, 0)
        end

    fun _apply(words_chunck : Seq[U16]) : ParseResult? =>
        let first_word = words_chunck(0)?
        match first_word 
        | 0 => 
            ParseResult(Halt, 1)
        | 1 =>
            let set_op_code = SetRegister(words_chunck(1)?, words_chunck(2)?)
            ParseResult(set_op_code, 3)
        | 2 =>
            let push_op_code = Push(words_chunck(1)?)
            ParseResult(push_op_code, 2)
        | 3 =>
            let pop_op_code = Pop(words_chunck(1)?)
            ParseResult(pop_op_code, 2)
        | 4 =>
            let eq_op_code = IsEqual(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(eq_op_code, 4)
        | 5 =>
            let gt_op_code = GreaterThan(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(gt_op_code, 4)
        | 6 =>
            let jmp_op_code = Jump(words_chunck(1)?)
            ParseResult(jmp_op_code, 2)
        | 7 =>
            let jt_op_code = JumpNotZero(words_chunck(1)?, words_chunck(2)?)
            ParseResult(jt_op_code, 3) 
        | 8 =>
            let jz_op_code = JumpZero(words_chunck(1)?, words_chunck(2)?)
            ParseResult(jz_op_code, 3) 
        | 9 =>
            let add_op_code = Add(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(add_op_code, 4)
        | 10 =>
            let mult_op_code = Multiply(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(mult_op_code, 4)
        | 11 =>
            let mod_op_code = Modulo(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(mod_op_code, 4)
        | 12 =>
            let and_op_code = And(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(and_op_code, 4)
        | 13 =>
            let or_op_code = Or(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(or_op_code, 4)
        | 14 =>
            let not_op_code = Not(words_chunck(1)?, words_chunck(2)?)
            ParseResult(not_op_code, 3)
        | 15 =>
            let rmem_op_code = ReadMemory(words_chunck(1)?, words_chunck(2)?)
            ParseResult(rmem_op_code, 3)
        | 16 =>
            let wmem_op_code = WriteMemory(words_chunck(1)?, words_chunck(2)?)
            ParseResult(wmem_op_code, 3)
        | 17 =>
            let call_op_code = Call(words_chunck(1)?)
            ParseResult(call_op_code, 2)
        | 18 =>
            let ret_op_code = Return
            ParseResult(ret_op_code, 1)
        | 19 => 
            let out_op_code = Out(words_chunck(1)?)
            ParseResult(out_op_code, 2)
        | 20 =>
            let in_op_code = In(words_chunck(1)?)
            ParseResult(in_op_code, 2)
        | 21 => 
            ParseResult(NoOp, 1)
        else
            error
        end