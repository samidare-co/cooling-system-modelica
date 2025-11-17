within cooling_system.Verification.Observers;
model OuvertureVanne
  "Convert valve opening from signal (0-1) to percentage (0-100%)"
  
  // 输入：开度信号 (0-1)
  Modelica.Blocks.Interfaces.RealInput u "Valve opening signal (0-1)" 
    annotation(Placement(transformation(origin={-120,0}, extent={{-20,-20},{20,20}})));
  
  // 输出：开度百分比 (0-100%)
  Modelica.Blocks.Interfaces.RealOutput y "Valve opening (%)" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
  
  // 内部转换：0-1 → 0-100%
  Modelica.Blocks.Sources.Constant conversion_factor(k=100) "Convert to percentage" 
    annotation(Placement(transformation(extent={{-60,-40},{-40,-20}})));
  
  Modelica.Blocks.Math.Product product "Multiply by 100" 
    annotation(Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(u, product.u1) 
    annotation(Line(points={{-120,0},{-60,0},{-60,6},{-12,6}}, color={0,0,127}));
  connect(conversion_factor.y, product.u2) 
    annotation(Line(points={{-39,-30},{-20,-30},{-20,-6},{-12,-6}}, color={0,0,127}));
  connect(product.y, y) 
    annotation(Line(points={{11,0},{120,0}}, color={0,0,127}));
  
  annotation(
    Icon(graphics={
      Rectangle(fillColor={255,230,200}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,30}, extent={{-80,20},{80,-20}}, 
           textString="0-1 → 0-100%"),
      Text(origin={0,0}, extent={{-80,20},{80,-20}}, 
           textString="Ouverture"),
      Text(origin={0,-30}, extent={{-80,20},{80,-20}}, 
           textString="Vanne")}),
    Documentation(info="<html>
<p>Converts valve opening signal to percentage.</p>
<p>Input: Signal in range 0-1 (from VanneXXX.Ouv.signal)</p>
<p>Output: Opening percentage 0-100%</p>
<p>Example: 0.34475 → 34.475%</p>
</html>"));
end OuvertureVanne;