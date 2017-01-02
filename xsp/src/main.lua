
local bb = require("badboy") 
bb_Json = bb.getJSON();
bb.loadutilslib();

--task
needChooseServicePoint = true;
needDoLogin = true;

function main ()
  init("0", 0);
  mSleep(200);
  require("util");
  require("judge");
	require("deal");
	
	--创建一个队列，用于保存需要完成的任务， 在下面的循环里面每隔5秒钟开启队列中的第一个任务
	--任务完成之后需要从队列里面移除，直到全部完成之后，结束程序
	
	
	local step = 1;
	while true do 
	
		if needChooseServicePoint then
		sysLog("-------选择服务点------------");
			chooseServicePoint("芙蓉区", "新安小区服务点");
		end
		
		if needDoLogin then
			sysLog("-------登录------------");

			doLogin();
		end
		
		mSleep(5000);
	
	end
end


-- lua异常捕捉
function error(msg)
  local errorMsg = "[Lua error]"..msg
  printFunction(errorMsg)    
end

--退出时隐藏HUD
function beforeUserExit()
  hideHUD(runing)
  hideHUD(troopsDonated)
end

main();
--xpcall(main, error)
