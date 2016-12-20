
-- Function #0
GetInheritJob = function(job)
	JobInheritTable = nil
	JobInheritTable = {}
	if job == nil then
		return nil
	end
	while job ~= nil do
		JobInheritTable[i + 1] = job
		job = JOB_INHERIT_LIST[job]
		i = i + 1
	end
	return i
	local i = 0
end
All_NeedSkillList = {}

-- Function #1
CheckNeedSkillList = function(skillInfo, skillDepth)
	if All_NeedSkillList ~= nil and skillInfo ~= nil then
		while not(All_NeedSkillList[depth] == false) do
			local idx = 1
			t_skillInfo = All_NeedSkillList[depth][idx]
			while not(t_skillInfo == false) do
				if t_skillInfo[1] == skillInfo[1] then
					if depth < skillDepth then
						return false
					elseif t_skillInfo[2] < skillInfo[2] then
						All_NeedSkillList[depth][idx] = skillInfo
					end
					return true
				end
				idx = idx + 1
				t_skillInfo = All_NeedSkillList[depth][idx + 1]
			end
			depth = depth + 1
		end
		local depth = 0
	end
	return false
end

-- Function #2
SetNeedSkillList = function(SKID, depth)
	local skillInfo = SKILL_INFO_LIST[SKID]
	if skillInfo ~= nill then
		local bIsNeedSkillList = false
		local needSkillList = skillInfo.NeedSkillList
		if needSkillList ~= nil then
			for j, k in pairs(JobInheritTable) do
				local jobID = JOB_INHERIT_LIST2[k]
				if jobID ~= -1 and jobID ~= nil then
				elseif needSkillList[k] ~= nil then
					bIsNeedSkillList = true
					needSkillList = needSkillList[k]
					break
				else
					-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 3_[26]
				end
			end
			if bIsNeedSkillList == false then
				needSkillList = skillInfo._NeedSkillList
			end
			if needSkillList ~= nil then
				for j, k in pairs(needSkillList) do
					if CheckNeedSkillList(k, depth) == false then
						if All_NeedSkillList[depth] == nil then
							All_NeedSkillList[depth] = {}
							All_NeedSkillList[depth][getTableSize(All_NeedSkillList[depth]) + 1] = k
							SetNeedSkillList(k[1], idx)
						else
						end
					else
						-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 3_[67]
					end
				end
			end
		end
		-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 3_[28]
	else
	end
	goto 3_[69]
end

-- Function #3
GetSkillInfo = function(SKID)
	All_NeedSkillList = nil
	All_NeedSkillList = {}
	local skillInfo = SKILL_INFO_LIST[SKID]
	if skillInfo ~= nill then
		local strSkillID = skillInfo[1]
		local strSkillName = skillInfo.SkillName
		local MaxLv = skillInfo.MaxLv
		local UserUpgradable = 1
		if skillInfo.Type ~= "Quest" then
			if skillInfo.Type == "Soul" then
				UserUpgradable = 0
			end
			SetNeedSkillList(SKID, 0)
			return strSkillID, strSkillName, MaxLv, UserUpgradable
		end
		-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 4_[19]
	end
	return "", "", -1, -1
end

-- Function #4
AddNeedSkillList = function(SKID)
	if All_NeedSkillList ~= nil then
		while not(All_NeedSkillList[depth] == false) do
			local idx = 1
			skillInfo = All_NeedSkillList[depth][idx]
			while not(skillInfo == false) do
				if skillInfo[2] == nil then
					skillInfo[2] = 0
				end
				c_AddNeedSkillList(SKID, skillInfo[1], skillInfo[2])
				idx = idx + 1
				skillInfo = All_NeedSkillList[depth][idx + 1]
			end
			depth = depth + 1
		end
		local depth = 0
	end
end

-- Function #5
InitSkillTreeView = function(jobID, arrayNum)
	local skillList = SKILL_TREEVIEW_FOR_JOB[jobID]
	if skillList ~= nil then
		local skillPos = 0
		while 0 < listSize do
			local skillID = skillList[skillPos]
			if skillID ~= nil then
				local strSkillID = GetSkillInfo(skillID)
				local strSkillName = skillList[skillPos]
				if strSkillID ~= nil and strSkillID ~= "" then
					c_AddSkillList(arrayNum, skillID, strSkillID, skillPos, MaxLv, UserUpgradable)
					AddNeedSkillList(skillID)
				end
				listSize = listSize - 1
			end
			skillPos = skillPos + 1
		end
		local listSize = getTableSize(skillList)
	end
end

-- Function #6
GetSkillIdName = function(SkillID)
	local obj = SKILL_INFO_LIST[SkillID]
	if obj ~= nil then
		obj = SKILL_INFO_LIST[SkillID][1]
	end
	if obj ~= nil then
		return obj
	end
	return ""
end

-- Function #7
GetSkillName = function(SkillID)
	local obj = SKILL_INFO_LIST[SkillID]
	if obj ~= nil then
		obj = SKILL_INFO_LIST[SkillID].SkillName
	end
	if obj ~= nil then
		return obj
	end
	return ""
end

-- Function #8
IsLevelUseSkill = function(SkillID)
	local skillInfo = SKILL_INFO_LIST[SkillID]
	local rst = nil
	if skillInfo ~= nil then
		rst = skillInfo.bSeperateLv
		if rst ~= nil then
			return rst
		else
			local spAmount = skillInfo.SpAmount
			if spAmount ~= nil then
				return true
			end
		end
	end
	return false
end

-- Function #9
GetLevelUseSpAmount = function(SkillID, idx)
	local obj = SKILL_INFO_LIST[SkillID]
	if obj ~= nil then
		obj = SKILL_INFO_LIST[SkillID].SpAmount
	end
	if obj ~= nil then
		obj = SKILL_INFO_LIST[SkillID].SpAmount[idx]
	end
	if obj ~= nil then
		return obj
	end
	return 0
end

-- Function #10
GetSkillDescript = function(JobID, SKID, bChangeColor)
	local descript = ""
	local obj = SKILL_DESCRIPT[SKID]
	if obj ~= nil then
		for i, v in pairs(obj) do
			s_pos, f_pos = string.find(v, MsgStrID.MSI_SKILL_REQUIREMENTS)
			bCopyText = false
			if s_pos ~= nil then
				s_pos = s_pos - 1
				subStr = string.sub(v, 1, s_pos - 1)
				if bChangeColor == 1 then
					local temp = subStr .. "^FF1493" .. string.sub(v, s_pos + 7, -1)
				end
				if 1 < s_pos then
				else
					bCopyText = true
					while not(bCopyText == true) do
						-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 11_[91]
					end
					descript = descript .. v
					descript = descript .. "\r\n"
				end
			else
				bCopyText = true
				-- GRF Editor Decompiler : CodeReconstructor has failed to identify the usage of this goto 11_[81]
			end
		end
	end
	return descript
end

-- Function #11
TestFile = function(saveFileName)
	saveFile = io.open(saveFileName, "w")
	if saveFile ~= nil and All_NeedSkillList ~= nil then
		while not(All_NeedSkillList[depth] == false) do
			local idx = 1
			skillInfo = All_NeedSkillList[depth][idx]
			while not(skillInfo == false) do
				saveFile:write(string.format("[%d,%d]\n", skillInfo[1], skillInfo[2]))
				idx = idx + 1
				skillInfo = All_NeedSkillList[depth][idx + 1]
			end
			depth = depth + 1
		end
		local depth = 0
	end
	io.close(saveFile)
end

-- Function #12
GetSkillAttackRange = function(in_SKID, in_Level, in_curMaxLv)
	local attackRange = 1
	local attackRangeOfMaxLv = 0
	local maxLv = 0
	local obj = SKILL_INFO_LIST[in_SKID]
	if obj ~= nil then
		maxLv = SKILL_INFO_LIST[in_SKID].MaxLv
		obj = SKILL_INFO_LIST[in_SKID].AttackRange
	end
	if obj ~= nil then
		attackRange = SKILL_INFO_LIST[in_SKID].AttackRange[in_Level]
	end
	if maxLv ~= nil and maxLv < in_curMaxLv then
		in_curMaxLv = SKILL_INFO_LIST[in_SKID].MaxLv
	end
	attackRangeOfMaxLv = SKILL_INFO_LIST[in_SKID].AttackRange[in_curMaxLv]
	if attackRangeOfMaxLv == nil then
		attackRangeOfMaxLv = 0
	end
	if attackRange ~= nil then
		return attackRange, attackRangeOfMaxLv
	end
	return 1, attackRangeOfMaxLv
end
