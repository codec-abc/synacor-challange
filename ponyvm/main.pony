use "collections"
use "files"
use "buffered"

primitive ReadFile
    fun apply(file : File) : List[U16] =>
        let mem : List[U16] = List[U16]
        let bytes_list : List[U8] ref = List[U8]
        while file.errno() is FileOK do
            let bytes_read : Array[U8] = file.read(1024)
            for a_byte in bytes_read.values() do
                bytes_list.push(a_byte)
            end
        end
        let rb = Reader
        let bytes = recover iso Array[U8] end
        for a_byte in bytes_list.values() do
            bytes.push(a_byte)
        end
        rb.append(consume bytes)
        var keep_going = true
        while keep_going do
            try
                let word = rb.u16_le()?
                mem.push(word)
            else
                keep_going = false
            end
        end
        mem

actor Main
    new create(env : Env) =>

        let file_name = "C:\\DEV\\pony\\synacor-challenge\\challenge.bin"
        try
            let path = FilePath(env.root as AmbientAuth, file_name)?
            match OpenFile(path)
            | let file: File =>
                let mem = ReadFile(file)
            end
        else
            Unreachable("Cannot read challenge.bin")
        end
