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
	SetTargetFPS(60);
	auto text=textwithcontext!1(s[1]);
	while (!text.empty){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			DrawText(text.front.toascii.toStringz, 10,10, textsize, Colors.WHITE);
			if(button.mouse1.pressed){
				text.popFront;
			}
			foreach(i,t;text.context[].map!(a=>a.toascii.toStringz).enumerate){
				DrawText(t,10,100+30*cast(int)i,textsize,Colors.WHITE);
			}
		EndDrawing();
	}
	CloseWindow();
}