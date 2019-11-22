signature MAIN = sig
  val main : string * string list -> OS.Process.status
  val mainthread : string -> unit
end
