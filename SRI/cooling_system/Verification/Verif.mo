within cooling_system.Verification;
model Verif

  Modelica.Blocks.Sources.RealExpression Q_echangeur_1(y = SRI.EchangeurAPlaques1D1.Ec.Q) annotation (
    Placement(transformation(origin={7,88},    extent = {{-15, -12}, {15, 12}})));
  Observers.FlowToSpeed flowToSpeed annotation (Placement(transformation(origin
          ={99,73}, extent={{-9,-9},{9,9}})));
  Requirements.Req_speed req_speed annotation (Placement(transformation(origin=
            {160,70}, extent={{-8,-8},{8,8}})));
  Modelica.Blocks.Sources.RealExpression Q_echangeur_2(y = SRI.EchangeurAPlaques1D2.Ec.Q) annotation (
    Placement(transformation(origin = {7, 72}, extent = {{-15, -12}, {15, 12}})));
  Observers.FlowToSpeed flowToSpeed1 annotation (Placement(transformation(
          origin={99,51}, extent={{-9,-9},{9,9}})));
  Scenarios.Scenario0_2echangeurs scenario0_2echangeurs annotation (Placement(
        transformation(origin={-178,66}, extent={{-18,-12},{18,12}})));
  Scenarios.Scenario0_1echangeur scenario0_1echangeur annotation (Placement(
        transformation(origin={-170,34},  extent={{-18,-12},{17.9999,12}})));
  Behavior.SRIN4_v4.SRI SRI annotation(
    Placement(transformation(origin = {-40, 38}, extent = {{-24, -21}, {24, 21}})));
    
  Modelica.Blocks.Sources.RealExpression Temp(y = SRI.CapteurT1.T) 
    annotation(Placement(transformation(origin={7,58}, extent={{-15,-12},{15,12}})));
    
    
  Modelica.Blocks.Sources.RealExpression P_in_pompe1(y = SRI.PompeCentrifugeDyn1.C1.P)
    annotation(Placement(transformation(origin={7,42}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression P_out_pompe1(y = SRI.PompeCentrifugeDyn1.C2.P) 
    annotation(Placement(transformation(origin={7,26}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression P_in_pompe2(y = SRI.PompeCentrifugeDyn2.C1.P) 
    annotation(Placement(transformation(origin={7,12}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression P_out_pompe2(y = SRI.PompeCentrifugeDyn2.C2.P) 
    annotation(Placement(transformation(origin={7,-2}, extent={{-15,-12},{15,12}})));
  Observers.DeltaPressure obs_deltaP_p1 
    annotation(Placement(transformation(origin={96,14}, extent={{-6,-6},{6,6}})));
  Observers.DeltaPressure obs_deltaP_p2 
    annotation(Placement(transformation(origin={96,-6}, extent={{-6,-6},{6,6}})));

  Modelica.Blocks.Sources.RealExpression Qv_pompe1(y = SRI.PompeCentrifugeDyn1.Qv) 
    annotation(Placement(transformation(origin={7,-14}, extent={{-15,-12},{15,12}}))); 
  Modelica.Blocks.Sources.RealExpression Qv_pompe2(y = SRI.PompeCentrifugeDyn2.Qv) 
    annotation(Placement(transformation(origin={7,-26}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression Qv_pompe3(y = SRI.PompeCentrifugeDyn3.Qv) 
    annotation(Placement(transformation(origin={7,-38}, extent={{-15,-12},{15,12}})));
  Observers.DebitPompe obs_debit_p1 
    annotation(Placement(transformation(origin={104,-32}, extent={{-6,-6},{6,6}})));
  Observers.DebitPompe obs_debit_p2 
    annotation(Placement(transformation(origin={104,-46}, extent={{-6,-6},{6,6}}))); 
  Observers.DebitPompe obs_debit_p3 
    annotation(Placement(transformation(origin={104,-62}, extent={{-6,-6},{6,6}}))); 
   
  Modelica.Blocks.Sources.BooleanExpression etat_ech1(y = SRI.ouvreBranche1.y ) 
    annotation(Placement(transformation(origin={44,-49}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.BooleanExpression etat_ech2(y = SRI.ouvreBranche2.y) 
    annotation(Placement(transformation(origin={46,-54}, extent={{-15,-12},{15,12}})));
  Observers.EtatEchangeur obs_etat_ech1 
    annotation(Placement(transformation(origin={81,-71}, extent={{-5,-5},{5,5}})));
  Observers.EtatEchangeur obs_etat_ech2 
    annotation(Placement(transformation(origin={89,-67}, extent={{-5,-5},{5,5}})));
    
  Modelica.Blocks.Sources.RealExpression ouv_serie1(y = SRI.VanneSerie1.Ouv.signal) 
    annotation(Placement(transformation(origin={-27,-46}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression ouv_serie2(y = SRI.VanneSerie2.Ouv.signal) 
    annotation(Placement(transformation(origin={-27,-62}, extent={{-15,-12},{15,12}})));
  Modelica.Blocks.Sources.RealExpression ouv_bypass(y = SRI.VanneBypass.Ouv.signal) 
    annotation(Placement(transformation(origin={-27,-86}, extent={{-15,-12},{15,12}})));
  Observers.OuvertureVanne obs_ouv_serie1 
    annotation(Placement(transformation(origin={15,-55}, extent={{-7,-7},{7,7}})));
  Observers.OuvertureVanne obs_ouv_serie2 
    annotation(Placement(transformation(origin={23,-73}, extent={{-7,-7},{7,7}})));
  Observers.OuvertureVanne obs_ouv_bypass 
    annotation(Placement(transformation(origin={40,-90}, extent={{-10,-10},{10,10}})));
  
  
  // R2: Delta de pression pompes
  Requirements.Req_deltaP req_deltaP 
    annotation(Placement(transformation(origin={170,-6}, extent={{-8,-8},{8,8}})));
  
  // R3: Débit minimal pompes
  Requirements.Req_debitMin req_debitMin 
    annotation(Placement(transformation(origin={168,-36}, extent={{-8,-8},{8,8}})));
  
  // R4-R5: Plage de température
  Requirements.Req_temperature req_temperature 
    annotation(Placement(transformation(origin={162,30}, extent={{-8,-8},{8,8}})));
  
  // R7: Butées vannes
  Requirements.Req_butees_vannes req_butees_vannes 
    annotation(Placement(transformation(origin={170,-76}, extent={{-8,-8},{8,8}})));
equation
  connect(Q_echangeur_1.y, flowToSpeed.u) annotation(
    Line(points = {{23.5, 88}, {57.75, 88}, {57.75, 74}, {88, 74}}, color = {0, 0, 127}));
  connect(Q_echangeur_2.y, flowToSpeed1.u) annotation(
    Line(points = {{23.5, 72}, {60, 72}, {60, 52}, {88, 52}}, color = {0, 0, 127}));
  connect(flowToSpeed.y, req_speed.u1) annotation(
    Line(points = {{110, 74}, {119.8, 74}, {119.8, 73}, {150, 73}}, color = {0, 0, 127}));
  connect(flowToSpeed1.y, req_speed.u) annotation(
    Line(points = {{110, 52}, {119.8, 52}, {119.8, 66}, {150, 66}}, color = {0, 0, 127}));
  connect(scenario0_2echangeurs.scenarioConnector, SRI.scenario) annotation(
    Line(points = {{-159, 66}, {-70, 66}, {-70, 37}, {-64, 37}}));
  connect(P_in_pompe1.y, obs_deltaP_p1.u1) annotation(
    Line(points = {{23.5, 42}, {74, 42}, {74, 16}, {89, 16}}, color = {0, 0, 127}));
  connect(P_out_pompe1.y, obs_deltaP_p1.u2) annotation(
    Line(points = {{23.5, 26}, {66.25, 26}, {66.25, 12}, {89, 12}}, color = {0, 0, 127}));
  connect(P_in_pompe2.y, obs_deltaP_p2.u1) annotation(
    Line(points = {{23.5, 12}, {66.25, 12}, {66.25, -4}, {89, -4}}, color = {0, 0, 127}));
  connect(P_out_pompe2.y, obs_deltaP_p2.u2) annotation(
    Line(points = {{23.5, -2}, {66.25, -2}, {66.25, -8}, {89, -8}}, color = {0, 0, 127}));
  connect(Qv_pompe1.y, obs_debit_p1.u) annotation(
    Line(points = {{23.5, -14}, {64.25, -14}, {64.25, -32}, {97, -32}}, color = {0, 0, 127}));
  connect(Qv_pompe2.y, obs_debit_p2.u) annotation(
    Line(points = {{23.5, -26}, {64.75, -26}, {64.75, -46}, {97, -46}}, color = {0, 0, 127}));
  connect(Qv_pompe3.y, obs_debit_p3.u) annotation(
    Line(points = {{23.5, -38}, {65.75, -38}, {65.75, -62}, {97, -62}}, color = {0, 0, 127}));
  connect(etat_ech1.y, obs_etat_ech1.u) annotation(
    Line(points = {{60.5, -49}, {60.5, -71}, {75, -71}}, color = {255, 0, 255}));
  connect(etat_ech2.y, obs_etat_ech2.u) annotation(
    Line(points = {{62.5, -54}, {62, -54}, {62, -67}, {83, -67}}, color = {255, 0, 255}));
  connect(ouv_serie1.y, obs_ouv_serie1.u) annotation(
    Line(points = {{-10, -46}, {-10, -55}, {7, -55}}, color = {0, 0, 127}));
  connect(ouv_serie2.y, obs_ouv_serie2.u) annotation(
    Line(points = {{-10, -62}, {-10, -73}, {15, -73}}, color = {0, 0, 127}));
  connect(ouv_bypass.y, obs_ouv_bypass.u) annotation(
    Line(points = {{-10, -86}, {10, -86}, {10, -90}, {28, -90}}, color = {0, 0, 127}));
  connect(obs_ouv_serie1.y, req_butees_vannes.u_serie1) annotation(
    Line(points = {{24, -54}, {56, -54}, {56, -71}, {160, -71}}, color = {0, 0, 127}));
  connect(obs_ouv_serie2.y, req_butees_vannes.u_serie2) annotation(
    Line(points = {{32, -72}, {95, -72}, {95, -74}, {160, -74}}, color = {0, 0, 127}));
  connect(obs_ouv_bypass.y, req_butees_vannes.u_bypass) annotation(
    Line(points = {{52, -90}, {138, -90}, {138, -79}, {160, -79}}, color = {0, 0, 127}));
  connect(obs_ouv_bypass.y, req_butees_vannes.u_bypass) annotation(
    Line(points = {{52, -90}, {138, -90}, {138, -74}, {158, -74}}, color = {0, 0, 127}));
  connect(obs_ouv_serie2.y, req_butees_vannes.u_serie2) annotation(
    Line(points = {{32, -72}, {158, -72}}, color = {0, 0, 127}));
  connect(obs_ouv_serie1.y, req_butees_vannes.u_serie1) annotation(
    Line(points = {{24, -54}, {56, -54}, {56, -72}, {158, -72}}, color = {0, 0, 127}));
  connect(obs_debit_p3.y, req_debitMin.u3) annotation(
    Line(points = {{112, -62}, {152, -62}, {152, -41}, {158, -41}}, color = {0, 0, 127}));
  connect(obs_debit_p2.y, req_debitMin.u2) annotation(
    Line(points = {{112, -46}, {139, -46}, {139, -36}, {158, -36}}, color = {0, 0, 127}));
  connect(obs_debit_p1.y, req_debitMin.u1) annotation(
    Line(points = {{112, -32}, {146, -32}, {146, -31}, {158, -31}}, color = {0, 0, 127}));
  connect(obs_deltaP_p1.deviation, req_deltaP.u1) annotation(
    Line(points = {{103, 12}, {144, 12}, {144, -3}, {160, -3}}, color = {0, 0, 127}));
  connect(obs_deltaP_p2.deviation, req_deltaP.u2) annotation(
    Line(points = {{103, -8}, {138, -8}, {138, -9}, {160, -9}}, color = {0, 0, 127}));
 
  connect(Temp.y, req_temperature.u) annotation(
    Line(points = {{24, 58}, {152, 58}, {152, 30}}, color = {0, 0, 127}));
  annotation(
    Diagram(graphics = {Rectangle(origin = {50, 3}, fillColor = {143, 240, 164}, fillPattern = FillPattern.Solid, extent = {{-60, 99}, {60, -99}}), Text(origin = {51, 95}, extent = {{-27, 9}, {27, -9}}, textString = "Observers"), Rectangle(origin = {163, 0}, fillColor = {249, 240, 107}, fillPattern = FillPattern.Solid, extent = {{-37, 100}, {37, -100}}), Text(origin = {165, 95}, extent = {{-27, 7}, {27, -7}}, textString = "Exigences"), Rectangle(origin = {-133, 0}, fillColor = {255, 190, 111}, fillPattern = FillPattern.Solid, extent = {{-67, 100}, {67, -100}}), Text(origin = {-135, 95}, extent = {{-35, 7}, {35, -7}}, textString = "Scenarios")}, coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    Icon(coordinateSystem(extent = {{-200, -100}, {200, 100}})),
    experiment(StartTime = 0, StopTime = 1000, Tolerance = 1e-06, Interval = 2));
end Verif;