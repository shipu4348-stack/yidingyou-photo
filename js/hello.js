<!-- 
var tx8hello=""; day = new Date( ); time = day.getHours( ); 
if (( time>=0) && (time < 4 )) 
 tx8hello="注意身体喔!" 
if (( time >= 4 ) && (time < 12)) 
 tx8hello="早上好," 
if (( time >= 12) && (time < 14)) 
 tx8hello="午饭了吗?" 
if (( time >=14) && (time < 17)) 
 tx8hello="下午好," 
if (( time >=17) && (time < 19)) 
 tx8hello="快去补充体力,准备战斗!" 
if ((time >= 19) && (time <= 23)) 
 tx8hello="加油喔,销售黄金时段!" 
if ((time >= 23) && (time < 24)) 
 tx8hello="打佯喽,休息-休息-休息!" 
document.write(tx8hello) 
//---> 