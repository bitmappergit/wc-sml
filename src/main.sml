structure Main : MAIN = struct
  open CML

  fun getLines str = String.fields (fn x => x = #"\n") str
  fun countLines str = let
    val ch1 : string list chan = channel()
    val ch2 : int chan = channel()
    val _ = spawn (fn () => send (ch1, getLines str))
    val _ = spawn (fn () => send (ch2, length (recv ch1)))
  in
    (recv ch2) - 1
  end

  fun getWords str = String.tokens Char.isSpace str
  fun countWords str = let
    val ch1 : string list chan = channel()
    val ch2 : int chan = channel()
    val _ = spawn (fn () => send (ch1, getWords str))
    val _ = spawn (fn () => send (ch2, length (recv ch1)))
  in
    (recv ch2)
  end

  fun countChars str = String.size str

  fun mainthread file = let
    val c1 : int chan = channel()
    val c2 : int chan = channel()
    val c3 : int chan = channel()
    fun contents () = TextIO.inputAll (TextIO.openIn file)
    val _ = spawn (fn () => send (c1, countLines (contents())))
    val _ = spawn (fn () => send (c2, countWords (contents())))
    val _ = spawn (fn () => send (c3, countChars (contents())))
  in
    print (Int.toString (recv c1)); print " ";
    print (Int.toString (recv c2)); print " ";
    print (Int.toString (recv c3)); print "\n"
  end

  fun main (arg0, argv) = let
    val _ = RunCML.doit ((fn () => mainthread (hd argv)), NONE)
  in
    OS.Process.success
  end
end
