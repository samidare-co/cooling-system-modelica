within cooling_system.Verification.Observers;
model DeltaPressure
  "Calculate pressure difference and deviation from nominal"
 
  parameter Real deltaP_nominal = 2.44 "Nominal pressure difference (bar)";
  parameter Real Pa_to_bar = 1e5 "Conversion factor from Pa to bar";
  
  // Entrées
  Modelica.Blocks.Interfaces.RealInput u1 "Inlet pressure (Pa)" 
    annotation(Placement(transformation(origin = {-110, 40}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 40}, extent = {{-20, -20}, {20, 20}})));
  
  Modelica.Blocks.Interfaces.RealInput u2 "Outlet pressure (Pa)" 
    annotation(Placement(transformation(origin = {-108, -38}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, -40}, extent = {{-20, -20}, {20, 20}})));
  
  // Sorties
  Modelica.Blocks.Interfaces.RealOutput y "Actual ΔP (bar)" 
    annotation(Placement(transformation(origin={120,40}, extent={{-20,-20},{20,20}})));
  
  Modelica.Blocks.Interfaces.RealOutput deviation "ΔP - ΔP_nominal (bar)" 
    annotation(Placement(transformation(origin={120,-40}, extent={{-20,-20},{20,20}})));
  
  // Conversion d'unités
  Modelica.Blocks.Math.Gain toBar1(k=1/Pa_to_bar) "Convert Pa to bar (inlet)" 
    annotation(Placement(transformation(extent={{-80,30},{-60,50}})));
  
  Modelica.Blocks.Math.Gain toBar2(k=1/Pa_to_bar) "Convert Pa to bar (outlet)" 
    annotation(Placement(transformation(extent={{-80,-50},{-60,-30}})));
  
  // Calcul du delta de pression
  Modelica.Blocks.Math.Add deltaP_calc(k1=1, k2=-1) "Calculate P_out - P_in" 
    annotation(Placement(transformation(extent={{-40,-10},{-20,10}})));
  
  Modelica.Blocks.Sources.Constant nominal(k=deltaP_nominal) 
    annotation(Placement(transformation(extent={{-40,-50},{-20,-30}})));
  
  Modelica.Blocks.Math.Add deviation_calc(k1=1, k2=-1) "Calculate ΔP - ΔP_nominal" 
    annotation(Placement(transformation(extent={{20,-10},{40,10}})));

equation
  // Conversion d'unités
  connect(u1, toBar1.u);
  connect(u2, toBar2.u);
  
  // Calcul du delta de pression
  connect(toBar2.y, deltaP_calc.u1);  // P_out
  connect(toBar1.y, deltaP_calc.u2);  // P_in
  connect(deltaP_calc.y, y);    // Sortie du delta de pression
  
  // Calcul de l'écart
  connect(deltaP_calc.y, deviation_calc.u1);
  connect(nominal.y, deviation_calc.u2);
  connect(deviation_calc.y, deviation);
  
  // Connexions graphiques
  connect(u1, toBar1.u) annotation(
    Line(points = {{-110, 40}, {-82, 40}}, color = {0, 0, 127}));
  connect(u2, toBar2.u) annotation(
    Line(points = {{-108, -38}, {-82, -38}}, color = {0, 0, 127}));
  connect(toBar2.y, deltaP_calc.u1) annotation(
    Line(points = {{-59, -40}, {-50, -40}, {-50, 6}, {-42, 6}}, color = {0, 0, 127}));
  connect(toBar1.y, deltaP_calc.u2) annotation(
    Line(points = {{-59, 40}, {-50, 40}, {-50, -6}, {-42, -6}}, color = {0, 0, 127}));
  connect(deltaP_calc.y, y) annotation(
    Line(points = {{-18, 0}, {-14, 0}, {-14, 40}, {120, 40}}, color = {0, 0, 127}));
  connect(deltaP_calc.y, deviation_calc.u1) annotation(
    Line(points = {{-18, 0}, {-6, 0}, {-6, 6}, {18, 6}}, color = {0, 0, 127}));
  connect(nominal.y, deviation_calc.u2) annotation(
    Line(points = {{-18, -40}, {0, -40}, {0, -6}, {18, -6}}, color = {0, 0, 127}));
  connect(deviation_calc.y, deviation) annotation(
    Line(points = {{42, 0}, {70, 0}, {70, -40}, {120, -40}}, color = {0, 0, 127}));
    
  annotation(
    Icon(graphics={
      Rectangle(fillColor={255,220,200}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,40}, extent={{-80,20},{80,-20}}, 
           textString="ΔP (bar)"),
      Text(origin={0,0}, extent={{-80,20},{80,-20}}, 
           textString="DeltaP"),
      Text(origin={0,-40}, extent={{-80,20},{80,-20}}, 
           textString="deviation")}),
    Documentation(info="<html>
<p>Ce modèle calcule la différence de pression entre l'entrée et la sortie d'une pompe,
en convertissant les valeurs de Pascal (Pa) à bar.</p>
</html>"));
end DeltaPressure;