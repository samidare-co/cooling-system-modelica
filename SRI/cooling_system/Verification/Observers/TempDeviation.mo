within cooling_system.Verification.Observers;

model TempDeviation
"Check if |T - 17| <= 0.5°C"
  parameter Real setpoint = 17 "Target temperature (°C)";
  parameter Real tolerance = 0.5 "Acceptable deviation (°C)";
  
  Modelica.Blocks.Interfaces.RealInput u "Temperature in °C" 
    annotation(Placement(transformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Interfaces.BooleanOutput y "True if within tolerance" 
    annotation(Placement(transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Sources.Constant sp(k = setpoint) 
    annotation(Placement(transformation(origin = {-2, -70}, extent = {{-80, 20}, {-60, 40}})));
  
  Modelica.Blocks.Math.Add diff(k2 = -1) 
    annotation(Placement(transformation(extent = {{-40, -10}, {-20, 10}})));
  
  Modelica.Blocks.Math.Abs absolute 
    annotation(Placement(transformation(extent = {{0, -10}, {20, 10}})));
  
  Modelica.Blocks.Logical.LessEqualThreshold check(threshold = tolerance) 
    annotation(Placement(transformation(extent = {{40, -10}, {60, 10}})));
equation
  connect(u, diff.u1);
  connect(sp.y, diff.u2);
  connect(diff.y, absolute.u);
  connect(absolute.y, check.u);
  connect(check.y, y);
  connect(check.y, y) annotation(
    Line(points = {{62, 0}, {120, 0}}, color = {255, 0, 255}));
  connect(diff.y, absolute.u) annotation(
    Line(points = {{-18, 0}, {-2, 0}}, color = {0, 0, 127}));
  connect(absolute.y, check.u) annotation(
    Line(points = {{22, 0}, {38, 0}}, color = {0, 0, 127}));
  connect(u, diff.u1) annotation(
    Line(points = {{-120, 0}, {-78, 0}, {-78, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(sp.y, diff.u2) annotation(
    Line(points = {{-60, -40}, {-56, -40}, {-56, -6}, {-42, -6}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics = {
      Rectangle(fillColor = {200, 200, 255}, fillPattern = FillPattern.Solid, 
                extent = {{-100, 100}, {100, -100}}),
      Text(extent = {{-90, 40}, {90, -40}}, textString = "|T-17|<=0.5")}));
end TempDeviation;