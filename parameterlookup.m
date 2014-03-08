function parameterlookup(block)
% C Johan K�llstr�m
setup(block);



function setup(block)

  % Register number of ports
  block.NumInputPorts  = 1;%change here
  block.NumOutputPorts = 1;
  
  % Setup port properties to be inherited or dynamic
  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  params=block.DialogPrm(1).Data;

  [n,m]=size(params);
  
  block.InputPort(1).Dimensions        = 1;
  block.InputPort(1).DirectFeedthrough = true;
  block.OutputPort(1).Dimensions        = n;
  
  % Register parameters
  block.NumDialogPrms     = 2;

  % Register sample times
  block.SampleTimes = [block.DialogPrm(2).Data 0];
  
  %
  block.RegBlockMethod('PostPropagationSetup', @DoPostPropSetup);
  block.RegBlockMethod('InitializeConditions', @InitializeConditions);
  block.RegBlockMethod('Outputs', @Outputs);

%endfunction


function DoPostPropSetup(block)

  %% Setup Dwork  
  block.NumDworks = 0;
%endfunction


function InitializeConditions(block)

%endfunction


function Outputs(block)
  params=block.DialogPrm(1).Data;
  x=block.InputPort(1).Data;
  un=params(x,:);%change here
  block.OutputPort(1).Data = un;
  
%endfunction

