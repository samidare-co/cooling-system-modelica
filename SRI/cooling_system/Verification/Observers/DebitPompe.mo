within cooling_system.Verification.Observers;
model DebitPompe
  "Convert volumetric flow rate from m³/s to m³/h and display"
  
  // 输入：体积流量 (m³/s)
  Modelica.Blocks.Interfaces.RealInput u "Volumetric flow rate in m³/s" 
    annotation(Placement(transformation(origin={-120,0}, extent={{-20,-20},{20,20}})));
  
  // 输出：流量值 (m³/h)
  Modelica.Blocks.Interfaces.RealOutput y "Flow rate in m³/h" 
    annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
  
  // 内部转换：m³/s → m³/h
  Modelica.Blocks.Sources.Constant conversion_factor(k=3600) "Conversion: s to h" 
    annotation(Placement(transformation(extent={{-60,-40},{-40,-20}})));
  
  Modelica.Blocks.Math.Product product "Multiply by 3600" 
    annotation(Placement(transformation(extent={{-10,-10},{10,10}})));

equation
  connect(u, product.u1) annotation(Line(points={{-120,0},{-60,0},{-60,6},{-12,6}}, color={0,0,127}));
  connect(conversion_factor.y, product.u2) annotation(Line(points={{-39,-30},{-20,-30},{-20,-6},{-12,-6}}, color={0,0,127}));
  connect(product.y, y) annotation(Line(points={{11,0},{120,0}}, color={0,0,127}));
  
  annotation(
    Icon(graphics={
      Rectangle(fillColor={200,255,200}, fillPattern=FillPattern.Solid, 
                extent={{-100,100},{100,-100}}),
      Text(origin={0,30}, extent={{-80,20},{80,-20}}, 
           textString="m³/s → m³/h"),
      Text(origin={0,0}, extent={{-80,20},{80,-20}}, 
           textString="Q × 3600"),
      Text(origin={0,-30}, extent={{-80,20},{80,-20}}, 
           textString="DebitPompe")}),
    Documentation(info="<html>
<p>Converts pump volumetric flow rate from m³/s to m³/h.</p>
<p>Input: Qv in m³/s (from SRI.PompeCentrifugeDynX.Qv)</p>
<p>Output: Qv in m³/h (= input × 3600)</p>
<p>Minimum required: 700 m³/h (for reference)</p>
<p>Nominal value: ~1613 m³/h per pump</p>
</html>"));
end DebitPompe;