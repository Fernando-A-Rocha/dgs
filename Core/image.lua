function dgsCreateImage(x,y,sx,sy,img,relative,parent,color)
	assert(tonumber(x),"Bad argument @dgsCreateImage at argument 1, expect number got "..type(x))
	assert(tonumber(y),"Bad argument @dgsCreateImage at argument 2, expect number got "..type(y))
	assert(tonumber(sx),"Bad argument @dgsCreateImage at argument 3, expect number got "..type(sx))
	assert(tonumber(sy),"Bad argument @dgsCreateImage at argument 4, expect number got "..type(sy))
	if isElement(parent) then
		assert(dgsIsDxElement(parent),"Bad argument @dgsCreateImage at argument 7, expect dgs-dxgui got "..dgsGetType(parent))
	end
	local image = createElement("dgs-dximage")
	dgsSetType(image,"dgs-dximage")
	local texture = img
	if type(img) == "string" then
		texture = dxCreateTexture(img)
		if not isElement(texture) then return false end
	end
	dgsSetData(image,"image",texture)
	dgsSetData(image,"color",color or tocolor(255,255,255,255))
	dgsSetData(image,"rotationCenter",{0,0}) --0~1
	dgsSetData(image,"rotation",0) --0~360
	local _x = dgsIsDxElement(parent) and dgsSetParent(image,parent,true,true) or table.insert(CenterFatherTable,1,image)
	insertResourceDxGUI(sourceResource,image)
	calculateGuiPositionSize(image,x,y,relative or false,sx,sy,relative or false,true)
	local mx,my = false,false
	if isElement(texture) and not getElementType(texture) == "shader" then
		mx,my = dxGetMaterialSize(texture)
	end
	dgsSetData(image,"imageUVSize",{mx,my})
	dgsSetData(image,"imageUVPos",{0,0})
	triggerEvent("onDgsCreate",image)
	return image
end

function dgsImageGetImage(gui)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageGetImage at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	return dgsElementData[gui].image
end

function dgsImageSetImage(gui,img)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageSetImage at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	return dgsSetData(gui,"image",img)
end

function dgsImageSetUVSize(gui,sx,sy)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageSetUVSize at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	local texture = dgsGetData(gui,"image")
	local mx,my = dxGetMaterialSize(texture)
	sx = tonumber(sx) or mx
	sy = tonumber(sy) or my
	return dgsSetData(gui,"imageUVSize",{sx,sy})
end

function dgsImageGetUVSize(gui)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageGetUVSize at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	return dgsElementData[gui].imageUVSize[1],dgsElementData[gui].imageUVSize[2]
end

function dgsImageSetUVPosition(gui,x,y)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageSetUVPosition at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	x = tonumber(x) or 0
	y = tonumber(y) or 0
	return dgsSetData(gui,"imageUVPos",{x,y})
end

function dgsImageGetUVPosition(gui,x,y)
	assert(dgsGetType(gui) == "dgs-dximage","Bad argument @dgsImageGetUVPosition at argument 1, expect dgs-dximage got "..(dgsGetType(gui) or type(gui)))
	return dgsElementData[gui].imageUVPos[1],dgsElementData[gui].imageUVPos[2]
end