
/*
 * class GameScene
 * Created by Eqela Studio 2.0beta6
 */

class GameScene:SEScene
{
	SESprite bg;
	SESprite textscore;
	SESprite texttime;
	SEButtonEntity button;
	double player_x=0;
	double player_y=0;
	property double x = 0;
	property double y = 0;
	double runx = 0;
	double runy = 0;
	SESprite playerpress;
	

	bool pressed;

	SESprite player;
	SESprite bird;

	bool right=true;
	bool down=true;

	public void initialize(SEResourceCache rsc){
		base.initialize(rsc);
		var ba=0.1*get_scene_width();
		bg = add_sprite_for_color(Color.instance("black"), get_scene_width(), get_scene_height());
		AudioClipManager.prepare("sound");
		AudioClipManager.prepare("nobullet");
		AudioClipManager.prepare("gun");
		

		rsc.prepare_image("center", "MainScene", get_scene_width(), get_scene_height());
		rsc.prepare_image("character", "image1", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_image("birdie", "image", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_image("Quit", "exit", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_image("birdshot", "bird_shoot", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_image("playerpressed", "pressed", 0.1 * get_scene_width(), 0.1 * get_scene_height());
		rsc.prepare_font("font", "script ms bold color=black outline_color=white", ba);
	
		
		bg=add_sprite_for_image(SEImage.for_resource("center"));
		bird=add_sprite_for_image(SEImage.for_resource("birdie"));
		player = add_sprite_for_image(SEImage.for_resource("character"));
		
		
		
		
		bird.move(0.5* get_scene_width(), 0.5* get_scene_height());
		player.move(0.5* get_scene_width(), 0.5* get_scene_height());

		button = SEButtonEntity.for_image(SEImage.for_resource("Quit"));
		add_entity(button);
		button.move(0.9 * get_scene_width(), 0.9 * get_scene_height());
		
		texttime=add_sprite_for_text("Bullets","font");
		textscore=add_sprite_for_text("Score ", "font");
		
		textscore.move(0, get_scene_height() - textscore.get_height()); 
		texttime.move(0, 0);

	int y1=10;
	int x1=10;
	int speed=200;
	int bounce=0;
	int time=3600;
	int clock=60;
	int bullets=100;
	int score=0;
	int birdspeed=0;
	int firstspeed=10;
	
	}

	public void on_pointer_press(SEPointerInfo pi){

			base.on_pointer_press(pi);
			if (bullets>0){
			player.set_image(SEImage.for_resource("playerpressed"));
			texttime.set_text("Bullets: %s".printf().add(bullets).to_string());
			AudioClipManager.play("gun");
			bullets--;
			}else if (bullets==0){
				texttime.set_text("Bullets: %s".printf().add(bullets).to_string());
				AudioClipManager.play("nobullet");
			}
			pressed=true;
			if(pi.is_inside(bird.get_height(), bird.get_width(), bird.get_x(), bird.get_y())){
				bird.set_image(SEImage.for_resource("birdshot"));
			}
	}

	
	int y1=10;
	int x1=10;
	int speed=200;
	int bounce=0;
	int time=3600;
	int clock=60;
	int bullets=100;
	int score=0;
	int birdspeed=0;
	int firstspeed=10;

	public void update(TimeVal now, double delta){
		base.update(now, delta);
		

		/*bird.move(bird.get_x()+(x1*(delta*speed)), bird.get_y()+(y1*(delta*speed)));
		speed+=1;
		texttime.set_text("Bullets: %s".printf().add(bullets).to_string());

		if(bird.get_x()>get_scene_width()-100){
			speed = 200;
			x1 = x1*(-1);
			bounce++;
			
		}
		else if(bird.get_y()>get_scene_height()-100){
			speed = 200;
			y1 = y1*(-1);
			bounce++;
			totaltime=time/clock;
		}
		else if(bird.get_x()<0){
			speed = 200;
			x1 = 1;
			bounce++;
			totaltime=time/clock;
			
		}
		else if(bird.get_y()<0){
			speed = 200;
			y1 = 1;
			bounce++;
		}
		*/

		var x=bird.get_x();
		var y=bird.get_y();
		var w=bird.get_width();
		var h=bird.get_height();
		
		if (right == true){
			x = x + 15;
			if (x + w >= get_scene_width()){
				right = false;
			}
		}
		else{
			x = x-birdspeed;
			if(x < 0){
				right = true;
			}
		}

		if (down == true){
			y = y + birdspeed;
			if (y + h >= get_scene_height()){
				down = false;
			}
		}
		else{
			y = y - birdspeed;
			if(y < 0) {
				down = true;
				
			}
		}

		bird.move(x, y);

		if(button.get_pressed()){
				
			switch_scene( new MainMenu());
		}

		if (is_key_pressed("tab")){
			switch_scene( new MainMenu());
		}
		
		if(is_key_pressed("up")){
			player_y += -10;
			runy += 1;
			y += 1;
		}
					
		else if(is_key_pressed("down")){
			player_y += 10;
			runy += 1;
			y += 1;
		}
		
		 if(is_key_pressed("left")){				
			player_x += -10;
			runx += 1;
			x += 1;
		}
		
		else if(is_key_pressed("right")){
			player_x += 10;
			runx += 1;
			x += 1;
		}
		
		player.move(player_x , player_y );

		
		
		
		//player.move(player_x +delta* 200, player_y +delta* 200);
		
		foreach(SEPointerInfo pi in iterate_pointers()){
			if (pi.get_pressed()){

				//runx = pi.get_player_x();
				//runy = pi.get_player_y();
				
				player_x = ((pi.get_x()-(player.get_width()*0.5))+ (x* (runx*0.5)) /5);
				player_y = ((pi.get_y()-(player.get_width()*0.5))+ (y* (runy*0.5)) /5);

				player.move(player_x, player_y);
				birdspeed=(firstspeed-0.5)+score;
			
						
			}
		}
	}
	public void on_pointer_release(SEPointerInfo pi){
		if (bullets>0){
		player.set_image(SEImage.for_resource("character"));
			
		if (pi.is_inside(bird.get_x(), bird.get_y(), bird.get_height(), bird.get_width())){
				bird.set_image(SEImage.for_resource("birdie"));
				score++;
				AudioClipManager.play("gun");
				textscore.set_text("Score: %s".printf().add(score).to_string());
				texttime.set_text("Bullets: %s".printf().add(bullets).to_string());
				
				//bird.set_image("exit");
				AudioClipManager.play("sound");
		}
		}
		
		}
		
		
	public void cleanup(){
		base.cleanup();
		bg = SESprite.remove(bg);
		player = SESprite.remove(player);
		}
	}