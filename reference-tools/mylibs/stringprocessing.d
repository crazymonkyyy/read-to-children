import unicodeenums;
import std.algorithm;
import std.conv;
//import std;
string toascii(dstring s){
	return s.substitute!([nbsp]," ".to!dstring,[shy],"".to!dstring).to!string;
}
unittest{
	import std;
	("super"~[shy]~"cali...").toascii.writeln;
	("to"~[nbsp]~"be").toascii.writeln;
}
bool isascii(dchar c){
	return c <dchar(127);
}
auto processtext(dstring s){
	import std.sumtype;
	struct range{
		dstring s;
		bool isunicode;
		long i,j;
		alias sumtype=SumType!(string,dchar);
		sumtype front(){
			//writeln(s[i..j],",",i,",",j);
			if(isunicode){
				return sumtype(s[i..j].to!dchar);
			} else {
				return sumtype(s[i..j].to!string);
		}}
		void popFront(){
			i=j;
			if(empty){return;}
			if( ! isunicode){
				isunicode=true;
				j=i+1;
				//j=s[i..$].countUntil!(a=>!a.isascii);
			} else {//if(isunicode)
				if(s[j].isascii){
					j=s[i..$].countUntil!(a=>!a.isascii);
					if(j==-1){j=s.length;}
					else{j+=i;}
					isunicode=false;
				} else {
					j=i+1;
			}}
		}
		auto pop(){
			popFront;
			return this;
		}
		bool empty(){
			return i>=s.length;
		}
	}
	bool isascii=s.length!=0?s[0].isascii:false;
	return range(s,isascii).pop;
}
unittest{
	dstring foo="Lorem ipsum dolor sit amet, 你好, consectetur adipiscing elit. 🌍 Morbi euismod, こんにちは, quam at tincidunt pulvinar, tortor metus bibendum mauris, eget vulputate lacus elit sit amet elit. Duis ullamcorper ligula at lectus bibendum, 🐶🐱 neque consectetur dapibus. Nullam eget augue ac metus maximus volutpat. 😃";
	import std.stdio;
	foo.processtext.each!writeln;
	"你好".processtext.each!writeln;
	"".processtext.each!writeln;
}