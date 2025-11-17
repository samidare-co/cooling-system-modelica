within cooling_system.Verification.Requirements;
model Req_butees_vannes
  "Exigence R7: Respect des butées mécaniques des vannes"
  
  Modelica.Blocks.Interfaces.RealInput u_serie1 "Ouverture vanne série 1 (%)" 
    annotation(Placement(transformation(origin={-120,60}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.RealInput u_serie2 "Ouverture vanne série 2 (%)" 
    annotation(Placement(transformation(origin={-120,20}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.RealInput u_bypass "Ouverture vanne bypass (%)" 
    annotation(Placement(transformation(origin={-120,-40}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.BooleanOutput y "True si exigence respectée" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
  
  parameter Real butee_basse_serie = 5 "Butée basse vannes série (%) - assure débit min";
  parameter Real butee_haute_bypass = 60 "Butée haute vanne bypass (%) - évite vidange échangeurs";
  
  Modelica.Blocks.Logical.GreaterEqualThreshold check_serie1(threshold=butee_basse_serie) 
    annotation(Placement(transformation(extent={{-40,50},{-20,70}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold check_serie2(threshold=butee_basse_serie) 
    annotation(Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Logical.LessEqualThreshold check_bypass(threshold=butee_haute_bypass) 
    annotation(Placement(transformation(extent={{-40,-50},{-20,-30}})));
  
  Modelica.Blocks.Logical.And and1 
    annotation(Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Logical.And and2 
    annotation(Placement(transformation(extent={{50,-10},{70,10}})));

equation
  connect(u_serie1, check_serie1.u);
  connect(u_serie2, check_serie2.u);
  connect(u_bypass, check_bypass.u);
  
  connect(check_serie1.y, and1.u1) annotation(Line(points={{-19,60},{-10,60},{-10,46},{-2,46}}, color={255,0,255}));
  connect(check_serie2.y, and1.u2) annotation(Line(points={{-19,20},{-10,20},{-10,34},{-2,34}}, color={255,0,255}));
  connect(and1.y, and2.u1) annotation(Line(points={{21,40},{30,40},{30,6},{48,6}}, color={255,0,255}));
  connect(check_bypass.y, and2.u2) annotation(Line(points={{-19,-40},{30,-40},{30,-6},{48,-6}}, color={255,0,255}));
  connect(and2.y, y);
  connect(u_serie2, check_serie2.u) annotation(
    Line(points = {{-120, 20}, {-42, 20}}, color = {0, 0, 127}));
  connect(u_serie1, check_serie1.u) annotation(
    Line(points = {{-120, 60}, {-42, 60}}, color = {0, 0, 127}));
  connect(u_bypass, check_bypass.u) annotation(
    Line(points = {{-120, -40}, {-42, -40}}, color = {0, 0, 127}));
  connect(and2.y, y) annotation(
    Line(points = {{72, 0}, {120, 0}}, color = {255, 0, 255}));
  annotation(
    Icon(graphics={
      Rectangle(fillColor={246,97,81}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,124}, extent={{-136,30},{136,-30}}, textString="%name"),
      Text(extent={{-80,50},{80,10}}, textString="Série≥5%"),
      Text(extent={{-80,0},{80,-40}}, textString="Bypass≤60%")}),
    Diagram(graphics={
      Text(extent={{-68,90},{68,74}}, textColor={28,108,200},
           textString="Butée basse vannes série: 5%
(assure débit min 700 m³/h si bypass ferme)"),
      Text(extent={{-68,-62},{68,-78}}, textColor={28,108,200},
           textString="Butée haute vanne bypass: 60%
(évite vidange des échangeurs)")}));
end Req_butees_vannes;