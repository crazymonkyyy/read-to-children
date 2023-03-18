enum dchar nbsp=dchar(160);
enum dchar shy=dchar(173);

unittest{
	import std;
	("super"~[shy]~"cali...").writeln;
	("to"~[nbsp]~"be").writeln;
}