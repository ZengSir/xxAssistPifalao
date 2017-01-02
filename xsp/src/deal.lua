--进行登录操作
function doLogin() 
  
  if not isPage("登录")  then
    --当前页面不是登录页面，等待5秒再判断
    mSleep(5000);
    doLogin();
  end
  
  --输入用户名
	tap(938, 514);
  
  inputText("#CLEAR#");
  inputText("18873203424");
  
  --输入密码
	tap(938, 637);
  
  inputText("#CLEAR#");
  inputText("123456");
  
  --选择自动登录
  if getColor(72,766) ~= 0xff9900 then 
	
		tap(72,766);
  end
  
  --找到登录按钮， 点击登录
	tap(547,960);
  
  --判断是否操作成功
  needDoLogin = false;
end


function chooseServicePoint (areaName,servicePointName) 
  
  if not isPage("选择服务点") then
    --当前页面不是选择服务点页面，等待5秒再判断
    mSleep(5000);
    chooseServicePoint(areaName,servicePointName);
  end
  
  sysLog("开始点击区域:"..areaName);
  if tapAreaPosition(areaName) then 
    mSleep(1000);
		sysLog("开始点击服务点");

    if not tapServicePointPositon(servicePointName) then

      sysLog("未找到"..servicePointName);
		else
			needChooseServicePoint = false;
    end
		
  else
    sysLog("未找到"..areaName);
  end
end

--选择区域
function tapAreaPosition (areaName)
  
  local areaLines = {};
  --芙蓉区
  areaLines[1] = '0C0180300600C0180300600C1FFFFFFFF0E0180300600C2184308600C0180387FFFFFFFC300600C0180300600C01803000000000000000000704E19C338670CE19C338670FF9FF3FE670CE19C339673CE79CF38670CE19C3FE7FCFF99C338670CE19C338670CE19C300000000000000000003FF7FEFFDC0380700E01C338671EE1DC1B81700E01C0380700E01C0380700E05C1B8F71EE39C2380700E01C0380$芙蓉区$0.1.1523$37';
  areaLines[2] = '0C0180300600C0180300600C03C3FFFFF0C0180300600C0180300600C0180307FFFFE3C0300600C0180300600C01803000000000000000000700E09C1382704E09C1382707F8FF1FE2704E09C139273CE79CF386704E09C1FE3FC7F89C1382704E09C1382704E09C100000000000000000000007FEFFDC0380700E01C038670EE0DC1B81700E01C0380700E01C0380700E01C1B8771EE19C0380700E01C0180$芙蓉区$0.1.1226$36';
  local areaDict = createOcrDict(areaLines);
  local areaResult = ocrText(areaDict, 1,1065,288,1918, {"0x999999-0x202020"}, 95, 1, 0);
	
  printTable(areaResult);
  for i,v in pairs(areaResult) do
    if v.text == areaName then
      tap(v.x, v.y);--点击
      return true;
    end
  end
	
	areaResult = ocrText(areaDict, 1,1065,288,1918, {"0x4ab134-0x202020"}, 95, 1, 0);
	printTable(areaResult);
  for i,v in pairs(areaResult) do
    if v.text == areaName then
      tap(v.x, v.y);--点击
      return true;
    end
  end
  
  return false;
end


function tapServicePointPositon(servicePointName)
sysLog("开始选择服务点:"..servicePointName);
  --选择服务点
  local servicePointLines = {};
  
  --新安小区服务点
  servicePointLines[1] = '0E01C03807E0FF1FFFBFF0FE0FC0780730FE1FC3F87C0E01C0000001FE3FC7F8E03C0780F01C0380701E03C0780E00C0080000000000000FE1FC3F87F0E01C0380700E01C0380700E01CC3BEF7FE7FCBF83F01E01C0380700E01C0380700E01C0380700FE1FC3F87F00000000000000000000000000000000000E01C0380300000000000000003FFFFFFFE000000000000000100300E01C018000000000000000000000000000000000007FEFFDFFBC0780F01E13C779EF1DE1BC3782F01E03C0780F01E03C0780F01E0BC779EF3DE3BC4780F01E03C07800000000000000000000000FFDFFBFF7FEE05C0B81702E05E0BFF7FEFFC00000000FFDFFBFF7FEE01C0380700E05C0B81702E05FFBFF7FEF0000000000000000000000000000300E03C0F83F1FCFFFFFFF7FE7BCC388700E01C0380700E01C4388730EE1FC3F87E0F81E0$新安小区服务点$2.14.3468$37';
  local servicePointDict = createOcrDict(servicePointLines);
  
  --最多向上滑动屏幕6次
	
	for tmpi=1,6 do
            
    local servicePointResult = ocrText(servicePointDict, 364,1061,981,1901, {"0x2a2a2a-0x202020"}, 95, 1, 0);
    
    sysLog("服务点文字识别的结果");
    printTable(servicePointResult);
    
    for i,v in pairs(servicePointResult) do
      if v.text == servicePointName then
        tap(v.x, v.y);--点击
        return true;
      end
    end
    
    --向上滑动
    swip(705,1912, 705,1077);
  end
  
  return false;
end
