structure Main : MAIN = struct
  val flines = ref 0
  val fwords = ref 0
  val fchars = ref 0

  fun wcCount str =
    let
      val lines = String.fields (fn x => x = #"\n") str
      val words = String.tokens Char.isSpace str
      val chars = String.explode str
    in
      [(length lines - 1), length words, length chars]
    end
  
  fun wcCountNew str =

  fun main (arg0, argv) =
    let
      val file = TextIO.openIn (hd argv)
      val str = TextIO.inputAll file
      val counts = wcCount str
      val strcounts = List.map Int.toString counts
    in
      print (String.concat [
        (String.concatWith " " strcounts), " ", hd argv, "\n"
      ]);
      OS.Process.success
    end
end
