import raylib;
import basic;
import monkyyykeys;
import stringprocessing;
enum textsize=24;
enum linespaceing=2;
import raylib;
void main(string[] s){
	SetConfigFlags(ConfigFlags.FLAG_WINDOW_RESIZABLE);
	GetMonitorWidth(GetCurrentMonitor).writeln;
	InitWindow(0,0, "shitty text editor");
	SetWindowSize(GetMonitorWidth(GetCurrentMonitor)*3/4, 
			GetMonitorHeight(GetCurrentMonitor)*3/4);
	SetWindowPosition(GetMonitorWidth(GetCurrentMonitor)/8,
			GetMonitorHeight(GetCurrentMonitor)/8);
	//--- reasonable tool gui initualization
	InitAudioDevice;
	
	auto text=textwithcontext!1(s[1]);
	int i;
	int[] timing;
	Music audio=LoadMusicStream(s[2].toStringz);
	audio.writeln;
	PlayMusicStream(audio);
	audio.writeln;
	SetTargetFPS(60);
	while (!text.empty&& !WindowShouldClose()){
		"hi".writeln;stdout.flush;
		UpdateMusicStream(audio);
		"bye".writeln;stdout.flush;
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			DrawText(text.front.toascii.toStringz, 10,10, textsize, Colors.WHITE);
			if(button.mouse1.pressed){
				text.popFront;
			}
			foreach(j,t;text.context[].map!(a=>a.toascii.toStringz).enumerate){
				DrawText(t,10,100+30*cast(int)j,textsize,Colors.WHITE);
			}
			
		EndDrawing();
	}
	import timingdataformat;
	write(timing,s[3]);
	UnloadMusicStream(audio);
	CloseAudioDevice();
	CloseWindow();
}