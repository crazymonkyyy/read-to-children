import unicodeenums;
import std.algorithm;
import std.conv;
import std;
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
//unittest{
//	dstring foo="Lorem ipsum dolor sit amet, 你好, consectetur adipiscing elit. 🌍 Morbi euismod, こんにちは, quam at tincidunt pulvinar, tortor metus bibendum mauris, eget vulputate lacus elit sit amet elit. Duis ullamcorper ligula at lectus bibendum, 🐶🐱 neque consectetur dapibus. Nullam eget augue ac metus maximus volutpat. 😃";
//	import std.stdio;
//	foo.processtext.each!writeln;
//	"你好".processtext.each!writeln;
//	"".processtext.each!writeln;
//}
struct textwithcontext(int n){
	import std.stdio;
	typeof(File().byLineCopy()) file;
	dstring[n*2+1] context;
	int i;
	int j;
	dstring front;
	ref dstring middle(){return context[n];}
	void popFront(){
		//context.writeln;
		import std.array;
		i++;
		auto r=middle.split!(a=>a==' '||a==shy).array;
		if(j>=cast(int)r.length-1){
			j=0;
			foreach(k;0..n*2){
				context[k]=context[k+1];
			}
			if(file.empty){
				context[$-1]="";
				return;
			}
			context[$-1]=file.front.to!dstring;
			file.popFront;
			if(middle!=""){
				front=middle.split!(a=>a==' '||a==shy).front;
			}
		} else {
			j++;
			front=r[j];
		}
	}
	bool empty(){
		return middle==""&&file.empty;
	}
	this(string s){
		file=File(s).byLineCopy;
		foreach(k;0..n+1){
			context[k+n]=file.front.to!dstring;
			file.popFront;
		}
		front=middle.split!(a=>a==' '||a==shy).front;
	}
}
unittest{
	auto foo= textwithcontext!1("bar");
	while(!foo.empty){
		writeln(foo.i,",(",foo.j,")",':',foo.front,',',foo.context);
		foo.popFront;
	}
}
//unittest{
//	foreach(s;File("bar").byLineCopy.map!(to!dstring)){
//		s.writeln;
//	}
//}