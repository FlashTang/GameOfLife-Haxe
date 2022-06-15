package;

import openfl.utils.Timer;
import openfl.events.TimerEvent;
import openfl.geom.Point;
import openfl.display.Sprite;
typedef Size = { w : Int, h : Int }
typedef Index = { row : Int, col : Int }
class Main extends Sprite{


	var map:Array<Array<Int>> = [
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,1,1,1,0,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,1,0,1,1,1,1,1,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,1,1,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,1,1,0,0,0,0,0,0,0,1,0,0,1,1,0,1,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,1,0,0,0,0,1,0,0,0,0,0,1,0,0,1,0,0,0,0,0,0,0,0,0,0],
		[0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,0],
		[0,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0],
		[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	];

	var temp:Array<Array<Int>>;
	var sps:Array<Array<Sprite>>;
	public function new(){
		super();
		sps = [];
		for (i => a in map) {
			sps.push([]);
			for (j => b in a) {
				var sp:Sprite = new Sprite();
				sp.graphics.lineStyle(1,0x000000);
				sp.graphics.beginFill(0xff0000);
				sp.graphics.drawRect(0,0,20,20);
				sp.alpha = 0.3;
				sp.x = j * 20;
				sp.y = i * 20;
				addChild(sp);
				sps[i].push(sp);
			}
		}
		var timer:Timer = new Timer(100);
		timer.addEventListener(TimerEvent.TIMER,loop);
		timer.start();
	}

	function loop(e:TimerEvent){
		//动画
		for (i => a in map) {
			for (j => b in a) {
				sps[i][j].alpha = b == 1 ? 1 : 0.3;
			}
		}

		temp = [];
		//插入空白，用于储存
		for (index => a in map) {
			temp.push([]);
			for (b in a) {
				temp[index].push(0);
			}
		}
		//计算并储存在temp里
		for(col in 0...map.length){
			for(row in 0...map[col].length){
				temp[col][row] = alive(row,col) ? 1 : 0;
			}
		}
		//刷新
		map = temp;
		
	}

	function alive(row:Int,col):Bool {
		/*
			查找周围8个点
			789
			4o6
			123
		*/
		var indexs:Array<Index> =[
			{row:row-1,col:col+1},
			{row:row,col:col+1},
			{row:row+1,col:col+1},
			{row:row-1,col:col},
			{row:row+1,col:col},
			{row:row-1,col:col-1},
			{row:row,col:col-1},
			{row: row+1,col:col-1}
		];
        var count:Int = 0;
		for (i in indexs) {
		
			if(i.row >= 0 && i.row < map[0].length && i.col >=0 && i.col < map.length){
				if(map[i.col][i.row] == 1){
					count++;
				};
			}
		}
		//满足以下条件
		//如果是空白，周围有3个就出现一个细胞
		//如果是有细胞，周围有3个或2个细胞的就存活，否则就移除
		return (map[col][row] == 0) ? (count) == 3 : (count == 3 || count == 2);
	}
}

