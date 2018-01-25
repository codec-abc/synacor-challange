use "collections"

actor Main
    new create(env : Env) =>
        //let memory : Array[U16] ref = [9; 32768; 32769; 4; 19; 32768]
        for i in Range[U16](0, 22) do
            let memory : Array[U16] = Array[U16].init(i, 15)
            let first_op_code_result = OpCodeReader(memory)
            env.out.print("opcode " + i.string() + " => bytes read " + first_op_code_result.nb_words_read.string())
        end