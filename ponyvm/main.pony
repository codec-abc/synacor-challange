use "collections"

class val LiteralValue
    let _value : U16

    new val create(number : U16) =>
        _value = number
    
    fun apply() : U16 =>
        _value

class val Register
    let _register_index : U16

    new val create(number : U16) =>
        _register_index = number
    
    fun apply() : U16 =>
        _register_index

primitive InvalidNumber

type ParsedNumber is (LiteralValue | Register | InvalidNumber)

primitive NumberChecker
    fun apply(number : U16) : ParsedNumber val =>
        if number <= 32767 then
            LiteralValue(number)
        elseif number <= 32775 then
            Register(number - 32768)
        else 
            InvalidNumber
        end

class ref VM
    let _memory : Array[U16]
    let _register : Array[U16]
    let _stack : List[U16]
    let _program_counter : U16

    new ref create() =>
        _memory = Array[U16].init(0, 32768)
        _register = Array[U16].init(0, 8)
        _stack = List[U16]()
        _program_counter = 0

actor Main
    new create(env : Env) =>
        try
            let memory : Array[U16] ref = [9; 32768; 32769; 4; 19; 32768]
            let first_op_code_result = OpCodeReader(memory)?
            env.out.print("bytes read " + first_op_code_result.nb_words_read.string())
        else
            Unreachable()
        end