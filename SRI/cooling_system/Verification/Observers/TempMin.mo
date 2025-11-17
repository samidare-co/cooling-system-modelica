within cooling_system.Verification.Observers;
model TempMin
  "Observer to track minimum temperature over time"
  
  Modelica.Blocks.Interfaces.RealInput u "Temperature in K" 
    annotation(Placement(transformation(origin = {-108, 0}, extent = {{-20, -20}, {20, 20}}), 
               iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Interfaces.RealOutput y "Minimum temperature recorded (°C)" 
    annotation(Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Real minTemp(start = 500, fixed = true) "Minimum temperature tracker (K)";
  
equation
  der(minTemp) = if u < minTemp then (u - minTemp)/1e-6 else 0;
  y = minTemp - 273.15;
    
  annotation(
    Icon(graphics = {
      Rectangle(fillColor = {200, 255, 200}, fillPattern = FillPattern.Solid, 
                extent = {{-100, 100}, {100, -100}}),
      Text(origin = {0, 120}, extent = {{-100, 20}, {100, -20}}, textString = "%name"),
      Text(extent = {{-80, 40}, {80, -40}}, textString = "T_min")}));
end TempMin;