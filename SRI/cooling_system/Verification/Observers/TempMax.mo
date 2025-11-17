within cooling_system.Verification.Observers;
model TempMax
  "Observer to track maximum temperature over time"
  
  Modelica.Blocks.Interfaces.RealInput u "Temperature in K" 
    annotation(Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Interfaces.RealOutput y "Maximum temperature recorded (°C)" 
    annotation(Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Real maxTemp(start = 0, fixed = true) "Maximum temperature tracker (K)";
  
equation
  der(maxTemp) = if u > maxTemp then (u - maxTemp)/1e-6 else 0;
  y = maxTemp - 273.15;
    
  annotation(
    Icon(graphics = {
      Rectangle(fillColor = {255, 200, 200}, fillPattern = FillPattern.Solid, 
                extent = {{-100, 100}, {100, -100}}),
      Text(origin = {0, 120}, extent = {{-100, 20}, {100, -20}}, textString = "%name"),
      Text(extent = {{-80, 40}, {80, -40}}, textString = "T_max")}));
end TempMax;