module lineFollowingRobot(output reg left_motor1, left_motor2, right_motor1, right_motor2, ena, enb, LED_ON,
					output reg [2:0] LED_LEFT, LED_RIGHT, LED_STR,
				   input wire ir_sensor1, ir_sensor2, ir_sensor3, clk);

	initial
		begin
		LED_ON = 1;
		LED_STR = 3'b000;
		LED_LEFT = 3'b000;
		LED_RIGHT = 3'b000;
		end
	
	
	
	
	
	reg [7:0] counter = 100;
	
	always @ (posedge clk)
	begin: PWM
		if (counter < 100)
		begin
			counter <= counter + 1;
		end
		else 
		begin
			counter <= 0;
		end
	end
	
	always @ (counter)
	begin: PWM_counter
		if (counter < 55)
		begin
			ena = 1;
			enb = 1;
		end
		else
		begin
			ena = 0;
			enb = 0;
		end
	end
	
	always @ (ir_sensor1, ir_sensor2, ir_sensor3)
		begin: sensors
		if ( ir_sensor1 == 0 &&  ir_sensor2 == 1 && ir_sensor3 == 0)
			begin
						//go forward
						left_motor1 = 1;
						left_motor2 = 0;
						right_motor1 = 1;
						right_motor2 = 0;
						
						//Check for direction
						LED_ON = 1;
						LED_STR = 3'b111;
			end
			
		else if (ir_sensor1 == 1 && ir_sensor2 == 0 && ir_sensor3 == 0)
			begin
						// go left
						left_motor1 = 0;
						left_motor2 = 1;
						right_motor1 = 1;
						right_motor2 = 0;
						
						//Check for direction
						LED_ON = 1;
						LED_LEFT = 3'b111;
						
			end
			
		else if (ir_sensor1 == 0 && ir_sensor2 == 0 && ir_sensor3 == 1)
			begin
						// go right 
						left_motor1 = 1;
						left_motor2 = 0;
						right_motor1 = 0;
						right_motor2 = 1;
						
						//Check for direction
						LED_ON = 1;
						LED_RIGHT = 3'b111;
			end

		else
			begin
						left_motor1 = 0;
						left_motor2 = 0;
						right_motor1 = 0;
						right_motor2 = 0;
						
						//Check for direction
						LED_STR = 3'b000;
						LED_LEFT = 3'b000;
						LED_RIGHT = 3'b000;
						LED_ON = 1;
			end
		
		end
	endmodule
	
