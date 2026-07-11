`timescale 1ns / 1ps

module traffic_light_controller(
    input clk,
    input rst,
    // Special Inputs
    input pedestrian,
    input emergency,
    input vehicle_sensor,
    output reg red,
    output reg yellow,
    output reg green,
    output reg pedestrian_walk
);
// State Encoding
parameter RED    = 2'b00;
parameter GREEN  = 2'b01;
parameter YELLOW = 2'b10;
// Timing Parameters
parameter RED_TIME    = 30;
parameter GREEN_TIME  = 25;
parameter YELLOW_TIME = 5;
// Registers
reg [1:0] current_state;
reg [1:0] next_state;
// Counter
reg [7:0] counter;
// Timer Done Signal
reg timer_done;
// State Register
always @(posedge clk or posedge rst)
begin
    if(rst)
        current_state <= RED;
    else
        current_state <= next_state;
end
// Counter
always @(posedge clk or posedge rst)
begin
    if(rst)
        counter <= 0;
    else if(timer_done)
        counter <= 0;
    else
        counter <= counter + 1;
end
 // Timer Logic
 always @(*)
begin
    case(current_state)
        RED:
            timer_done = (counter >= RED_TIME);
        GREEN:
            timer_done = (counter >= GREEN_TIME);
        YELLOW:
            timer_done = (counter >= YELLOW_TIME);
        default:
            timer_done = 1'b0;
    endcase
end
// Next State Logic
always @(*)
begin
    next_state = current_state;
    case(current_state)
        RED:
        begin
            if(timer_done)
                next_state = GREEN;
        end
        GREEN:
        begin
            // Highest Priority
            if(emergency)
                next_state = YELLOW;
            // Pedestrian wants to cross
            else if(pedestrian && timer_done)
                next_state = YELLOW;
            // Heavy traffic
            else if(vehicle_sensor && counter < GREEN_TIME + 5)
                next_state = GREEN;
            else if(timer_done)
                next_state = YELLOW;
        end
        YELLOW:
        begin
            if(timer_done)
                next_state = RED;
        end
       default:
            next_state = RED;
    endcase
end
 // Output Logic
always @(*)
begin
    red = 0;
    yellow = 0;
    green = 0;
    pedestrian_walk = 0;
    case(current_state)
    // RED STATE
    RED:
    begin
        red = 1;
        // Pedestrians can safely cross only when vehicles
        // on this road are stopped.
        if(pedestrian)
            pedestrian_walk = 1;
    end
     // GREEN STATE
    GREEN:
    begin
        green = 1;
        pedestrian_walk = 0;
    end
    // YELLOW STATE
    YELLOW:
    begin
        yellow = 1;
        pedestrian_walk = 0;
    end
    default
    begin
        red = 1;
        pedestrian_walk = 0;
    end
    endcase
end
endmodule
