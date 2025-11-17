within cooling_system.Verification;

package Requirements_CRML
  model R1_Refined_CRML
    "Exigence R1 raffinée avec CRML: Vitesse peut dépasser 6 m/s max 10s cumulées sur 60s"
    
    import CRML.*;
    
    // Entrées depuis le modèle comportemental
    Modelica.Blocks.Interfaces.RealInput vitesse_ech1 
      "Vitesse dans échangeur 1 (m/s)" 
      annotation(Placement(transformation(origin={-120,40}, extent={{-20,-20},{20,20}})));
    
    Modelica.Blocks.Interfaces.RealInput vitesse_ech2 
      "Vitesse dans échangeur 2 (m/s)" 
      annotation(Placement(transformation(origin={-120,-40}, extent={{-20,-20},{20,20}})));
    
    // Sortie : exigence satisfaite ou non
    Modelica.Blocks.Interfaces.BooleanOutput y 
      "True si exigence respectée" 
      annotation(Placement(transformation(origin={120,0}, extent={{-20,-20},{20,20}})));
    // Paramètres
    parameter Real vitesse_max = 6.0 "Vitesse maximale nominale (m/s)";
    parameter Real duree_cumul_max = 10.0 "Durée cumulée max de dépassement (s)";
    parameter Real fenetre_glissante = 60.0 "Fenêtre d'observation (s)";
    
    // Période de test (master clock)
    CRML.TimeLocators.Continuous.Master master(
      leftBoundaryIncluded=true,
      rightBoundaryIncluded=true,
      defaultInputValue=true)
      annotation(Placement(transformation(extent={{-80,60},{-60,80}})));
    
    // Conditions de dépassement pour chaque échangeur
    Modelica.Blocks.Logical.GreaterThreshold depasseEch1(threshold=vitesse_max)
      annotation(Placement(transformation(extent={{-80,30},{-60,50}})));
    
  
  end R1_Refined_CRML;
end Requirements_CRML;