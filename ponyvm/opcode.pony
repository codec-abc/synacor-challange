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

class val Out
    let value : U16

    new val create(value' : U16) =>
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

primitive NoOp

type OpCode is (Halt | SetRegister | Push | Add | Out | NoOp)

class val ParseResult
    let op_code : OpCode
    let nb_words_read : U8

    new val create(op_code' : OpCode, nb_words_read' : U8) =>
        op_code = op_code'
        nb_words_read = nb_words_read'

primitive OpCodeReader
    fun apply(words_chunck : Seq[U16]) : ParseResult? =>
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
        | 9 =>
            let add_op_code = Add(words_chunck(1)?, words_chunck(2)?, words_chunck(3)?)
            ParseResult(add_op_code, 4)
        | 19 => 
            let out_op_code = Out(words_chunck(1)?)
            ParseResult(out_op_code, 2)
        | 21 => 
            ParseResult(NoOp, 1)
        else
            error
        end