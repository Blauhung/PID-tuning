void setupUI(){
  controlP5 = new ControlP5(this);
  
/*--- setup fields ---*/ 
    probe1field = controlP5.addTextfield("Probe 1")
       .setPosition(field1StartX,field1StartY)
       .setSize(fieldSizeX,fieldSizeY)
       .setFont(TitleFont)
       .setFocus(true)
       .setColor(color(255,0,0));
    
    probe2field = controlP5.addTextfield("Probe 2")
       .setPosition(field1StartX,field1StartY + 1*(fieldSizeY + 1*fieldSpaceY))
       .setSize(fieldSizeX,fieldSizeY)
       .setFont(TitleFont)
       .setFocus(true)
       .setColor(color(0,255,0));
    
    probe3field = controlP5.addTextfield("Probe 3")
       .setPosition(field1StartX,field1StartY + 2*(fieldSizeY + 1*fieldSpaceY))
       .setSize(fieldSizeX,fieldSizeY)
       .setFont(TitleFont)
       .setFocus(true)
       .setColor(color(0,0,255));
       
    savebutton = controlP5.addButton("Save_Data")
       .setValue(0.0)
       .setPosition(field1StartX,560)
       .setSize(fieldSizeX,fieldSizeY);
    
    restartbutton = controlP5.addButton("Restart_Acquisition")
       .setValue(0.0)
       .setPosition(field1StartX,520)
       .setSize(fieldSizeX,fieldSizeY);
}

void Save_Data(){
  if (debugcount>0){
    output.flush(); // Writes the remaining data to the file
    output.close(); // Finishes the file
    println("noooooooooooooooooooooo");
  }
}

void Restart_Acquisition(){
  output = createWriter("temps.txt");
  output.println("Datetime, probe1, probe2, probe3");
}
