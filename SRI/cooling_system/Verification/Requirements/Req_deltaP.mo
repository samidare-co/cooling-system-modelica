within cooling_system.Verification.Requirements;
model Req_deltaP
  "Exigence R2: Delta de pression des pompes doit être proche de 2.44 bar (±0.2 bar)"
  
  // Entrées: écarts déjà calculés par les observateurs
  Modelica.Blocks.Interfaces.RealInput u1 "Écart ΔP1 - ΔP_nominal (bar)" 
    annotation(Placement(transformation(origin={-120,40}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.RealInput u2 "Écart ΔP2 - ΔP_nominal (bar)" 
    annotation(Placement(transformation(origin={-120,-40}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.BooleanOutput y "True si exigence respectée" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
  
  parameter Real tolerance = 0.2 "Tolérance (bar)";
  
  // Vérification pompe 1 : |ΔP1 - 2.44| ≤ 0.2
  Modelica.Blocks.Math.Abs abs1 
    annotation(Placement(transformation(extent={{-40,30},{-20,50}})));
  Modelica.Blocks.Logical.LessEqualThreshold check1(threshold=tolerance) 
    annotation(Placement(transformation(origin = {-2, 0}, extent = {{0, 30}, {20, 50}})));
  
  // Vérification pompe 2 : |ΔP2 - 2.44| ≤ 0.2
  Modelica.Blocks.Math.Abs abs2 
    annotation(Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Logical.LessEqualThreshold check2(threshold=tolerance) 
    annotation(Placement(transformation(extent={{0,-50},{20,-30}})));
  
  // Les deux pompes doivent respecter la contrainte
  Modelica.Blocks.Logical.And and1 
    annotation(Placement(transformation(origin = {2, 0}, extent = {{40, -10}, {60, 10}})));

equation
  // Connexions pompe 1
  connect(u1, abs1.u);
  connect(abs1.y, check1.u) annotation(
    Line(points = {{-18, 40}, {-4, 40}}, color = {0, 0, 127}));
  
  // Connexions pompe 2
  connect(u2, abs2.u);
  connect(abs2.y, check2.u);
  
  // Sortie combinée
  connect(check1.y, and1.u1) annotation(
    Line(points = {{19, 40}, {19, 0}, {40, 0}}, color = {255, 0, 255}));
  connect(check2.y, and1.u2);
  connect(and1.y, y);
  connect(u1, abs1.u) annotation(
    Line(points = {{-120, 40}, {-42, 40}}, color = {0, 0, 127}));
  connect(check1.y, and1.u1) annotation(
    Line(points = {{22, 40}, {38, 40}, {38, 0}}, color = {255, 0, 255}));
  connect(check2.y, and1.u2) annotation(
    Line(points = {{22, -40}, {40, -40}, {40, -8}}, color = {255, 0, 255}));
  connect(and1.y, y) annotation(
    Line(points = {{64, 0}, {120, 0}}, color = {255, 0, 255}));
  connect(u2, abs2.u) annotation(
    Line(points = {{-120, -40}, {-42, -40}}, color = {0, 0, 127}));
  connect(abs2.y, check2.u) annotation(
    Line(points = {{-18, -40}, {-2, -40}}, color = {0, 0, 127}));
  connect(abs1.y, check1.u) annotation(
    Line(points = {{-18, 40}, {-2, 40}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics={
      Rectangle(fillColor={246,97,81}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,124}, extent={{-136,30},{136,-30}}, textString="%name"),
      Text(extent={{-80,40},{80,-40}}, textString="|ΔP-2.44|≤0.2")}),
    Diagram(graphics={
      Text(extent={{-56,82},{62,50}}, textColor={28,108,200},
           textString="Le delta de pression des pompes doit être
proche de 2.44 bar avec une tolérance de ±0.2 bar")}));
end Req_deltaP;