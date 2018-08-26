# verilog_frog_game

我這一個期末專題式作青蛙過河的這一個遊戲,一開始先用手動開關reset,讓遊戲的資料初始化,我的遊戲是有兩隻青蛙可以同時競賽,用18顆LED燈來代表障礙物與青蛙一與青蛙二的位置,每隻青蛙都有三條命,以LED燈亮三顆顯示,若青蛙在過河的時候撞到障礙物則返回原點並且減一條命,以LED少亮一顆顯示,若青蛙度過重重難關過河成功則四顆LED燈都會全亮,代表贏家,

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_1.JPG)

全觀圖:

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_2.JPG)

初始化後每隻青蛙(左右各一隻)都有三條命:

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_3.JPG)

當青蛙撞到障礙物後會退回原點並少一條命(少亮一燈):

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_4.JPG)

當成功過河後過河的青蛙四燈全亮,還沒過河的青蛙四燈全滅:

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_5.JPG)

亂數產生的障礙(燈亮為障礙):

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/board_6.JPG)

Back_1:第一隻青蛙後退一格

Back_2:第二隻青蛙後退一格

Clk:50MHZ的時脈

Go_1:第一隻青蛙前進一格

Go_1:第二隻青蛙前進一格

Light_1[3:0]:第一隻青蛙的生命,預設是三條命(三個燈亮)

Light_2[3:0]:第二隻青蛙的生命,預設是三條命(三個燈亮)

Outview[17:0]:實際的18顆LED燈的閃滅(青蛙1+青蛙2+障礙物)

Rst:重設或初始化,(障礙物開始閃,青蛙都變成三條命)

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/pin.JPG)

全觀圖:具有障礙物位置與青蛙1與青蛙2位置波形圖,比較好debug

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_1.JPG)

障礙物之亂數波形

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_2.JPG)

Go_1按鈕以0.7ns為周期之青蛙1 的位置表現圖

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_3.JPG)

Go_2按鈕以剛好符合不撞到障礙物的方式按下的青蛙2位置波形圖

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_4.JPG)

燈圖:可見青蛙1 撞到三次障礙物後燈全滅,青蛙2則是撞到一次障礙物後到達終點,所以最後亮四燈

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_5.JPG)

Outview則是把frog_1與frog_2與block一起接或閘之後的結果,也是實際燒到板子上面的燈圖波形

![image](https://github.com/KuiLiangLin/verilog_frog_game/blob/master/Waveform_6.JPG)






