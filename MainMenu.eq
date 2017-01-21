
/*
 * class MainMenu
 * Created by Eqela Studio 2.0beta6
 */

class MainMenu: SEScene
{
	SESprite bg;
	SESprite head;
	SEButtonEntity button;
	SESprite Play;
	SESprite text;
	bool right=true;
	bool down=true;


	public void initialize(SEResourceCache rsc){
		base.initialize(rsc);
		var ba=0.1*get_scene_width();

		rsc.prepare_image("center", "MainScene", 1 * get_scene_width(), 1 * get_scene_height());
		rsc.prepare_image("Play", "start", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_image("logo", "logo", 0.3 * get_scene_width(), 0.3 * get_scene_height());
		//AudioClipManager.prepare("forest");

		bg = add_sprite_for_image(SEImage.for_resource("center"));

		rsc.prepare_font("key1", "bold arial color=black outline-color=white", ba);
		
		
		head = add_sprite_for_image(SEImage.for_resource("logo"));
		
		head.move(0.35 * get_scene_width(), 0.1 * get_scene_height());
		text=add_sprite_for_text("Goal Score: 50", "key1");
		

		button = SEButtonEntity.for_image(SEImage.for_resource("Play"));
		add_entity(button);
		button.move(0.9 * get_scene_width(), 0.9 * get_scene_height());



	}

	int y = 10;
	int x = 10;
	int speed = 200;
	int bounce =0;
	int time=3600;
	int clock=60;
	int totaltime;
	
	public void update(TimeVal now, double delta){
		base.update(now, delta);
		totaltime=time/clock;
		//AudioClipManager.play("forest");
		if(totaltime!=0){

			
		/*if(button.get_x()>get_scene_width()-100){
			speed = 200;
			x = x*(-1);
			bounce++;
		}
		else if(button.get_y()>get_scene_height()-100){
			speed = 200;
			y = y*(-1);
			bounce++;
		}
		else if(button.get_x()<0){
			speed = 200;
			x = 1;
			bounce++;
			
		}
		else if(button.get_y()<0){
			speed = 200;
			y = 1;
			bounce++;
		}
		*/
		var x=button.get_x();
		var y=button.get_y();
		var w=button.get_width();
		var h=button.get_height();

		if ( right== true){
			x = x + 10;
			if (x + w >= get_scene_width()){
				right = false;
			}
		}
		else{
			x = x-10;
			if(x < 0){
				right = true;
			}
		}

		if (down == true){
			y = y + 10;
			if (y + h >= get_scene_height()){
				down = false;
			}
		}
		else{
			y = y - 10;
			if(y <0) {
				down = true;
			}
		}

		button.move(x, y);
		text.move(0, get_scene_height() - text.get_height());

		
		
		if(button.get_pressed()){

			switch_scene( new GameScene());
		}
		//button.move(button.get_x()+(x*(delta*speed)), button.get_y()+(y*(delta*speed)));
		//speed+=1;
	}
}

	public void cleanup(){
		base.cleanup();
		bg =SESprite.remove(bg);
		head =SESprite.remove(head);
	}
}

