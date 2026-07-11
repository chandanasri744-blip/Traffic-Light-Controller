`timescale 1ns/1ps

module traffic_light_controller_tb;
reg clk;
reg rst;
reg pedestrian;
reg emergency;
reg vehicle_sensor;
wire red;
wire yellow;
wire green;
wire pedestrian_walk;
traffic_light_controller DUT(
    .clk(clk),
    .rst(rst),
    .pedestrian(pedestrian),
    .emergency(emergency),
    .vehicle_sensor(vehicle_sensor),
    .red(red),
    .yellow(yellow),
    .green(green),
    .pedestrian_walk(pedestrian_walk)
);
always #5 clk = ~clk;
// Stimulus
initial
begin
    // Initialize Inputs
    clk = 0;
    rst = 1;
    pedestrian = 0;
    emergency = 0;
    vehicle_sensor = 0;
    // Apply Reset
    #20;
    rst = 0;
     // Normal Operation
    #100;
    // Pedestrian Request
    pedestrian = 1;
    #50;
    pedestrian = 0;
    // Heavy Traffic
    vehicle_sensor = 1;
    #80;
    vehicle_sensor = 0;
    // Emergency Vehicle
    emergency = 1;
    #30;
    emergency = 0;
    // Continue Simulation
    #150;
    $finish;
end
 // Monitor
initial
begin
$monitor("TIME=%0t RESET=%b RED=%b GREEN=%b YELLOW=%b PED=%b EMER=%b VEH=%b WALK=%b",
$time,
rst,
red,
green,
yellow,
pedestrian,
emergency,
vehicle_sensor,
pedestrian_walk);
end
endmodule