within cooling_system.Verification.Requirements;
model Req_temperature
  "Exigence R4-R5: Température dans les limites [16°C - 30°C]"

  Modelica.Blocks.Interfaces.RealInput u "Température actuelle (K)"
    annotation(Placement(transformation(origin={-120,0}, extent={{-20,-20},{20,20}})));

  Modelica.Blocks.Interfaces.BooleanOutput y "True si exigence respectée"
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
    
  Modelica.Blocks.Interfaces.RealOutput T_celsius "Température en °C (pour vérification)"
    annotation(Placement(transformation(origin={120,-60}, extent={{-20,-20},{20,20}})));

  // Conversion K -> °C (T_celsius = T_kelvin - 273.15)
  Modelica.Blocks.Math.Add toCelsius(k1=+1, k2=-1)
    annotation(Placement(transformation(extent={{-60,-10},{-40,10}})));

  Modelica.Blocks.Sources.Constant kelvinOffset(k=273.15)
    annotation(Placement(transformation(extent={{-100,-30},{-80,-10}})));

  // Vérification température minimale (T >= 16°C)
  Modelica.Blocks.Logical.GreaterEqualThreshold check_min(threshold=16.0)
    annotation(Placement(transformation(extent={{0,20},{20,40}})));

  // Vérification température maximale (T <= 30°C)
  // Alternative si LessEqualThreshold n'existe pas dans votre version
  Modelica.Blocks.Logical.GreaterThreshold check_above_max(threshold=30.0)
    annotation(Placement(transformation(extent={{0,-40},{20,-20}})));
    
  Modelica.Blocks.Logical.Not not1 "Inverse pour obtenir T <= 30"
    annotation(Placement(transformation(extent={{30,-40},{50,-20}})));

  // Combinaison des deux conditions
  Modelica.Blocks.Logical.And and1
    annotation(Placement(transformation(extent={{60,-10},{80,10}})));

equation
  connect(u, toCelsius.u1) 
    annotation(Line(points={{-120,0},{-80,0},{-80,6},{-62,6}}, color={0,0,127}));
  connect(kelvinOffset.y, toCelsius.u2) 
    annotation(Line(points={{-79,-20},{-70,-20},{-70,-6},{-62,-6}}, color={0,0,127}));
  
  // Sortie de la température convertie pour vérification
  connect(toCelsius.y, T_celsius)
    annotation(Line(points={{-39,0},{-30,0},{-30,-60},{120,-60}}, color={0,0,127}));
  
  connect(toCelsius.y, check_min.u) 
    annotation(Line(points={{-39,0},{-20,0},{-20,30},{-2,30}}, color={0,0,127}));
  connect(toCelsius.y, check_above_max.u) 
    annotation(Line(points={{-39,0},{-20,0},{-20,-30},{-2,-30}}, color={0,0,127}));
  
  connect(check_above_max.y, not1.u)
    annotation(Line(points={{21,-30},{28,-30}}, color={255,0,255}));
  connect(check_min.y, and1.u1) 
    annotation(Line(points={{21,30},{40,30},{40,6},{58,6}}, color={255,0,255}));
  connect(not1.y, and1.u2) 
    annotation(Line(points={{51,-30},{54,-30},{54,-6},{58,-6}}, color={255,0,255}));
  connect(and1.y, y) 
    annotation(Line(points={{81,0},{120,0}}, color={255,0,255}));

  annotation(
    Icon(graphics={
      Rectangle(fillColor={246,97,81}, fillPattern=FillPattern.Solid,
        extent={{-100,100},{100,-100}}),
      Text(origin={0,124}, extent={{-136,30},{136,-30}}, textString="%name"),
      Text(extent={{-80,40},{80,-40}}, textString="16≤T≤30"),
      Text(origin={0,-70}, extent={{-80,20},{80,-20}}, textString="T_°C")}));
end Req_temperature;