%% 向格子里面填数字
test = 5; % 生成test个不同情况的数独
table = createTable();
for k = 1:test
    example = "numIndex_"+num2str(k)+".xls";
    data=xlsread(example);
    for i = 1:length(data)
        x = data(i,1);
        y = data(i,2);
        num = data(i,3);
        serial = serialNumber(num);
        img = imread("train/"+int2str(num)+"_" +int2str(serial)+".bmp");
        FillImg = processNum(img, i);
        [rowIndex,colIndex] = Index_Sudo(x,y);
        for m = 1:28
            for n = 1:28
                table(rowIndex+m,colIndex+n) = FillImg(m,n);
            end
        end
    end
    imshow(table);
    imwrite(table, "input_"+num2str(k)+".jpg");
end
