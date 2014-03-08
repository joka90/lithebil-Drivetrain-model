function mypidcontroller(block)
% A Level 2 M-file S-function that contains a discrete-time implementation
% of a PID controller.

% By Martin Enqvist, 2008-02-05, 2009-11-30

setup(block);
  
%endfunction


function setup(block)

  % Register number of ports
  block.NumInputPorts  = 5;
  block.NumOutputPorts = 1;
  
  % Setup port properties to be inherited or dynamic
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = true;
  block.InputPort(2).Dimensions        = 1;
  block.InputPort(2).DirectFeedthrough = true;
  
  % Register parameters
  block.NumDialogPrms     = 5;

  % Register sample times
  block.SampleTimes = [block.DialogPrm(3).Data 0];
  
  %
  block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
  block.RegBlockMethod('InitializeConditions', @InitializeConditions);
  block.RegBlockMethod('Outputs', @Outputs);
  block.RegBlockMethod('Update', @Update);

%endfunction


function DoPostPropSetup(block)

  %% Setup Dwork  
  block.NumDworks = 1;
  block.Dwork(1).Name = 'X';
  block.Dwork(1).Dimensions      = block.DialogPrm(4).Data;
  block.Dwork(1).DatatypeID      = 0;
  block.Dwork(1).Complexity      = 'Real';
  block.Dwork(1).UsedAsDiscState = true;
  
%endfunction


function InitializeConditions(block)
block.Dwork(1).Data = zeros(block.DialogPrm(4).Data,1);
%endfunction


function Outputs(block)
  ctrlparam = block.DialogPrm(1).Data;
  ubounds = block.DialogPrm(2).Data;
  Ts=block.DialogPrm(3).Data;
  fname=block.DialogPrm(5).Data; 
  xn_1=block.Dwork(1).Data;
  umann=block.InputPort(1).Data;
  amn=block.InputPort(2).Data;
  rn=block.InputPort(3).Data;
  yn=block.InputPort(4).Data;
  ctrlselector=block.InputPort(5).Data;
  [un,xn]=feval(fname,umann,amn,rn,yn,xn_1,ctrlparam(:,ctrlselector),ubounds,Ts);
  block.OutputPort(1).Data = un;
  
%endfunction


function Update(block)
  ctrlparam = block.DialogPrm(1).Data;
  ubounds = block.DialogPrm(2).Data;
  Ts=block.DialogPrm(3).Data;
  fname=block.DialogPrm(5).Data; 
  xn_1=block.Dwork(1).Data;
  umann=block.InputPort(1).Data;
  amn=block.InputPort(2).Data;
  rn=block.InputPort(3).Data;
  yn=block.InputPort(4).Data;
  ctrlselector=block.InputPort(5).Data;
  [un,xn]=feval(fname,umann,amn,rn,yn,xn_1,ctrlparam(:,ctrlselector),ubounds,Ts);
  block.Dwork(1).Data = xn;
  
%endfunction

