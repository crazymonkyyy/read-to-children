import std;
void write(int[] a,string where){
	File out_=File(where,"w");
	foreach(i;a){
		out_.write(*(cast(char[4]*)(&i)));
	}
}

unittest{
	int[] foo;
	foreach(i;0..50){
		foo~=i;
	}
	int j=101;
	foreach(i;0..20){
		foo~=j;
		j*=2;
		j+=1;
	}
	write(foo,"test");
}
int[] read(string where){
	int[] out_;
	foreach(ubyte[4] i;File(where).byChunk(4)){
		out_~=*(cast(int*)(&i));
	}
	return out_;
}
unittest{
	foreach(i;read("test")){
		i.writeln;
	}
}