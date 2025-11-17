within cooling_system.Verification.Observers;
model EtatEchangeur
  "Display heat exchanger operational status"
  
  Modelica.Blocks.Interfaces.BooleanInput u "Heat exchanger status" 
    annotation(Placement(transformation(origin = {-122, 0}, extent = {{-20, -20}, {20, 20}}), iconTransformation(origin = {-120, 0}, extent = {{-20, -20}, {20, 20}})));
  
  // 输出：布尔值（直通）
  Modelica.Blocks.Interfaces.BooleanOutput y "Heat exchanger operational" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));

equation
  y = u;  // 直通，显示热交换器状态
  
  annotation(
    Icon(graphics={
      Rectangle(fillColor={200,220,255}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,20}, extent={{-80,30},{80,-30}}, 
           textString="Echangeur"),
      Text(origin={0,-20}, extent={{-80,20},{80,-20}}, 
           textString="ON/OFF")}),
    Documentation(info="<html>
<p>Displays heat exchanger operational status.</p>
<p>Input: Boolean from ouvreBranche1 or ouvreBranche2</p>
<p>Output: true = operational, false = isolated (maintenance)</p>
</html>"));
end EtatEchangeur;