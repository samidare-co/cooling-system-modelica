within cooling_system.Verification.Requirements;
model Req_debitMin
  "Exigence R3: Débit minimal des pompes ≥ 700 m³/h"
  
  Modelica.Blocks.Interfaces.RealInput u1 "Débit pompe 1 (m³/h)" 
    annotation(Placement(transformation(origin = {-122, 60}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 60}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Interfaces.RealInput u2 "Débit pompe 2 (m³/h)" 
    annotation(Placement(transformation(origin={-120,0}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.RealInput u3 "Débit pompe 3 (m³/h)" 
    annotation(Placement(transformation(origin={-120,-60}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.BooleanOutput y "True si exigence respectée" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
  
  parameter Real debit_min = 700 "Débit minimum (m³/h) pour éviter cavitation";
  
  Modelica.Blocks.Logical.GreaterEqualThreshold check1(threshold=debit_min) 
    annotation(Placement(transformation(extent={{-20,50},{0,70}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold check2(threshold=debit_min) 
    annotation(Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold check3(threshold=debit_min) 
    annotation(Placement(transformation(extent={{-20,-70},{0,-50}})));
  
  Modelica.Blocks.Logical.And and1 
    annotation(Placement(transformation(origin = {0, 6}, extent = {{40, 20}, {60, 40}})));
  Modelica.Blocks.Logical.And and2 
    annotation(Placement(transformation(extent={{80,-10},{100,10}})));

equation
  connect(u1, check1.u);
  connect(u2, check2.u);
  connect(u3, check3.u);
  
  connect(check1.y, and1.u1) annotation(Line(points={{1,60},{20,60},{20,36},{38,36}}, color={255,0,255}));
  connect(check2.y, and1.u2) annotation(Line(points={{1,0},{20,0},{20,28},{38,28}}, color={255,0,255}));
  connect(and1.y, and2.u1) annotation(Line(points={{61,36},{70,36},{70,6},{78,6}}, color={255,0,255}));
  connect(check3.y, and2.u2) annotation(Line(points={{1,-60},{70,-60},{70,-6},{78,-6}}, color={255,0,255}));
  connect(and2.y, y);
  connect(u2, check2.u) annotation(
    Line(points = {{-120, 0}, {-22, 0}}, color = {0, 0, 127}));
  connect(u1, check1.u) annotation(
    Line(points = {{-122, 60}, {-22, 60}}, color = {0, 0, 127}));
  connect(u3, check3.u) annotation(
    Line(points = {{-120, -60}, {-22, -60}}, color = {0, 0, 127}));
  annotation(
    Icon(graphics={
      Rectangle(fillColor={246,97,81}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,124}, extent={{-136,30},{136,-30}}, textString="%name"),
      Text(extent={{-80,40},{80,-40}}, textString="Q≥700 m³/h")}),
    Diagram(graphics={
      Text(extent={{-56,92},{62,76}}, textColor={28,108,200},
           textString="Le débit de toutes les pompes doit rester
supérieur à 700 m³/h pour éviter la cavitation")}));
end Req_debitMin;